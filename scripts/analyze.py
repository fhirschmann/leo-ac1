#!/usr/bin/env python3
"""Printability analysis of exported print meshes (skill openscad-print-project).

  islands  regions that start in mid-air: a layer component without overlap with the layer below
           (the slicer calls them "floating regions"; they need support or a design change)
  ridges   webs and lines narrower than --min-width in cross-sections at --z (default 0.4 mm, i.e.
           inside engravings that are open to the bed); tiny components below --ignore-area are skipped
  inlays   multicolour inlay pieces on their first layer (bed or a face higher up): bodies, area and features narrower than --min-width
  overhangs  areas of a layer steeper than 45 degrees over the layer below (bridges, rebates and grooves in the
           bed face, cantilevers), larger than --min-area (default 100 mm2); --max-z limits the height

Without names all print parts (islands, ridges) or all multicolour pieces (inlays) are analysed.
Reads build/print and build/color (run print_tools.py build first); --committed reads the STL folders.
Exit code 1 when anything is found, so a clean run can be used as a gate. Report: build/analysis/<command>.json
"""
import argparse
import json
import sys

import manifold3d as md
import numpy as np
import trimesh

from print_tools import BUILD, COLOR_DIR, COLOR_PIECES, PARTS, STL_DIR, manifold


def load(name, committed):
    color = name in COLOR_PIECES
    folder = (COLOR_DIR if color else STL_DIR) if committed else BUILD / ("color" if color else "print")
    mesh = trimesh.load_mesh(folder / f"{name}.stl")
    return mesh, manifold(mesh)


def box(section):
    return [round(v, 2) for v in section.bounds()]


def islands(mesh, solid, layer, min_area):
    found = []
    top = float(mesh.bounds[1, 2])
    below = solid.slice(layer / 2)
    for k in range(1, int(np.ceil(top / layer))):
        z = (k + 0.5) * layer
        section = solid.slice(z)
        for piece in section.decompose():
            area = piece.area()
            if area >= min_area and (piece ^ below).area() < 0.01:
                found.append(dict(z_mm=round(z, 3), area_mm2=round(area, 3), bounds_xy=box(piece)))
        below = section
    return found


def overhangs(mesh, solid, layer, min_area, max_z):
    found = []
    top = min(float(mesh.bounds[1, 2]), max_z or float("inf"))
    below = solid.slice(layer / 2)
    for k in range(1, int(np.ceil(top / layer))):
        z = (k + 0.5) * layer
        section = solid.slice(z)
        supported = below.offset(layer, md.JoinType.Miter)    # 45 degrees per layer
        for piece in (section - supported).decompose():
            if piece.area() >= min_area:
                found.append(dict(z_mm=round(z, 3), area_mm2=round(piece.area(), 1), bounds_xy=box(piece)))
        below = section
    return found


def thin(section, width, ignore_area, min_area):
    found = []
    radius = width / 2 - 0.01          # a web of exactly the minimum width passes
    for piece in section.decompose():
        if piece.area() < ignore_area:
            continue
        opened = piece.offset(-radius, md.JoinType.Miter).offset(radius, md.JoinType.Miter)
        for sliver in (piece - opened).decompose():
            if sliver.area() >= min_area:
                found.append(dict(area_mm2=round(sliver.area(), 3), bounds_xy=box(sliver)))
    return found


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("command", choices=("islands", "ridges", "inlays", "overhangs"))
    parser.add_argument("names", nargs="*")
    parser.add_argument("--committed", action="store_true", help="analyse the committed STL folders instead of build/")
    parser.add_argument("--layer", type=float, default=0.2, help="islands, overhangs: layer height")
    parser.add_argument("--max-z", type=float, help="overhangs: only up to this height")
    parser.add_argument("--min-area", type=float, default=None,
                        help="smallest finding in mm2 (islands 0.05, ridges/inlays 0.1, overhangs 100)")
    parser.add_argument("--z", type=float, nargs="+", default=[0.4], help="ridges: section heights")
    parser.add_argument("--min-width", type=float, default=None, help="ridges 1.1 mm, inlays 0.8 mm")
    parser.add_argument("--ignore-area", type=float, default=5.0, help="ridges: skip components smaller than this (mm2)")
    args = parser.parse_args()
    names = args.names or (COLOR_PIECES if args.command == "inlays" else list(PARTS))
    if args.command == "inlays":
        names = [n for n in names if not n.endswith("_base")]
    report, total = {}, 0
    for name in names:
        mesh, solid = load(name, args.committed)
        if args.command == "islands":
            found = islands(mesh, solid, args.layer, args.min_area or 0.05)
        elif args.command == "overhangs":
            found = overhangs(mesh, solid, args.layer, args.min_area or 100, args.max_z)
        elif args.command == "ridges":
            found = [dict(z_mm=z, **item) for z in args.z
                     for item in thin(solid.slice(z), args.min_width or 1.1, args.ignore_area, args.min_area or 0.1)]
        else:
            z0 = float(mesh.bounds[0, 2])   # first layer of the inlay itself
            section = solid.slice(z0 + 0.1)
            pieces = section.decompose()
            found = thin(section, args.min_width or 0.8, 0, args.min_area or 0.1)
            print(f"{name}: {len(pieces)} bodies on its first layer (z {z0:.2f}), {section.area():.1f} mm2, "
                  f"smallest {min((p.area() for p in pieces), default=0):.2f} mm2")
        report[name] = found
        total += len(found)
        print(f"{args.command} {name}: {len(found)} found", flush=True)
        for item in found[:12]:
            print(f"  {item}")
        if len(found) > 12:
            print(f"  ... {len(found) - 12} more")
    path = BUILD / "analysis" / f"{args.command}.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(report, indent=2) + "\n")
    print(f"{'FOUND' if total else 'CLEAN'}: {total} {args.command} findings in {len(names)} meshes -> {path}")
    sys.exit(1 if total else 0)


if __name__ == "__main__":
    main()
