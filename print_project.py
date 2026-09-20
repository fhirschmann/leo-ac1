"""Project settings for the openscad-print-project tools in scripts/.

Everything project-specific lives here, the scripts stay identical to the skill copies
(python3 ~/.claude/skills/openscad-print-project/scripts/skill_sync.py status).
"""
SOURCE = "leo_ac.scad"
METRICS_TAG = "PROJECT_METRICS"       # part="metrics" echoes this tag with [key, value] pairs

# Print parts: name -> (quantity in the full build, material, body count). Quantity 0 = optional test print.
# Must match the part branches in SOURCE exactly (checked). The material key also picks the filament slot,
# so one material in two colours gets one key per colour.
PARTS = {
    "body": (1, "PETG-white", 1),
    "back": (1, "PETG-white", 1),
    "grille": (1, "PETG-grey", 1),
    "cover": (1, "PETG-grey", 1),
    "handle": (1, "PETG-grey", 1),
    "knob": (1, "PETG-grey", 1),
    "foot": (2, "TPU", 1),
    # fit tests: slices of the real parts, printed before the full build (with one knob and one foot)
    "test_pot": (0, "PETG-white", 1),
    "test_usbc": (0, "PETG-white", 1),
    "test_switch": (0, "PETG-white", 1),
    "test_ring": (0, "PETG-white", 2),
    "test_foot": (0, "PETG-white", 1),
    "test_mount": (0, "PETG-white", 1),
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
    "feet": "place_feet();",
    "knob": "knob();",
    "pot": "pot_env(nut = false);",
    "pot_nut": "pot_nut_env();",
    "pwm_board": "pwm_board_env();",
    "led": "led_env();",
    "chg_module": "chg_module_env();",
    "usb_trigger": "usbc_env();",
    "switch": "sw_env();",
    "fan": "fan_env();",
    "battery": "battery_env();",
    "screws_grille": "screws_grille();",
    "screws_fan": "screws_fan();",
    "screws_back": "screws_back();",
    "screws_handle": "screws_handle();",
    "screws_feet": "screws_feet();",
}
ALLOWED_OVERLAPS = [("fan", "screws_fan")]   # the fan is a solid envelope, its screws run through the frame holes

# Multicolour: part -> inlay names; SOURCE needs the branches <part>_base and <part>_<inlay>
COLOR_PARTS = {"body": ("label", "dedication"), "knob": ("pointer",)}   # logo on the front face, dedication raised inside, white knob pointer
STL_DIR, COLOR_DIR, ASM_DIR, REPORT = "stl", "stl/multicolour", "asm", "docs/verification.json"

PRINTER = dict(machine="Bambu Lab H2S 0.4 nozzle", process="0.20mm Standard @BBL H2S",
               bed="Textured PEI Plate", envelope_mm=(340, 320, 340))
PROCESS = dict(wall_loops=6, top_shell_layers=5, bottom_shell_layers=5, infill=30, pattern="gyroid")   # drop resistant
# Filament slots of the project 3MF, 1-based in this order; inlay slots name their inlay or a tuple of inlays
FILAMENTS = [dict(material="PETG-white", profile="Bambu PETG Basic @BBL H2S", colour="#FFFFFF"),
             dict(material="PETG-grey", profile="Bambu PETG Basic @BBL H2S", colour="#8E9294"),
             dict(material="PETG-grey", profile="Bambu PETG Basic @BBL H2S", inlay=("label", "dedication"), colour="#8E9294"),
             dict(material="TPU", profile="Generic TPU @BBL H2S", colour="#222326"),
             dict(material="PETG-white", profile="Bambu PETG Basic @BBL H2S", inlay=("pointer",), colour="#FFFFFF")]
PLATES = [("Housing", ["body"]), ("Back cover", ["back"]), ("Grey parts", ["grille", "cover", "handle", "knob"]), ("TPU feet", ["foot"])]
PROJECT_3MF = "stl/leo_ac1_all_parts.3mf"
SLICER_SUMMARY = "docs/slicer-summary.json"

LIMITATIONS = ["Bought parts as envelopes (fan block, battery cylinder), no vendor CAD",
               "Screws without threads, heads simplified",
               "Sampled motion, no continuous swept-volume proof",
               "No flexible deformation, physical fit, strength, airflow or thermal validation"]



def checks(ctx):
    """Project-specific checks after export; ctx helpers are described in the skill template (print_project.py).
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
    assert m["handle_mount_wall"] >= 6, "Handle mount: top wall with doubler at least 6 mm under the feet"
    assert m["foot_clearance"] >= 0.2 and m["foot_lift"] >= 3, "TPU feet: clearance 0.2 mm in the pockets, housing at least 3 mm above the ground"
    # dedication: the lines must stay apart (descenders!); letters of the grey inlay in print orientation, merged by their y spans
    import trimesh
    from pathlib import Path
    spans = sorted((float(c.bounds[0, 1]), float(c.bounds[1, 1]))
                   for c in trimesh.load_mesh(Path(__file__).parent / "build" / "color" / "body_dedication.stl").split(only_watertight=False))
    bands = []
    for y0, y1 in spans:
        if bands and y0 <= bands[-1][1] + 1.0:
            bands[-1][1] = max(bands[-1][1], y1)
        else:
            bands.append([y0, y1])
    gaps = [round(b[0] - a[1], 2) for a, b in zip(bands, bands[1:])]
    assert len(bands) == m["dedication_lines"], f"Dedication lines touch or run into each other (gap < 1 mm): {len(bands)} bands, gaps {gaps}"
    screws = {name: dict(length=length, engagement_mm=round(eng, 2), tip_margin_mm=round(margin, 2))
              for name, length, eng, margin in m["screws"]}
    for name, info in screws.items():
        # at least 1 x d in the brass inserts; the fan screws sit on 1 mm silicone pads
        assert info["engagement_mm"] >= 3 and info["tip_margin_mm"] >= 0.3, f"Screw {name}: {info}"

    # Contact, not just freedom from overlap: moved 0.05 mm towards its support, a body must intersect it
    contacts = ctx.contacts([("grille", "body", [0, 1, 0]), ("fan", "body", [0, -1, 0]), ("back", "body", [0, -1, 0]),
                             ("cover", "body", [-1, 0, 0]), ("battery", "body", [0, 0, -1]), ("handle", "body", [0, 0, -1]),
                             ("pot", "body", [1, 0, 0]), ("pot_nut", "body", [-1, 0, 0]), ("chg_module", "body", [1, 0, -1]),
                             ("led", "body", [0, -1, 0]), ("feet", "body", [0, 0, 1]), ("usb_trigger", "back", [0, 1, 0]),
                             ("switch", "back", [0, -1, 0])])

    # Stops: the battery may move only a little before the back cover or the shelf holds it
    stops = ctx.stops([("battery_back", "battery", "back", [0, 1, 0], 1.5),
                       ("battery_up", "battery", "body", [0, 0, 1], m["shelf_gap"] + 0.5),
                       ("battery_side", "battery", "body", [1, 0, 0], 1.0),
                       ("usb_trigger_push", "usb_trigger", "body", [0, -1, 0], 1.0)])

    # Running clearance of the turning knob; charge module kept away from the fan for the air stream
    clearances = ctx.clearances([("knob", ["body", "cover"], 0.4), ("chg_module", "fan", 5.0)])

    # Round air duct: wall closed all around, small gap to the fan, end ring completely on the fan frame face
    (ax, az), fy, (r0, r1), gap = m["fan_axis"], m["fan_y"], m["shroud_r"], m["shroud_gap"]
    ring = lambda y, length, ra, rb: (ctx.cylinder([ax, y, az], (0, 1, 0), length, rb)
                                      - ctx.cylinder([ax, y, az], (0, 1, 0), length, ra))
    # inner 2 mm of the wall: closed all around (the grille insert pockets may reach into the outer part of a thick wall)
    wall_probe = ring(fy - gap - 1.2, 0.8, r0 + 0.2, min(r1 - 0.2, r0 + 2))
    gap_probe = ring(fy - gap + 0.02, gap - 0.04, r0 + 0.2, r1 - 0.2)
    # the fan is a solid frame envelope: this checks the tube end against the envelope, not against the real frame contour
    face_probe = ring(fy + 0.1, 0.5, r0, min(r1, m["fan_size"] / 2 - 0.1))
    duct = dict(wall_fill=round((wall_probe ^ ctx.solids["body"]).volume() / wall_probe.volume(), 4),
                gap_mm3=round((gap_probe ^ ctx.solids["body"]).volume(), 4),
                on_fan_frame=round((face_probe ^ ctx.solids["fan"]).volume() / face_probe.volume(), 4))
    assert duct["wall_fill"] > 0.999 and duct["gap_mm3"] < 0.01 and duct["on_fan_frame"] > 0.999, f"Air duct {duct}"
    ctx.summary.append("air duct")

    # Assembly paths in a realistic removal order
    others = lambda *names: [n for n in ctx.solids if n not in names]
    # PWM board with the potentiometer: after knob, cover and nut, away from the wall until the shaft is clear, then out the back
    clear_x = m["pot_shaft_len"] + m["wall"] + 1
    paths = ctx.paths([
            ("grille_front", ["grille", "screws_grille"], ["body", "fan", "screws_fan"], [0, -1, 0], 12, 0.25),
            ("back_off", ["back", "screws_back", "usb_trigger", "switch"], others("back", "screws_back", "usb_trigger", "switch"), [0, 1, 0], 12, 0.25),
            ("battery_out", ["battery"], others("battery", "back", "screws_back", "usb_trigger", "switch"), [0, 1, 0], 90, 1),
            ("chg_module_out", ["chg_module"], others("chg_module", "back", "screws_back", "usb_trigger", "switch"), [0, 1, 0], 45, 1),
            ("fan_out", ["fan", "screws_fan"], others("fan", "screws_fan", "battery", "chg_module", "back", "screws_back", "usb_trigger", "switch"), [0, 1, 0], 90, 1),
            ("knob_off", ["knob"], others("knob"), [1, 0, 0], 25, 0.5),
            ("cover_off", ["cover"], ["body", "pot", "pot_nut", "pwm_board", "knob"], [1, 0, 0], 30, 0.5),   # glued in; the knob can stay on
            ("handle_up", ["handle"], ["body"], [0, 0, 1], 15, 0.5),
            ("feet_down", ["feet"], ["body"], [0, 0, -1], 6, 0.5),
            # the USB-C module comes off with the back cover (back_off), then out of its channel
            ("usb_trigger_from_back", ["usb_trigger"], ["back"], [0, -1, 0], 16, 0.5),
            ("switch_out", ["switch"], ["back"], [0, 1, 0], 25, 0.5),
            ("pwm_board_out", ["pot", "pwm_board"], others("pot", "pot_nut", "pwm_board", "knob", "cover", "back", "screws_back", "usb_trigger", "switch"),
             [([-1, 0, 0], clear_x, 0.5), ([0, 1, 0], 90, 1)])])
    ctx.summary.append(f"{len(paths)} paths")

    # Insert pockets: core open, datasheet wall around it and the floor ring below it material
    inserts = ctx.insert_probes(m["inserts"])
    ctx.summary.append(f"{len(inserts)} inserts")

    ctx.open_items.append("Battery cell measured Ø32.5 × 71.6 mm on 2026-09-15; verify protection-board envelope and cable exit separately")
    ctx.open_items.append("PWM potentiometer measured: round split/knurled Ø5.8 shaft, free length 9.5, bushing Ø6.73 × 3.6, nut 10 across flats × 2.15, washer Ø11 × 0.35 (measured); verify knob push-fit and clamp")
    ctx.open_items.append("Battery BMS board approx. 20 mm wide over the full length (measured); thickness 4 mm and cable exit still to be measured")
    ctx.open_items.append("PWM module measured 41.05 × 32 × 15 mm, 56.30 mm to shaft tip, axis about 6 mm above PCB; modelled 18 mm high with plugged fan connector (estimate); verify underside datum")
    ctx.open_items.append("USB-C module and shell measured 2026-09-15 (shell bottom approximately 1.1 mm above module underside); verify fit with a plugged cable and soldered wires, and check 5 V at + / - before connecting")
    ctx.open_items.append("Switch measured 20.9 × 14.7 × 23 mm including contacts, cutout 19.2 × 12.2, panel about 1.5; verify depth split before/behind mounting flange and snap fit")
    ctx.open_items.append("Charge PCB measured 32.2 × 11 × 3.7 mm, back clear; heatsinks not yet available, displayed heatsinks are planned clearance envelopes")
    return dict(dedication_line_gaps_mm=gaps, standard_screws=screws, contact_volumes_mm3=contacts, stops=stops, clearances=clearances,
                sampled_paths=paths, insert_probes=inserts, air_duct=duct)


VIEWER = dict(
    title="LEO-AC1", page_title="LEO-AC1 fan", eyebrow="Assembly · installed position",
    dims=[("Width", "239.8"), ("Depth", "84"), ("Height", "201.5")],
    groups=[("white", "Printed · PETG white"), ("grey", "Printed · PETG grey"),
            ("tpu", "Printed · TPU"), ("screws", "Screws M3"), ("bought", "Bought parts")],
    hidden_groups=["bought"],
    outer=["body", "back", "cover", "grille", "handle", "feet", "screws_grille", "screws_back", "screws_handle", "screws_feet"],
    cut=["back", "cover", "screws_back"],
    # id, label, group, colour, quantity, explode direction (mm per slider mm)
    parts=[("body", "Housing", "white", "#f2f2ee", "1x", [0, 0, 0]),
           ("back", "Back cover", "white", "#e6e6e1", "1x", [0, 1.5, 0]),
           ("grille", "Fan grille", "grey", "#8f9396", "1x", [0, -1, 0]),
           ("cover", "Service cover", "grey", "#8f9396", "1x", [1, 0, 0]),
           ("handle", "Handle", "grey", "#8f9396", "1x", [0, 0, 1.2]),
           ("knob", "Speed knob", "grey", "#8f9396", "1x", [2, 0, 0]),
           ("feet", "Feet · TPU", "tpu", "#222326", "2x", [0, 0, -0.8]),
           ("fan_visual", "Fan Noctua NF-F12 iPPC-2000", "bought", "#303236", "1x", [0, 0.8, 0]),
           ("battery", "Battery LiFePO4 3.2 V 6000 mAh", "bought", "#3f7fbf", "1x", [0, 0.5, 0]),
           ("pot", "Potentiometer · measured shaft, conservative body envelope", "bought", "#3a3d41", "1x", [-0.5, 0, 0]),
           ("chg_module", "Charge/boost module · 2 planned heatsink envelopes", "bought", "#c9c9c9", "1x", [0, 0.8, 0]),
           ("led", "USB power indicator LED 3 mm, behind the O", "bought", "#9fd3ff", "1x", [0, 1, 0]),
           ("usb_trigger", "USB-C PD trigger, 5 V (Type A)", "bought", "#4b2a7a", "1x", [0, 1.5, 0]),
           ("switch", "Measured power switch · depth split provisional", "bought", "#1b1b1b", "1x", [0, 1.8, 0]),
           ("pwm_board", "PWM board CNY-FA5-PRO · 41.05 × 32 × 15 mm, unplugged", "bought", "#2e6b3f", "1x", [-0.5, 0, 0]),
           # screws leave their part: same direction, further out
           ("screws_grille", "Grille · M3 × 12 button head", "screws", "#26282b", "4x", [0, -1.6, 0]),
           ("screws_fan", "Fan · M3 × 30 button head", "screws", "#26282b", "4x", [0, 1.4, 0]),
           ("screws_back", "Back cover · M3 × 8 button head", "screws", "#26282b", "6x", [0, 2.2, 0]),
           ("screws_handle", "Handle · M3 × 12 button head", "screws", "#26282b", "4x", [0, 0, -0.5]),
           ("screws_feet", "Feet · M3 × 8 button head, from below", "screws", "#26282b", "4x", [0, 0, -1.4])],
    colour={"body": [("label", "Housing · logo", "#8f9396"), ("dedication", "Housing · dedication", "#8f9396")], "knob": [("pointer", "Speed knob · pointer", "#ffffff")]},
    bodies={"body_base": 'body_install_pose() body_piece("base");',
            "body_label": 'body_install_pose() body_piece("label");',
            "body_dedication": 'body_install_pose() body_piece("dedication");',
            "knob_base": 'knob_install_pose() knob_piece("base");',
            "knob_pointer": 'knob_install_pose() knob_piece("pointer");',
            # Noctua CAD (vendor/, not in the repo): outlet face with stator vanes and hub label at CAD y = 0.3, towards the front
            "fan_visual": 'translate([fan_cx, fan_y - 0.3, fan_cz]) import("$ROOT/vendor/noctua/NF-F12_iPPC.stl");',
            "pot": "pot_env();",
            "screws_grille": "screws_grille(true);",
            "screws_fan": "screws_fan(true);",
            "screws_back": "screws_back(true);",
            "screws_handle": "screws_handle(true);",
            "screws_feet": "screws_feet(true);"},
    output="build/viewer.html",
)

VIEWS = {"01_assembly": ("assembly();", "-160,-330,230,112,40,70"),
         "02_back": ("assembly();", "420,380,230,112,40,70"),
         "03_exploded": ("assembly(40);", "-200,-380,260,112,40,70"),
         # front turned up (OpenSCAD renders faces towards -y dark), oblique so the grooves show
         "04_front_right": ("rotate([-90, 0, 0]) intersection() { assembly(); translate([150, -10, 0]) cube([80, 20, 155]); }",
                            "189,-260,420,189,78,0"),
         # air duct from behind: body cut at 30 mm depth, fan hidden
         # public images: every body coloured (uncoloured cut faces take the scheme's back-face colour), dedication hidden
         "05_duct": ('color("#f2f2ee") intersection() { body(dedication = false); translate([-1, -1, -1]) cube([body_w + 2, 30, body_h + 2]); }',
                     "112,420,300,112,0,77"),
         # service cover with the speed knob, from the right
         "06_knob": ("intersection() { assembly(); translate([165, 0, 20]) cube([100, 80, 140]); }",
                     "420,-120,200,230,40,90"),
         # charge/boost module on the partition in the air stream, from the back with the back cover removed
         "08_charge_module": ("intersection() { union() { color(\"#f2f2ee\") body(); color(\"#c9c9c9\") chg_module_env(); } translate([118, 14, 30]) cube([38, 62, 110]); }", "40,250,170,148,50,85"),
         # LED pocket behind the O, cut through the LED axis and seen from behind: 0.8 mm white skin in front of the LED
         "09_led": ("intersection() { union() { color(\"#f2f2ee\") body(); color(\"#9fd3ff\") led_env(); } translate([led_xz[0] - 9, -1, led_xz[1] - 8]) cube([18, 10, 8]); }",
                    "232,40,178,207,3,131"),
         # handle mount from below: doubler, ribs and screws under the right foot, cut at the screw axis, with the handle keys
         "11_handle_mount": ("rotate([0, 0, 180]) rotate([90, 0, 0]) intersection() { union() { color(\"#f2f2ee\") body(dedication = false); color(\"#8f9396\") handle(); color(\"#26282b\") screws_handle(); } translate([150, -1, 125]) cube([76, handle_cy + 1, 60]); }",
                             "-185,95,215,-185,150,40"),
         # back cover insert boss in the top left corner from behind and below, back cover off: column and cone into the corner
         "12_back_bosses": ('color("#f2f2ee") intersection() { body(); translate([-1, 30, 105]) cube([45, body_d, 60]); }',
                            "110,190,60,12,62,142"),
         # left TPU foot cut at its screw axes, seen from the right: pocket, insert boss, screw, recessed head
         "13_foot_mount": ('intersection() { union() { color("#f2f2ee") body(); color("#222326") place_feet(); color("#26282b") screws_feet(true); } translate([-1, 0, -10]) cube([foot_inset + 1, body_d, 30]); }',
                           "130,40,-35,17,40,2"),
         # USB-C charging socket in the back cover, cut at its axis and seen from above: plate, channel, module, stop on the wall
         "14_usb_c": ('intersection() { union() { color("#f2f2ee") body(); color("#e6e6e1") back(); color("#4b2a7a") usbc_env(); } translate([196, 48, usbc_xz[1] - 20]) cube([30, 36, 20]); }',
                      "205,40,156,208,66,44"),
         # power switch in its well above the USB-C socket, cut at the switch axis and seen from the left
         "15_switch": ('intersection() { union() { color("#e6e6e1") back(); color("#1b1b1b") sw_env(); } translate([sw_xz[0], 40, sw_xz[1] - 20]) cube([30, 45, 40]); }',
                       "90,40,170,201,70,125"),
         # battery saddles on the inside of the back cover: root fillets and the rib behind the battery, seen from the front
         "16_saddles": ('color("#e6e6e1") intersection() { back(); translate([150, 20, 0]) cube([76, 61, 90]); }', "120,-60,120,186,60,40"),
         # underside with the M5 mount insert
         "07_underside": ('color("#f2f2ee") body(); color("#222326") place_feet(); color("#26282b") screws_feet(true);', "40,-160,-260,112,40,40")}
