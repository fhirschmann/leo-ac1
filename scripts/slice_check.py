#!/usr/bin/env python3
"""Diagnostic Bambu Studio slicing and the multi-plate project 3MF (skill openscad-print-project).

1. Slices every print STL on its own with the installed system profiles (PRINTER, PROCESS, FILAMENTS in
   print_project.py): no supports, default infill, solid for FULL_INFILL parts and FULL_INFILL_MATERIALS.
2. Builds PROJECT_3MF: every part of the full build on the fixed PLATES, each plate centred; multicolour
   parts as one object per copy with their inlay filaments, parts at the left edge and the prime tower
   to their right. The multicolour plates are sliced to prove there is no conflict and the inlays print.

Generated G-code and 3MF files under build/ are diagnostics, NOT print releases.
Writes build/slicer-diagnostic/summary.json and SLICER_SUMMARY (default docs/slicer-summary.json).
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import re
import subprocess
import zipfile

from print_tools import BUILD, COLOR_DIR, COLOR_PARTS, P, PARTS, ROOT, STL_DIR

parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("--app", type=Path, default=Path("/Applications/BambuStudio.app"), help="macOS app bundle")
parser.add_argument("--exe", type=Path, help="Bambu Studio executable (overrides --app, e.g. on Linux)")
parser.add_argument("--profiles", type=Path, help="BBL system profile folder (overrides --app)")
args = parser.parse_args()
executable = args.exe or args.app / "Contents/MacOS/BambuStudio"
profile_root = args.profiles or args.app / "Contents/Resources/profiles/BBL"
out = BUILD / "slicer-diagnostic"
profiles = out / "profiles"
profiles.mkdir(parents=True, exist_ok=True)
files = {path.stem: path for path in profile_root.rglob("*.json")}

PRINTER = dict(machine="Bambu Lab H2S 0.4 nozzle", process="0.20mm Standard @BBL H2S",
               bed="Textured PEI Plate") | getattr(P, "PRINTER", {})
PROCESS = dict(wall_loops=4, top_shell_layers=5, bottom_shell_layers=5, infill=25,
               pattern="gyroid") | getattr(P, "PROCESS", {})
FULL_INFILL = set(getattr(P, "FULL_INFILL", ()))
FULL_INFILL_MATERIALS = set(getattr(P, "FULL_INFILL_MATERIALS", ("TPU",)))
# Filament slots of the project 3MF, 1-based in list order; inlay slots name their inlay
FILAMENTS = getattr(P, "FILAMENTS", None) or [dict(material=m, profile=f"Generic {m} @BBL H2S")
                                              for m in sorted({m for _, m, _ in PARTS.values()})]
PLATES = getattr(P, "PLATES", None) or [(name, [name]) for name in PARTS if PARTS[name][0] > 0]
PROJECT_3MF = ROOT / getattr(P, "PROJECT_3MF", f"{STL_DIR.relative_to(ROOT).as_posix()}/{ROOT.name}_all_parts.3mf")
SUMMARY = ROOT / getattr(P, "SLICER_SUMMARY", "docs/slicer-summary.json")
INLAY_FILAMENT = {f["inlay"]: i for i, f in enumerate(FILAMENTS, 1) if f.get("inlay")}
DEFAULT_INFILL = int(PROCESS["infill"])


def base_filament(material):
    return next(i for i, f in enumerate(FILAMENTS, 1) if f["material"] == material and not f.get("inlay"))


def resolve(name, parents=()):
    if name in parents:
        raise ValueError(f"Circular profile inheritance: {parents}, {name}")
    if name not in files:
        raise ValueError(f"Bambu profile not found: {name!r} (see {profile_root})")
    data = json.loads(files[name].read_text())
    result = {}
    if data.get("inherits"):
        result.update(resolve(data["inherits"], (*parents, name)))
    for include in data.get("include", []):
        result.update(resolve(include, (*parents, name)))
    result.update(data)
    result.pop("inherits", None)
    result.pop("include", None)
    return result


def infill(name, material):
    return 100 if material in FULL_INFILL_MATERIALS or name in FULL_INFILL else DEFAULT_INFILL


def pattern(density):
    # Bambu serializes Rectilinear as "zig-zag" ("rectilinear" maps to cubic); gyroid is refused at 100 %
    return "zig-zag" if density == 100 else PROCESS["pattern"]


for material in {m for _, m, _ in PARTS.values()}:
    base_filament(material)                       # every material needs a plain slot
for name, inlays in COLOR_PARTS.items():
    assert all(inlay in INLAY_FILAMENT for inlay in inlays), f"{name}: no FILAMENTS slot for {inlays}"
    assert infill(name, PARTS[name][1]) == DEFAULT_INFILL, f"{name}: multicolour parts with own infill are not supported yet"

machine = resolve(PRINTER["machine"])
machine["curr_bed_type"] = PRINTER["bed"]
(profiles / "machine.json").write_text(json.dumps(machine, indent=2))
for density in {infill(n, m) for n, (_, m, _) in PARTS.items()} | {DEFAULT_INFILL}:
    process = resolve(PRINTER["process"])
    process.update(wall_loops=str(PROCESS["wall_loops"]), sparse_infill_density=f"{density}%", enable_support="0",
                   top_shell_layers=str(PROCESS["top_shell_layers"]),
                   bottom_shell_layers=str(PROCESS["bottom_shell_layers"]), sparse_infill_pattern=pattern(density))
    (profiles / f"process-{density}.json").write_text(json.dumps(process, indent=2))
for slot, filament in enumerate(FILAMENTS, 1):
    profile = resolve(filament["profile"])
    if filament.get("colour"):
        profile["filament_colour"] = [filament["colour"]]
    (profiles / f"filament-{slot}.json").write_text(json.dumps(profile, indent=2))


def run(name):
    quantity, material, _ = PARTS[name]
    folder = out / name
    folder.mkdir(exist_ok=True)
    source = STL_DIR / f"{name}.stl"
    command = [str(executable), "--datadir", str(folder / "config"), "--debug", "2",
               "--load-settings", f"{profiles / 'machine.json'};{profiles / f'process-{infill(name, material)}.json'}",
               "--load-filaments", str(profiles / f"filament-{base_filament(material)}.json"),
               "--orient", "0", "--arrange", "1", "--slice", "0",
               # --outputdir must be absolute, otherwise the CLI exits with 243
               "--export-3mf", f"{name}-DIAGNOSTIC.3mf", "--outputdir", str(folder), str(source)]
    result = subprocess.run(command, capture_output=True, text=True, cwd=folder)
    log = result.stdout + result.stderr
    (folder / "cli.log").write_text(log)
    report_path = folder / "result.json"
    data = json.loads(report_path.read_text()) if report_path.exists() else {}
    plates = data.get("sliced_plates", [])
    plate = plates[0] if plates else {}
    passed = result.returncode == 0 and data.get("return_code") == 0 and len(plates) == 1
    settings = {}
    if passed:
        with zipfile.ZipFile(folder / f"{name}-DIAGNOSTIC.3mf") as archive:
            settings = json.loads(archive.read("Metadata/project_settings.config"))
    row = dict(part=name, quantity=quantity, material=material, passed=passed,
               source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
               exit_code=result.returncode, result_code=data.get("return_code"),
               warnings=plate.get("warning_message"),
               hours=round(plate.get("total_predication", 0) / 3600, 3),
               grams=round(sum(f["total_used_g"] for f in plate.get("filaments", [])), 3),
               wall_loops=data.get("wall_loops"), infill_percent=data.get("sparse_infill_density"),
               layer_height=data.get("layer_height"),
               effective_settings={key: settings.get(key) for key in
                                   ("sparse_infill_pattern", "enable_support", "curr_bed_type",
                                    "top_shell_layers", "bottom_shell_layers")},
               start_gcode_diagnostic="Invalid T command" in log)
    print(f"Slice {name}: {'PASS' if passed else 'FAIL'}", flush=True)
    return row


def transform(text):
    matrix = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0]]
    if text:
        v = [float(x) for x in text.split()]
        matrix = [[v[0], v[3], v[6], v[9]], [v[1], v[4], v[7], v[10]], [v[2], v[5], v[8], v[11]]]
    return matrix


def attribute(tag, key):
    match = re.search(rf'\b{key}="([^"]+)"', tag)
    return match.group(1) if match else None


def build_project_3mf():
    """Every part of the full build (no test prints) as one Bambu Studio project on the fixed PLATES."""
    folder = out / "project-3mf"
    folder.mkdir(exist_ok=True)
    listed = [name for _, group in PLATES for name in group]
    wanted = [name for name in PARTS if PARTS[name][0] > 0]
    assert sorted(listed) == sorted(wanted), f"PLATES does not match PARTS: {sorted(set(listed) ^ set(wanted))}"
    plates, assembled = [], 0
    for title, group in PLATES:
        objects = []
        for name in group:
            quantity, material, _ = PARTS[name]
            if name in COLOR_PARTS:
                # Base and inlays as one object with several parts: all parts of one copy share one assemble_index,
                # each copy gets its own (a shared index merges every copy into one object)
                indices = list(range(assembled + 1, assembled + quantity + 1))
                assembled += quantity
                for piece, filament in (("base", base_filament(material)),
                                        *((inlay, INLAY_FILAMENT[inlay]) for inlay in COLOR_PARTS[name])):
                    objects.append(dict(path=str(COLOR_DIR / f"{name}_{piece}.stl"), count=quantity,
                                        filaments=[filament] * quantity, assemble_index=indices))
                continue
            entry = dict(path=str(STL_DIR / f"{name}.stl"), count=quantity,
                         filaments=[base_filament(material)] * quantity)
            density = infill(name, material)
            if density != DEFAULT_INFILL:
                entry["print_params"] = dict(sparse_infill_density=f"{density}%", sparse_infill_pattern=pattern(density))
            objects.append(entry)
        plates.append(dict(plate_name=title, need_arrange=True, objects=objects))
    (folder / "assemble.json").write_text(json.dumps(dict(plates=plates), indent=2, ensure_ascii=False))
    raw = folder / "raw.3mf"
    raw.unlink(missing_ok=True)
    command = [str(executable), "--datadir", str(folder / "config"), "--debug", "2",
               "--load-settings", f"{profiles / 'machine.json'};{profiles / f'process-{DEFAULT_INFILL}.json'}",
               "--load-filaments", ";".join(str(profiles / f"filament-{slot}.json") for slot in range(1, len(FILAMENTS) + 1)),
               "--load-assemble-list", "assemble.json",
               "--export-3mf", raw.name, "--outputdir", str(folder)]
    result = subprocess.run(command, capture_output=True, text=True, cwd=folder)
    (folder / "cli.log").write_text(result.stdout + result.stderr)
    assert result.returncode == 0 and raw.exists(), f"Project 3MF export failed; inspect {folder}"
    piece_names = "|".join(sorted({"base", *(inlay for inlays in COLOR_PARTS.values() for inlay in inlays)}))

    with zipfile.ZipFile(raw) as source:
        settings = source.read("Metadata/model_settings.config").decode()
        model = source.read("3D/3dmodel.model").decode()
        meshes = {}

        def vertices(path, object_id):
            text = meshes.setdefault(path, source.read(path.lstrip("/")).decode())
            body = re.search(rf'<object id="{object_id}".*?</object>', text, re.S).group(0)
            return [tuple(map(float, v)) for v in re.findall(r'<vertex x="([^"]+)" y="([^"]+)" z="([^"]+)"', body)]

        items = {attribute(tag, "objectid"): tag for tag in re.findall(r"<item [^>]*>", model)}

        def bounds(object_id):
            body = re.search(rf'<object id="{object_id}".*?</object>', model, re.S).group(0)
            outer = transform(attribute(items[object_id], "transform"))
            low, high = [float("inf")] * 3, [float("-inf")] * 3
            for component in re.findall(r"<component [^>]*>", body):
                inner = transform(attribute(component, "transform"))
                matrix = [[sum(outer[r][k] * inner[k][c] for k in range(3)) + (outer[r][3] if c == 3 else 0)
                           for c in range(4)] for r in range(3)]
                for v in vertices(attribute(component, "p:path"), attribute(component, "objectid")):
                    for r in range(3):
                        p = matrix[r][0] * v[0] + matrix[r][1] * v[1] + matrix[r][2] * v[2] + matrix[r][3]
                        low[r], high[r] = min(low[r], p), max(high[r], p)
            return low, high

        plate_ids = [re.findall(r'<metadata key="object_id" value="(\d+)"', plate)
                     for plate in re.findall(r"<plate>(.*?)</plate>", settings, re.S)]
        names = {}
        for match in re.finditer(r'<object id="(\d+)">(.*?)</object>', settings, re.S):
            body = match.group(2)
            parts = {}
            for part in re.findall(r"<part [^>]*>(.*?)</part>", body, re.S):
                extruder = re.search(r'key="extruder" value="(\d+)"', part) or re.search(r'key="extruder" value="(\d+)"', body)
                parts[re.sub(r"_\d+$", "", re.search(r'key="name" value="([^"]+)"', part).group(1))] = extruder.group(1)
            name = re.sub(rf"_({piece_names})$", "", next(iter(parts)))
            if name in COLOR_PARTS:
                expected = {f"{name}_base": str(base_filament(PARTS[name][1])),
                            **{f"{name}_{inlay}": str(INLAY_FILAMENT[inlay]) for inlay in COLOR_PARTS[name]}}
                assert parts == expected, f"Multicolour {name}: parts {parts}, expected {expected}"
            names[match.group(1)] = name
        # assembled objects are called assemble_N; give them the part name
        settings = re.sub(r'(<object id="(\d+)">\s*<metadata key="name" value=")assemble_\d+(")',
                          lambda m: m.group(1) + names[m.group(2)] + m.group(3), settings)
        assert len(plate_ids) == len(PLATES), f"Project 3MF has {len(plate_ids)} plates, expected {len(PLATES)}"
        # Plate grid like Bambu Studio: columns from the square root of the plate count, 20 % gap
        width = max(float(p.split("x")[0]) for p in machine["printable_area"])
        depth = max(float(p.split("x")[1]) for p in machine["printable_area"])
        root = len(plate_ids) ** 0.5
        columns = round(root) + 1 if root > round(root) else round(root)
        project_settings = json.loads(source.read("Metadata/project_settings.config"))
        tower_width = float(project_settings["prime_tower_width"])
        tower_brim = float(project_settings["prime_tower_brim_width"])
        tower_margin, tower_gap, towers = 10, 15, {}
        shift, layout = {}, []
        for index, ((title, group), ids) in enumerate(zip(PLATES, plate_ids)):
            got = sorted(names[i] for i in ids)
            assert got == sorted(n for n in group for _ in range(PARTS[n][0])), f"Plate {title} holds {got}"
            origin = ((index % columns) * width * 1.2, -(index // columns) * depth * 1.2)
            boxes = [bounds(i) for i in ids]
            low = [min(b[0][r] for b in boxes) - origin[r] for r in range(2)]
            high = [max(b[1][r] for b in boxes) - origin[r] for r in range(2)]
            size = (high[0] - low[0], high[1] - low[1])
            assert size[0] <= width and size[1] <= depth, f"Plate {title} exceeds the bed"
            delta = (width / 2 - (low[0] + high[0]) / 2, depth / 2 - (low[1] + high[1]) / 2)
            entry = dict(plate=index + 1, name=title, parts=got, size_mm=[round(size[0], 1), round(size[1], 1)])
            if set(group) & set(COLOR_PARTS):
                # Multicolour plate: parts to the left edge, prime tower right next to them
                delta = (tower_margin - low[0], delta[1])
                towers[index] = (tower_margin + size[0] + tower_gap + tower_brim, depth / 2 - 30)
                assert towers[index][0] + tower_width + tower_brim <= width - 5, f"Plate {title}: no room for the prime tower"
                entry["prime_tower_xy"] = [round(v, 1) for v in towers[index]]
            for i in ids:
                shift[i] = delta
            layout.append(entry)

        def moved(match):
            tag = match.group(0)
            values = attribute(tag, "transform").split()
            dx, dy = shift[attribute(tag, "objectid")]
            values[9], values[10] = f"{float(values[9]) + dx:.4f}", f"{float(values[10]) + dy:.4f}"
            return tag.replace(attribute(tag, "transform"), " ".join(values))

        model = re.sub(r"<item [^>]*>", moved, model)
        count = len(plate_ids)
        xs = (list(project_settings.get("wipe_tower_x", [])) + [f"{width / 2:.0f}"] * count)[:count]
        ys = (list(project_settings.get("wipe_tower_y", [])) + [f"{depth * 0.75:.0f}"] * count)[:count]
        for index, (x, y) in towers.items():
            xs[index], ys[index] = f"{x:.1f}", f"{y:.1f}"
        project_settings["wipe_tower_x"], project_settings["wipe_tower_y"] = xs, ys
        PROJECT_3MF.parent.mkdir(parents=True, exist_ok=True)
        with zipfile.ZipFile(PROJECT_3MF, "w", zipfile.ZIP_DEFLATED) as project:
            for item in source.infolist():
                data = (model.encode() if item.filename == "3D/3dmodel.model" else
                        settings.encode() if item.filename == "Metadata/model_settings.config" else
                        json.dumps(project_settings, indent=4).encode() if item.filename == "Metadata/project_settings.config" else
                        source.read(item.filename))
                project.writestr(item, data)
    placed = sum(len(ids) for ids in plate_ids)
    own_infill = len([v for v in re.findall(r'sparse_infill_density" value="(\d+)%"', settings) if int(v) != DEFAULT_INFILL])
    expected_own = sum(PARTS[n][0] for n in PARTS if infill(n, PARTS[n][1]) != DEFAULT_INFILL)
    assert placed == sum(PARTS[n][0] for n in listed), f"Project 3MF places {placed} parts"
    assert own_infill == expected_own, f"Project 3MF: {own_infill} parts with own infill, expected {expected_own}"
    print(f"Project 3MF: {placed} parts on {len(plate_ids)} plates -> {PROJECT_3MF.relative_to(ROOT)}", flush=True)
    multicolour = {}
    for index, (title, group) in enumerate(PLATES, 1):
        if not set(group) & set(COLOR_PARTS):
            continue
        plate_dir = folder / f"slice-plate-{index}"
        plate_dir.mkdir(exist_ok=True)
        (plate_dir / "result.json").unlink(missing_ok=True)
        command = [str(executable), "--datadir", str(folder / "config"), "--debug", "2", "--slice", str(index),
                   "--export-3mf", "sliced.3mf", "--outputdir", str(plate_dir), str(PROJECT_3MF)]
        result = subprocess.run(command, capture_output=True, text=True, cwd=plate_dir)
        log = result.stdout + result.stderr
        (plate_dir / "cli.log").write_text(log)
        data = json.loads((plate_dir / "result.json").read_text()) if (plate_dir / "result.json").exists() else {}
        plate = (data.get("sliced_plates") or [{}])[0]
        grams = {f["id"]: round(f["total_used_g"], 2) for f in plate.get("filaments", [])}
        assert result.returncode == 0 and data.get("return_code") == 0 and "slicing result conflict" not in log, \
            f"Multicolour plate {title} does not slice; see {plate_dir}"
        needed = {base_filament(PARTS[part][1]) for part in group} | \
                 {INLAY_FILAMENT[inlay] for part in group if part in COLOR_PARTS for inlay in COLOR_PARTS[part]}
        assert all(grams.get(f, 0) > 0 for f in needed), f"Multicolour plate {title}: filament use {grams}, needs {sorted(needed)}"
        multicolour[title] = dict(plate=index, hours=round(plate.get("total_predication", 0) / 3600, 2),
                                  grams_by_filament=grams, warnings=plate.get("warning_message"))
        print(f"Slice multicolour plate {title}: PASS, filament use {grams} g", flush=True)
    return dict(file=str(PROJECT_3MF.relative_to(ROOT)), parts=placed, plates=len(plate_ids), layout=layout,
                multicolour_parts=COLOR_PARTS, multicolour_slices=multicolour,
                own_infill_parts=own_infill, sha256=hashlib.sha256(PROJECT_3MF.read_bytes()).hexdigest())


def write_summary(summary):
    text = json.dumps(summary, indent=2, ensure_ascii=False) + "\n"
    (out / "summary.json").write_text(text)
    SUMMARY.parent.mkdir(parents=True, exist_ok=True)
    SUMMARY.write_text(text)


solid = sorted(n for n in PARTS if infill(n, PARTS[n][1]) == 100)
with ThreadPoolExecutor(max_workers=2) as pool:
    results = list(pool.map(run, PARTS))
summary = dict(profile=f"{PRINTER['machine']} / {PRINTER['process']}, {PROCESS['wall_loops']} walls, "
                       f"{PROCESS['top_shell_layers']}/{PROCESS['bottom_shell_layers']} top/bottom, no supports; "
                       f"{DEFAULT_INFILL} % {PROCESS['pattern']}, 100 % zig-zag: {', '.join(solid) or 'none'}",
               parts=results, total_parts=sum(r["quantity"] for r in results),
               total_grams_individual_plates=round(sum(r["quantity"] * r["grams"] for r in results), 1),
               total_hours_individual_plates=round(sum(r["quantity"] * r["hours"] for r in results), 1),
               production_gcode=False)
write_summary(summary)
assert all(r["passed"] for r in results), f"Slicing failed; inspect {out}"
assert all(r["wall_loops"] == PROCESS["wall_loops"] for r in results), "Wrong diagnostic wall count"
assert all(r["infill_percent"] == infill(r["part"], r["material"]) for r in results), "Wrong diagnostic infill"
assert all(r["effective_settings"]["sparse_infill_pattern"] == pattern(infill(r["part"], r["material"])) for r in results)
assert all(r["effective_settings"]["enable_support"] == "0" for r in results)
summary["project_3mf"] = build_project_3mf()
write_summary(summary)
print(f"PASS: {len(results)} slices; {summary['total_parts']} parts; "
      f"{summary['total_grams_individual_plates']} g; {summary['total_hours_individual_plates']} h; "
      f"project 3MF with {summary['project_3mf']['plates']} plates")
