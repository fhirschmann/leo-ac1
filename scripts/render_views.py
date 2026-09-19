#!/usr/bin/env python3
"""Render documentation images from the current model (skill openscad-print-project).

VIEWS in print_project.py: image name -> (OpenSCAD code, camera "eye_x,eye_y,eye_z,centre_x,centre_y,centre_z").
Images go to IMG_DIR (default img/). Uses --render, because the OpenCSG preview shows differences
with imported meshes wrongly.
"""
import argparse
import shutil
import subprocess

from print_tools import BUILD, P, ROOT, SOURCE

parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("names", nargs="*", help="only these views")
args = parser.parse_args()
views = getattr(P, "VIEWS", {})
settings = dict(imgsize="1200,1000", colorscheme="Tomorrow", projection="o") | getattr(P, "RENDER", {})
folder = BUILD / "views"
folder.mkdir(parents=True, exist_ok=True)
target = ROOT / getattr(P, "IMG_DIR", "img")
target.mkdir(exist_ok=True)
for name, (code, camera) in views.items():
    if args.names and name not in args.names:
        continue
    wrapper = folder / f"{name}.scad"
    wrapper.write_text(f"include <{SOURCE.as_posix()}>\n{code}\n")
    subprocess.run([shutil.which("openscad") or "openscad", "--hardwarnings", "--render",
                    f"--imgsize={settings['imgsize']}", f"--colorscheme={settings['colorscheme']}",
                    f"--projection={settings['projection']}", f"--camera={camera}", "--autocenter", "--viewall",
                    "-D", 'part="none"', "-o", str(target / f"{name}.png"), str(wrapper)],
                   check=True, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
    print(name, flush=True)
