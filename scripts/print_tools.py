#!/usr/bin/env python3
"""Export and verify an OpenSCAD print project (skill openscad-print-project).

Project settings and project-specific checks live in print_project.py in the project root;
this script stays identical to the skill copy.

  build   export print parts, multicolour pieces and assembly bodies into build/
  check   build, then run every check; the STL folders and the report stay untouched
  export  check, then replace the STL folders, asm/ and the report with the verified exports

Dependencies: OpenSCAD on PATH, scripts/requirements.txt.
"""
import argparse
import ast
from concurrent.futures import ThreadPoolExecutor
import hashlib
import importlib.metadata
import itertools
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
from types import SimpleNamespace

import manifold3d as md
import numpy as np
import trimesh


def find_root():
    for base in (Path(__file__).resolve().parents[1], Path.cwd()):
        if (base / "print_project.py").exists():
            return base
    sys.exit("print_project.py not found: expected in the project root (parent of scripts/) or the working directory")


ROOT = find_root()
sys.path.insert(0, str(ROOT))
import print_project as P  # noqa: E402

BUILD = ROOT / "build"
SOURCE = ROOT / P.SOURCE
# name -> (quantity in the full build, material, body count); quantity 0 = optional test print
PARTS = P.PARTS
# assembly body -> OpenSCAD call in installed position
ASSEMBLY = getattr(P, "ASSEMBLY", {})
# part -> inlay names; the model needs branches <part>_base and <part>_<inlay> in print orientation
COLOR_PARTS = getattr(P, "COLOR_PARTS", {})
COLOR_PIECES = [f"{name}_{piece}" for name, inlays in COLOR_PARTS.items() for piece in ("base", *inlays)]
NON_PRINT_BRANCHES = set(getattr(P, "NON_PRINT_BRANCHES", ("assembly", "exploded", "metrics", "none")))
STL_DIR = ROOT / getattr(P, "STL_DIR", "stl")
COLOR_DIR = ROOT / getattr(P, "COLOR_DIR", "stl/multicolour")
ASM_DIR = ROOT / getattr(P, "ASM_DIR", "asm")
REPORT = ROOT / getattr(P, "REPORT", "docs/verification.json")
ENVELOPE = getattr(P, "PRINTER", {}).get("envelope_mm", (256, 256, 256))
INLAY_MAX_DEPTH = getattr(P, "INLAY_MAX_DEPTH", 1.0)
OVERLAP_MM3 = 0.01


def save(name, data):
    path = BUILD / name
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")


def scad(args):
    executable = shutil.which("openscad")
    if not executable:
        raise RuntimeError("OpenSCAD not found on PATH")
    result = subprocess.run([executable, "--hardwarnings", *args], capture_output=True, text=True, cwd=BUILD)
    if result.returncode:
        raise RuntimeError(result.stdout + result.stderr)
    return result.stdout + result.stderr


def manifold(mesh):
    solid = md.Manifold(md.Mesh(np.asarray(mesh.vertices, dtype=np.float32),
                               np.asarray(mesh.faces, dtype=np.uint32)))
    if solid.status() != md.Error.NoError:
        raise ValueError(f"Invalid manifold: {solid.status()}")
    return solid


def mesh_info(mesh):
    return {
        "size_mm": mesh.extents.round(4).tolist(),
        "bounds_mm": mesh.bounds.round(4).tolist(),
        "volume_mm3": round(float(mesh.volume), 4),
        "triangles": len(mesh.faces),
        "watertight": bool(mesh.is_watertight),
        "consistent_winding": bool(mesh.is_winding_consistent),
        "degenerate_faces": int(np.sum(mesh.area_faces < 1e-9)),
        "components": len(mesh.split(only_watertight=False)),
    }


def valid_mesh(info):
    return (info["watertight"] and info["consistent_winding"]
            and info["degenerate_faces"] == 0 and info["volume_mm3"] > 0)


def export_one(job):
    group, name, code = job
    folder = BUILD / group
    folder.mkdir(parents=True, exist_ok=True)
    src = SOURCE
    if code:
        src = folder / f"{name}.scad"
        src.write_text(f"include <{SOURCE.as_posix()}>\n{code}\n")
    path = folder / f"{name}.stl"
    # CGAL now and then yields a degenerate triangle that does not reproduce, hence a second CGAL attempt
    for backend in ("Manifold", "CGAL", "CGAL"):
        log = scad([f"--backend={backend}", "--export-format", "binstl", "-D",
                    f'part="{"none" if code else name}"', "-o", str(path), str(src)])
        (folder / f"{name}-{backend}.log").write_text(log)
        mesh = trimesh.load_mesh(path)
        info = mesh_info(mesh)
        if valid_mesh(info):
            manifold(mesh)
            break
    if not valid_mesh(info):
        raise ValueError(f"Invalid export {name}: {info}")
    info["backend"] = backend
    info["sha256"] = hashlib.sha256(path.read_bytes()).hexdigest()
    if group == "print":
        qty, material, components = PARTS[name]
        assert info["components"] == components, (name, "Wrong body count", info)
        assert abs(mesh.bounds[0, 2]) < 0.002, (name, "Not on print bed")
        assert np.all(mesh.extents <= ENVELOPE), (name, f"Exceeds the build volume {ENVELOPE}")
        info.update(quantity=qty, material=material)
    if group == "color":
        assert abs(mesh.bounds[0, 2]) < 0.002, (name, "Not on print bed")
    return group, name, info


def check_part_manifest():
    names = set(re.findall(r'part\s*==\s*"(\w+)"', SOURCE.read_text())) - NON_PRINT_BRANCHES
    assert set(COLOR_PIECES) <= names, f"Multicolour branches missing: {sorted(set(COLOR_PIECES) - names)}"
    names -= set(COLOR_PIECES)
    assert names == set(PARTS), f"PARTS differs from {P.SOURCE}: {sorted(names ^ set(PARTS))}"


def build(only=None):
    jobs = [("print", name, None) for name in PARTS]
    jobs += [("assembly", name, code) for name, code in ASSEMBLY.items()]
    jobs += [("color", name, None) for name in COLOR_PIECES]
    if only:
        unknown = set(only) - {name for _, name, _ in jobs}
        assert not unknown, f"Unknown names for --only: {sorted(unknown)}"
        jobs = [job for job in jobs if job[1] in only]
    results = {"print": {}, "assembly": {}, "color": {}}
    with ThreadPoolExecutor(max_workers=getattr(P, "WORKERS", 4)) as pool:
        for group, name, info in pool.map(export_one, jobs):
            results[group][name] = info
            print(f"Export {group}/{name}: closed, {info['backend']}", flush=True)
    save("meshes.json", results)
    return results


def get_metrics():
    """part="metrics" echoes METRICS_TAG followed by a list of [key, value] pairs."""
    tag = getattr(P, "METRICS_TAG", None)
    if not tag:
        return {}
    path = BUILD / "metrics.echo"
    scad(["-D", 'part="metrics"', "-o", str(path), str(SOURCE)])
    line = next(line for line in path.read_text().splitlines() if f'"{tag}", ' in line)
    text = line.split(f'"{tag}", ', 1)[1]
    # OpenSCAD literals Python does not know (outside the key strings)
    parts = re.split(r'("[^"]*")', text)
    for i in range(0, len(parts), 2):
        parts[i] = re.sub(r"\btrue\b", "True", parts[i])
        parts[i] = re.sub(r"\bfalse\b", "False", parts[i])
        parts[i] = re.sub(r"\bundef\b", "None", parts[i])
    return dict(ast.literal_eval("".join(parts)))


def check_collisions(solids):
    allowed = {frozenset(pair) for pair in getattr(P, "ALLOWED_OVERLAPS", ())}
    collisions = []
    for a, b in itertools.combinations(solids, 2):
        if frozenset((a, b)) in allowed:
            continue
        cut = solids[a] ^ solids[b]
        volume = cut.volume()
        if volume > OVERLAP_MM3:
            collisions.append(dict(a=a, b=b, volume_mm3=round(volume, 4), bounds=list(cut.bounding_box())))
    save("collisions.json", collisions)
    assert not collisions, f"Unexpected intersections: {collisions}"
    return collisions


def union(solids, names):
    return md.Manifold.batch_boolean([solids[n] for n in names], md.OpType.Add)


def sweep(solids, moving, fixed, direction, length, step):
    """Move the union of `moving` along `direction` in steps; returns (colliding steps, first distance, max volume)."""
    moving, fixed = union(solids, moving), union(solids, fixed)
    maximum, first, count = 0, None, 0
    for distance in np.arange(0, length + step / 2, step):
        volume = (moving.translate((np.array(direction) * distance).tolist()) ^ fixed).volume()
        if volume > OVERLAP_MM3:
            count += 1
            first = float(distance) if first is None else first
            maximum = max(maximum, volume)
    return count, first, maximum


def check_color_parts():
    """Base and inlays do not overlap, together they are the single-colour part, inlays stay in the first layers."""
    report = {}
    for name, inlays in COLOR_PARTS.items():
        full = manifold(trimesh.load_mesh(BUILD / "print" / f"{name}.stl"))
        meshes = {piece: trimesh.load_mesh(BUILD / "color" / f"{name}_{piece}.stl") for piece in ("base", *inlays)}
        solids = {piece: manifold(mesh) for piece, mesh in meshes.items()}
        overlap = sum((solids[a] ^ solids[b]).volume() for a, b in itertools.combinations(solids, 2))
        joined = solids["base"]
        for piece in inlays:
            joined = joined + solids[piece]
        delta = (full - joined).volume() + (joined - full).volume()
        assert overlap <= OVERLAP_MM3, f"{name}: multicolour pieces overlap by {overlap:.3f} mm3"
        assert delta <= max(0.5, full.volume() * 1e-5), f"{name}: pieces differ from the single-colour part by {delta:.3f} mm3"
        info = dict(overlap_mm3=round(overlap, 4), union_delta_mm3=round(delta, 4))
        for piece in inlays:
            mesh = meshes[piece]
            depth = float(mesh.bounds[1, 2])
            assert mesh.volume > 1 and depth <= INLAY_MAX_DEPTH, \
                f"{name}_{piece}: inlay missing or deeper than the first layers ({depth} mm)"
            info[piece] = dict(mm3=round(float(mesh.volume), 2), depth_mm=round(depth, 3),
                               bodies=len(mesh.split(only_watertight=False)))
        report[name] = info
    return report


def label(folder, name):
    try:
        prefix = folder.relative_to(STL_DIR).as_posix()
    except ValueError:
        prefix = folder.relative_to(ROOT).as_posix()
    return name if prefix == "." else f"{prefix}/{name}"


def check_committed_stls():
    folders = [(STL_DIR, "print", list(PARTS))]
    if COLOR_PIECES:
        folders.append((COLOR_DIR, "color", COLOR_PIECES))
    differences = {}
    for folder, group, names in folders:
        actual = {p.stem for p in folder.glob("*.stl")}
        assert actual == set(names), f"Missing/stale STL names in {folder.relative_to(ROOT)}: {sorted(actual ^ set(names))}"
        for name in names:
            old = trimesh.load_mesh(folder / f"{name}.stl")
            new = trimesh.load_mesh(BUILD / group / f"{name}.stl")
            assert valid_mesh(mesh_info(old)), f"Invalid committed STL: {folder.relative_to(ROOT)}/{name}"
            a, b = manifold(old), manifold(new)
            delta = (a - b).volume() + (b - a).volume()
            assert delta <= max(0.01, new.volume * 1e-7), f"Stale STL: {folder.relative_to(ROOT)}/{name}, delta={delta}"
            differences[label(folder, name) if group == "color" else name] = round(delta, 6)
    return differences


def replace_folder(folder, group, names, prune=True):
    folder.mkdir(parents=True, exist_ok=True)
    for name in names:
        shutil.copy2(BUILD / group / f"{name}.stl", folder / f"{name}.stl")
    if prune:
        for path in folder.glob("*.stl"):
            if path.stem not in names:
                path.unlink()


def software():
    versions = {}
    for name in ("numpy", "trimesh", "manifold3d", "scipy", "rtree", "networkx"):
        try:
            versions[name] = importlib.metadata.version(name)
        except importlib.metadata.PackageNotFoundError:
            pass
    return versions


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("command", choices=("build", "check", "export"))
    parser.add_argument("--only", help="build only: comma-separated part/body names for quick iteration")
    parser.add_argument("--strict", action="store_true", help="also fail on open items (e.g. unmeasured hardware)")
    args = parser.parse_args()
    if args.only and args.command != "build":
        parser.error("--only only works with build")
    BUILD.mkdir(exist_ok=True)
    (BUILD / "verification.json").unlink(missing_ok=True)
    check_part_manifest()
    results = build(args.only.split(",") if args.only else None)
    if args.command == "build":
        return
    meshes = {n: trimesh.load_mesh(BUILD / "assembly" / f"{n}.stl") for n in ASSEMBLY}
    solids = {n: manifold(mesh) for n, mesh in meshes.items()}
    metrics = get_metrics()
    collisions = check_collisions(solids)
    ctx = SimpleNamespace(root=ROOT, build=BUILD, metrics=metrics, meshes=meshes, solids=solids,
                          save=save, manifold=manifold, union=lambda names: union(solids, names),
                          sweep=lambda *a: sweep(solids, *a), summary=[], open_items=[])
    project = P.checks(ctx) if hasattr(P, "checks") else {}
    colors = check_color_parts()
    if args.command == "export":
        replace_folder(STL_DIR, "print", list(PARTS))
        if COLOR_PIECES:
            replace_folder(COLOR_DIR, "color", COLOR_PIECES)
        # asm/ may also hold meshes from other sources, so nothing is pruned there
        replace_folder(ASM_DIR, "assembly", list(ASSEMBLY), prune=False)
    consistency = check_committed_stls()
    for name, info in results["print"].items():
        info["committed_sha256"] = hashlib.sha256((STL_DIR / f"{name}.stl").read_bytes()).hexdigest()
    pairs = len(solids) * (len(solids) - 1) // 2
    report = dict(source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(), software=software(),
                  print_parts=len(PARTS), print_quantity=sum(q for q, _, _ in PARTS.values()),
                  print_meshes=results["print"], color_meshes=results["color"], color_parts=colors,
                  assembly_bodies=len(solids), assembly_pairs=pairs, metrics=metrics, intersections=collisions,
                  **project, stl_difference_mm3=consistency, open_measurements=ctx.open_items,
                  limitations=getattr(P, "LIMITATIONS", ["Hardware envelopes, not detailed vendor CAD",
                                                         "Sampled motion, no continuous swept-volume proof",
                                                         "No flexible deformation, physical fit, strength or thermal validation"]))
    save("verification.json", report)
    if args.command == "export":
        REPORT.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(BUILD / "verification.json", REPORT)
    for item in ctx.open_items:
        print(f"OPEN: {item}")
    print("PASS: " + ", ".join([f"{len(PARTS)} print meshes", f"{len(COLOR_PARTS)} multicolour parts",
                                *ctx.summary, f"{pairs} pairs"]))
    if args.strict and ctx.open_items:
        raise AssertionError("Open items (see OPEN lines)")


if __name__ == "__main__":
    try:
        main()
    except (AssertionError, RuntimeError, ValueError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        sys.exit(1)
