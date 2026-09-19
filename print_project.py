"""Project settings for the openscad-print-project tools in scripts/.

Everything project-specific lives here, the scripts stay identical to the skill copies
(python3 ~/.claude/skills/openscad-print-project/scripts/skill_sync.py status).
"""
import manifold3d as md
import numpy as np

SOURCE = "leo_ac.scad"
METRICS_TAG = "PROJECT_METRICS"       # part="metrics" echoes this tag with [key, value] pairs

# Print parts: name -> (quantity in the full build, material, body count). Quantity 0 = optional test print.
# Must match the part branches in SOURCE exactly (checked). The material key also picks the filament slot,
# so one material in two colours gets one key per colour.
PARTS = {
    "body": (1, "PETG-weiss", 1),
    "back": (1, "PETG-weiss", 1),
    "grille": (1, "PETG-grau", 1),
    "cover": (1, "PETG-grau", 1),
    "handle": (1, "PETG-grau", 1),
    "knob": (1, "PETG-grau", 1),
}
FULL_INFILL = set()
FULL_INFILL_MATERIALS = {"TPU"}

# Assembly bodies in installed position: name -> OpenSCAD call. Every pair is checked for overlap.
ASSEMBLY = {
    "body": "body();",
    "grille": "grille();",
    "back": "back();",
    "cover": "cover();",
    "handle": "handle();",
    "knob": "knob();",
    "pot": "pot_env(nut = false);",
    "pot_nut": "pot_nut_env();",
    "pwm_board": "pwm_board_env();",
    "chg_module": "chg_module_env();",
    "fan": "fan_env();",
    "battery": "battery_env();",
    "screws_grille": "screws_grille();",
    "screws_fan": "screws_fan();",
    "screws_back": "screws_back();",
    "screws_cover": "screws_cover();",
    "screws_handle": "screws_handle();",
}
ALLOWED_OVERLAPS = [("fan", "screws_fan")]   # the fan is a solid envelope, its screws run through the frame holes

# Multicolour: part -> inlay names; SOURCE needs the branches <part>_base and <part>_<inlay>
COLOR_PARTS = {"body": ("label",)}
STL_DIR, COLOR_DIR, ASM_DIR, REPORT = "stl", "stl/multicolour", "asm", "docs/verification.json"

PRINTER = dict(machine="Bambu Lab H2S 0.4 nozzle", process="0.20mm Standard @BBL H2S",
               bed="Textured PEI Plate", envelope_mm=(340, 320, 340))
PROCESS = dict(wall_loops=6, top_shell_layers=5, bottom_shell_layers=5, infill=30, pattern="gyroid")   # drop resistant
# Filament slots of the project 3MF, 1-based in this order; inlay slots name their inlay
FILAMENTS = [dict(material="PETG-weiss", profile="Bambu PETG Basic @BBL H2S", colour="#FFFFFF"),
             dict(material="PETG-grau", profile="Bambu PETG Basic @BBL H2S", colour="#8E9294"),
             dict(material="PETG-grau", profile="Bambu PETG Basic @BBL H2S", inlay="label", colour="#8E9294")]
PLATES = [("Gehäuse", ["body"]), ("Rückwand", ["back"]), ("Graue Teile", ["grille", "cover", "handle", "knob"])]
PROJECT_3MF = "stl/leo_ac1_all_parts.3mf"
SLICER_SUMMARY = "docs/slicer-summary.json"

LIMITATIONS = ["Bought parts as envelopes (fan block, battery cylinder), no vendor CAD",
               "Screws without threads, heads simplified",
               "Sampled motion, no continuous swept-volume proof",
               "No flexible deformation, physical fit, strength, airflow or thermal validation"]

ROTATION = {(0, 0, 1): (0, 0, 0), (0, 0, -1): (180, 0, 0), (0, 1, 0): (-90, 0, 0),
            (0, -1, 0): (90, 0, 0), (1, 0, 0): (0, 90, 0), (-1, 0, 0): (0, -90, 0)}


def axis_cylinder(start, direction, length, radius):
    """Cylinder from start along an axis-aligned direction."""
    rotation = ROTATION[tuple(int(round(v)) for v in direction)]
    return md.Manifold.cylinder(length, radius, radius, 48).rotate(rotation).translate(list(map(float, start)))


def checks(ctx):
    """Project-specific checks after export; ctx has metrics, meshes and solids (assembly bodies),
    sweep(moving, fixed, direction, length, step), union(names), save(name, data), summary, open_items.
    Assert failures abort the run; the returned dict goes into the report."""
    m = ctx.metrics
    assert min(m["wall"], m["front_t"]) >= 3.2 and m["back_t"] >= 3 and m["corner_r"] >= 5, "Drop resistance: walls and corner radius"

    # Standard dimensions, independent of the model
    assert (m["fan_size"], m["fan_t"], m["fan_pitch"]) == (120, 25, 105), "120 mm fan: 120 x 120 x 25, holes 105 mm apart"
    assert m["fan_hole_d"] >= 4.3, "120 mm fan holes are 4.3 mm"
    assert m["open_d"] > m["fan_blade_d"], "Front opening covers the fan blades"
    assert m["insert_hole_d"] == 4.0 and m["insert_len"] == 5.7, "Ruthex M3 insert: hole 4.0 mm, length 5.7 mm"
    # Ruthex datasheet RX series (08/2022): M3x5.7 hole 4.0, depth >= L + 1, wall >= 1.6; M5x9.5 hole 6.4, L 9.5, wall >= 2.6
    assert m["insert_depth"] >= m["insert_len"] + 1 and m["insert_w_min"] >= 1.6, "Ruthex M3: hole depth L + 1 mm, wall 1.6 mm"
    assert m["mount_insert"] == [6.4, 9.5, 2.6] and m["mount_floor"] >= 2, "Ruthex M5x9.5: hole 6.4, length 9.5, wall 2.6; 2 mm floor"
    assert m["grille_gap"] <= 6, "Grille openings above 6 mm let children's fingers through"
    assert m["knob_shaft_engagement"] >= 8 and m["knob_top_skin"] >= 2 and m["knob_protrusion"] <= 8, "Knob: on the shaft, at most 8 mm in front of the cover"
    assert m["handle_clearance"] >= 30 and m["handle_open_top"] >= 90, "Handle: 30 mm finger clearance, 90 mm hand breadth"
    screws = {name: dict(length=length, engagement_mm=round(eng, 2), tip_margin_mm=round(margin, 2))
              for name, length, eng, margin in m["screws"]}
    for name, info in screws.items():
        assert info["engagement_mm"] >= 4 and info["tip_margin_mm"] >= 0.3, f"Screw {name}: {info}"

    # Contact, not just freedom from overlap: pushed 0.05 mm into its support, a body must intersect it
    contacts = {}
    for name, base, shift in (("grille", "body", [0, 0.05, 0]), ("fan", "body", [0, -0.05, 0]),
                              ("back", "body", [0, -0.05, 0]), ("cover", "body", [-0.05, 0, 0]), ("battery", "body", [0, 0, -0.05]),
                              ("handle", "body", [0, 0, -0.05]), ("pot", "body", [0.05, 0, 0]), ("pot_nut", "body", [-0.05, 0, 0]), ("chg_module", "body", [0.05, 0, -0.05])):
        volume = (ctx.solids[name].translate(shift) ^ ctx.solids[base]).volume()
        assert volume > 0.1, f"{name} does not rest on {base}"
        contacts[f"{name}@{base}"] = round(volume, 3)

    # Stops: the battery may move only a little before the back cover or the shelf holds it
    stops = []
    for name, moving, fixed, direction, limit in (("battery_back", ["battery"], ["back"], [0, 1, 0], 1.5),
                                                  ("battery_up", ["battery"], ["body"], [0, 0, 1], m["shelf_gap"] + 0.5),
                                                  ("battery_side", ["battery"], ["body"], [1, 0, 0], 1.0)):
        count, first, _ = ctx.sweep(moving, fixed, direction, limit, 0.25)
        stops.append(dict(name=name, first_contact_mm=first, limit_mm=limit))
        assert count > 0, f"Stop {name}: no contact within {limit} mm"

    # Round air duct: wall closed all around, small gap to the fan, end ring completely on the fan frame face
    (ax, az), fy, (r0, r1), gap = m["fan_axis"], m["fan_y"], m["shroud_r"], m["shroud_gap"]
    ring = lambda y, length, ra, rb: (axis_cylinder([ax, y, az], (0, 1, 0), length, rb)
                                      - axis_cylinder([ax, y, az], (0, 1, 0), length, ra))
    # inner 2 mm of the wall: closed all around (the grille insert pockets may reach into the outer part of a thick wall)
    wall_probe = ring(fy - gap - 1.2, 0.8, r0 + 0.2, min(r1 - 0.2, r0 + 2))
    gap_probe = ring(fy - gap + 0.02, gap - 0.04, r0 + 0.2, r1 - 0.2)
    face_probe = ring(fy + 0.1, 0.5, r0, min(r1, m["fan_size"] / 2 - 0.1))
    duct = dict(wall_fill=round((wall_probe ^ ctx.solids["body"]).volume() / wall_probe.volume(), 4),
                gap_mm3=round((gap_probe ^ ctx.solids["body"]).volume(), 4),
                on_fan_frame=round((face_probe ^ ctx.solids["fan"]).volume() / face_probe.volume(), 4))
    assert duct["wall_fill"] > 0.999 and duct["gap_mm3"] < 0.01 and duct["on_fan_frame"] > 0.999, f"Air duct {duct}"
    ctx.summary.append("air duct")

    # Assembly paths in a realistic removal order
    others = lambda *names: [n for n in ctx.solids if n not in names]
    paths = []
    for name, moving, fixed, direction, length, step in (
            ("grille_front", ["grille", "screws_grille"], ["body", "fan", "screws_fan"], [0, -1, 0], 12, 0.25),
            ("back_off", ["back", "screws_back"], others("back", "screws_back"), [0, 1, 0], 12, 0.25),
            ("battery_out", ["battery"], others("battery", "back", "screws_back"), [0, 1, 0], 90, 1),
            ("chg_module_out", ["chg_module"], others("chg_module", "back", "screws_back"), [0, 1, 0], 45, 1),
            ("fan_out", ["fan", "screws_fan"], others("fan", "screws_fan", "battery", "chg_module", "back", "screws_back"), [0, 1, 0], 90, 1),
            ("knob_off", ["knob"], others("knob"), [1, 0, 0], 25, 0.5),
            ("cover_off", ["cover"], ["body", "pot", "pot_nut", "pwm_board"], [1, 0, 0], 30, 0.5),
            ("handle_up", ["handle"], ["body"], [0, 0, 1], 15, 0.5)):
        count, first, maximum = ctx.sweep(moving, fixed, direction, length, step)
        paths.append(dict(name=name, collisions=count, first_mm=first, max_volume_mm3=round(maximum, 4)))
        assert count == 0, f"Path {name} obstructed at {first} mm"
    # PWM board with the potentiometer: after knob, cover and nut, away from the wall until the shaft is clear, then out the back
    fixed = ctx.union(others("pot", "pot_nut", "pwm_board", "knob", "cover", "screws_cover", "back", "screws_back"))
    moving = ctx.union(["pot", "pwm_board"])
    clear_x = m["pot_shaft_len"] + m["wall"] + 1          # shaft end clear of the inner wall face
    blocked = [("away", float(d)) for d in np.arange(0, clear_x + 0.01, 0.5) if (moving.translate([-d, 0, 0]) ^ fixed).volume() > 0.01]
    blocked += [("back", float(d)) for d in np.arange(0, 90.01, 1) if (moving.translate([-clear_x, d, 0]) ^ fixed).volume() > 0.01]
    paths.append(dict(name="pwm_board_out", collisions=len(blocked), first_mm=blocked[0] if blocked else None, max_volume_mm3=0))
    assert not blocked, f"Path pwm_board_out obstructed at {blocked[:3]}"
    ctx.summary.append(f"{len(paths)} paths")

    # Insert pockets: axis empty, ring around it and floor below it filled
    inserts = []
    for body, start, direction, depth, hole, wall in m["inserts"]:
        solid, d, s = ctx.solids[body], np.array(direction, float), np.array(start, float)
        length = depth - 0.5
        core = axis_cylinder(s + d * 0.2, d, length, 0.375 * hole)
        # the full datasheet wall around the hole must be material
        ring = axis_cylinder(s + d * 0.2, d, length, hole / 2 + wall) - axis_cylinder(s + d * 0.2, d, length, hole / 2 + 0.3)
        # ring, not disc: screws pass through the pocket floor
        floor = (axis_cylinder(s + d * (depth + 0.2), d, 0.4, hole / 2 + wall)
                 - axis_cylinder(s + d * (depth + 0.2), d, 0.4, 0.45 * hole))
        empty = (core ^ solid).volume()
        filled = (ring ^ solid).volume() / ring.volume()
        bottom = (floor ^ solid).volume() / floor.volume()
        inserts.append(dict(body=body, at=[round(v, 2) for v in start], empty_mm3=round(empty, 4),
                            ring_fill=round(filled, 3), floor_fill=round(bottom, 3)))
        assert empty < 0.01 and filled > 0.95 and bottom > 0.95, f"Insert pocket {inserts[-1]}"
    ctx.summary.append(f"{len(inserts)} inserts")

    ctx.open_items.append("Akku nachmessen (Etikett: Ø34 × 70 mm, Modell Ø35 × 72 mm) und Kabelabgang prüfen")
    ctx.open_items.append("Lüfter messen (Rahmen 120 × 120 × 25, Lochabstand 105, Kabelabgang)")
    ctx.open_items.append("Poti des PWM-Reglers messen (Annahme WH148: D-Achse Ø6/4,5 × 15, Buchse M7, Gehäuse Ø16,5 × 18)")
    ctx.open_items.append("BMS-Platine am Akku messen (Annahme 16 × 4 mm über die ganze Länge, zur Trennwand)")
    ctx.open_items.append("PWM-Platine CNY-FA5-PRO messen (Annahme 48 × 34 mm, Bauteile 13 mm hoch, Poti-Achse 8,5 mm über der Platine)")
    ctx.open_items.append("USB-C-Buchse wählen und messen: Durchbruch im Servicedeckel")
    return dict(standard_screws=screws, contact_volumes_mm3=contacts, stops=stops, sampled_paths=paths,
                insert_probes=inserts, air_duct=duct)


VIEWER = dict(
    title="LEO-AC1", page_title="LEO-AC1 Ventilator", eyebrow="Baugruppe · Einbaulage",
    dims=[("Breite", "234"), ("Tiefe", "84"), ("Höhe", "197")],
    groups=[("weiss", "Gedruckt · PETG weiß"), ("grau", "Gedruckt · PETG grau"),
            ("schrauben", "Schrauben M3"), ("zugekauft", "Zugekauft")],
    hidden_groups=["zugekauft"],
    outer=["body", "back", "cover", "grille", "handle", "screws_grille", "screws_back", "screws_cover", "screws_handle"],
    cut=["back", "cover", "screws_back", "screws_cover"],
    # id, label, group, colour, quantity, explode direction (mm per slider mm)
    parts=[("body", "Gehäuse", "weiss", "#f2f2ee", "1x", [0, 0, 0]),
           ("back", "Rückwand", "weiss", "#e6e6e1", "1x", [0, 1.5, 0]),
           ("grille", "Lüftergitter", "grau", "#8f9396", "1x", [0, -1, 0]),
           ("cover", "Servicedeckel", "grau", "#8f9396", "1x", [1, 0, 0]),
           ("handle", "Griff", "grau", "#8f9396", "1x", [0, 0, 1.2]),
           ("knob", "Drehknopf", "grau", "#8f9396", "1x", [2, 0, 0]),
           ("fan_visual", "Lüfter 120 mm", "zugekauft", "#303236", "1x", [0, 0.8, 0]),
           ("battery", "Akku LiFePO4 3,2 V", "zugekauft", "#3f7fbf", "1x", [0, 0.5, 0]),
           ("pot", "Poti PWM-Regler (Annahme)", "zugekauft", "#3a3d41", "1x", [-0.5, 0, 0]),
           ("chg_module", "Lade-/Boostmodul mit 2 Kühlkörpern", "zugekauft", "#c9c9c9", "1x", [0, 0.8, 0]),
           ("pwm_board", "PWM-Platine CNY-FA5-PRO (Annahme 48 × 34)", "zugekauft", "#2e6b3f", "1x", [-0.5, 0, 0]),
           # screws leave their part: same direction, further out
           ("screws_grille", "Gitter · M3 × 12 Linsenkopf", "schrauben", "#26282b", "4x", [0, -1.6, 0]),
           ("screws_fan", "Lüfter · M3 × 30 Linsenkopf", "schrauben", "#26282b", "4x", [0, 1.4, 0]),
           ("screws_back", "Rückwand · M3 × 8 Linsenkopf", "schrauben", "#26282b", "6x", [0, 2.2, 0]),
           ("screws_cover", "Servicedeckel · M3 × 16 Linsenkopf, von außen", "schrauben", "#26282b", "2x", [1.6, 0, 0]),
           ("screws_handle", "Griff · M3 × 8 Linsenkopf", "schrauben", "#26282b", "4x", [0, 0, -0.5])],
    colour={"body": [("label", "Gehäuse · Logo", "#8f9396")]},
    bodies={"body_base": "body_install_pose() inlay_base() { body_print_pose() body(); body_label_print_2d(); }",
            "body_label": "body_install_pose() inlay_piece() { body_print_pose() body(); body_label_print_2d(); }",
            "fan_visual": "fan_visual();",
            "pot": "pot_env();",
            "screws_grille": "screws_grille(true);",
            "screws_fan": "screws_fan(true);",
            "screws_back": "screws_back(true);",
            "screws_cover": "screws_cover(true);",
            "screws_handle": "screws_handle(true);"},
    output="build/viewer.html",
)

VIEWS = {"01_assembly": ("assembly();", "-160,-330,230,112,40,70"),
         "02_back": ("assembly();", "420,380,230,112,40,70"),
         "03_exploded": ("assembly(40);", "-200,-380,260,112,40,70"),
         # front turned up (OpenSCAD renders faces towards -y dark), oblique so the grooves show
         "04_front_right": ("rotate([-90, 0, 0]) intersection() { assembly(); translate([150, -10, 0]) cube([80, 20, 155]); }",
                            "189,-260,420,189,78,0"),
         # air duct from behind: body cut at 30 mm depth, fan hidden
         "05_duct": ("intersection() { body(); translate([-1, -1, -1]) cube([body_w + 2, 30, body_h + 2]); }",
                     "112,420,300,112,0,77"),
         # service cover with the speed knob, from the right
         "06_knob": ("intersection() { assembly(); translate([165, 0, 20]) cube([100, 80, 140]); }",
                     "420,-120,200,230,40,90"),
         # charge/boost module on the partition in the air stream, from the back with the back cover removed
         "08_charge_module": ("intersection() { union() { color(\"#f2f2ee\") body(); color(\"#c9c9c9\") chg_module_env(); color(\"#303236\") fan_visual(); } translate([95, 30, 85]) cube([60, 45, 55]); }", "20,260,220,140,55,110"),
         # underside with the M5 mount insert
         "07_underside": ("body();", "40,-160,-260,112,40,40")}
