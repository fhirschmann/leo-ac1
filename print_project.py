"""Computed settings and checks for the openscad-print-project tools (opp, pinned in requirements.txt).

The static settings are in opp.toml; this file keeps only the project checks.
"""
import math


def checks(ctx):
    """Project-specific checks after export; ctx helpers are described in the skill template (print_project.py).
    Assert failures abort the run; the returned dict goes into the report."""
    m = ctx.metrics
    assert min(m["wall"], m["front_t"]) >= 3.2 and m["back_t"] >= 3 and m["corner_r"] >= 5, "Drop resistance: walls and corner radius"

    # Standard dimensions, independent of the model
    assert (m["fan_size"], m["fan_t"], m["fan_pitch"]) == (140, 25, 124.5), "140 mm fan: 140 x 140 x 25, holes 124.5 mm apart"
    assert m["fan_hole_d"] >= 4.3, "140 mm fan holes are 4.3 mm"
    assert m["open_d"] > m["fan_blade_d"], "Front opening covers the fan blades"
    assert m["insert_hole_d"] == 4.0 and m["insert_len"] == 5.7, "Ruthex M3 insert: hole 4.0 mm, length 5.7 mm"
    # Ruthex datasheet RX series (08/2022): M3x5.7 hole 4.0, depth >= L + 1, wall >= 1.6; M5x9.5 hole 6.4, L 9.5, wall >= 2.6
    assert m["insert_depth"] >= m["insert_len"] + 1 and m["insert_w_min"] >= 1.6, "Ruthex M3: hole depth L + 1 mm, wall 1.6 mm"
    assert m["mount_insert"] == [6.4, 9.5, 2.6] and m["mount_floor"] >= 2, "Ruthex M5x9.5: hole 6.4, length 9.5, wall 2.6; 2 mm floor"
    assert m["grille_gap"] <= 6, "Grille openings above 6 mm let children's fingers through"
    assert m["knob_shaft_engagement"] >= 8 and m["knob_top_skin"] >= 2 and m["knob_protrusion"] <= 9, "Knob: on the shaft, at most 9 mm in front of the cover"
    # L bail (user): pivots at mid-depth, carried with the bar above the pivot so the fan hangs level
    assert m["bail_clearance"] >= 38 and m["bail_grip"] >= 90 and 90 < m["bail_carry"] < 160, "Bail: 38 mm hand room, 90 mm hand breadth, carrying angle past vertical"
    assert m["bail_insert"][0] == 5.6, "Ruthex M4 insert: hole 5.6 mm"
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
    contacts = ctx.contacts([("fan", "body", [0, -1, 0]), ("back", "body", [0, -1, 0]),
                             ("cover", "body", [-1, 0, 0]), ("battery", "body", [0, 0, -1]), ("bail", "body", [0, 0, -1]),
                             ("bail_up", "body", [0, -math.sin(math.radians(m["bail_carry"])), math.cos(math.radians(m["bail_carry"]))]),   # stop at the carrying angle
                             ("pot", "body", [1, 0, 0]), ("pot_nut", "body", [-1, 0, 0]),
                             ("chg_holder", "body", [0, 0, -1]), ("chg_holder", "body", [1, 0, 0]),   # on the ledge, socket floors on the pads ("chg_module", "chg_holder", [1, 0, -1]),
                             ("chg_sink", "chg_module", [-1, 0, 0]),
                             ("led", "body", [0, -1, 0]), ("feet", "body", [0, 0, 1]), ("usb_trigger", "back", [0, 1, 0]),
                             ("switch", "back", [0, -1, 0])])

    # Stops: the battery may move only a little before the back cover or the shelf holds it
    stops = ctx.stops([("battery_back", "battery", "back", [0, 1, 0], 1.5),
                       ("battery_up", "battery", "body", [0, 0, 1], m["shelf_gap"] + 0.5),
                       ("battery_side", "battery", "body", [1, 0, 0], 1.0),
                       ("usb_trigger_push", "usb_trigger", "body", [0, -1, 0], 1.0),
                       ("chg_module_hooks", "chg_module", "chg_holder", [-1, 0, 0], 0.5)])   # the snap hooks hold the board

    # Running clearance of the turning knob; charge module kept away from the fan for the air stream
    clearances = ctx.clearances([("knob", ["body", "cover"], 0.4), ("chg_module", "fan", 5.0), ("chg_holder", "fan", 1.5), ("chg_sink", ["fan", "chg_holder"], 0.9)])

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

    # Assembly paths in a realistic removal order; the bail is swung up (bail_up) before the back cover comes off
    others = lambda *names: [n for n in ctx.solids if n not in names]
    # PWM board with the potentiometer: after knob, cover and nut, away from the wall until the shaft is clear, then out the back
    clear_x = m["pot_shaft_len"] + m["wall"] + 1
    paths = ctx.paths([
            ("back_off", ["back", "screws_back", "usb_trigger", "switch"], others("back", "screws_back", "usb_trigger", "switch", "bail"), [0, 1, 0], 12, 0.25),   # bail swung up first
            ("battery_out", ["battery"], others("battery", "back", "screws_back", "usb_trigger", "switch", "bail"), [0, 1, 0], 90, 1),
            # the snap hooks spring open (not a rigid path): off the back stops towards the fan section, against everything but the holder
            ("chg_module_unclip", ["chg_module", "chg_sink"], others("chg_module", "chg_sink", "chg_tie", "chg_holder", "back", "screws_back", "usb_trigger", "switch", "bail"),
             [([0, 0, 1], 3.5, 0.25), ([-1, 0, 0], 4, 0.25)]),   # hooks spread: up out of the L, then off the back stops
            ("chg_holder_off", ["chg_holder"], ["body"], [-1, 0, 0], 6, 0.25),   # the sockets slide off the pads (before gluing)
            ("screws_fan_out", ["screws_fan"], others("screws_fan", "fan", "back", "screws_back", "usb_trigger", "switch", "bail"), [0, 1, 0], 40, 1),
            # the charge module holder is glued in and stays: off the duct ring, sideways past the holder, then out the back
            ("fan_out", ["fan"], others("fan", "screws_fan", "battery", "chg_module", "chg_sink", "chg_tie", "back", "screws_back", "usb_trigger", "switch", "bail"),
             [([0, 1, 0], 1, 0.5), ([-1, 0, 0], m["fan_side_shift"], 0.5), ([0, 1, 0], 90, 1)]),
            ("knob_off", ["knob"], others("knob"), [1, 0, 0], 25, 0.5),
            ("cover_off", ["cover"], ["body", "pot", "pot_nut", "pwm_board", "knob"], [1, 0, 0], 30, 0.5),   # glued in; the knob can stay on
            ("bail_up", ["bail"], ["body"], [0, 0, 1], 15, 0.5),   # after its pivot screws
            ("feet_down", ["feet"], ["body"], [0, 0, -1], 6, 0.5),
            # the USB-C module comes off with the back cover (back_off), then out of its channel
            ("usb_trigger_from_back", ["usb_trigger"], ["back"], [0, -1, 0], 16, 0.5),
            ("switch_out", ["switch"], ["back"], [0, 1, 0], 25, 0.5),
            ("pwm_board_out", ["pot", "pwm_board"], others("pot", "pot_nut", "pwm_board", "knob", "cover", "back", "screws_back", "usb_trigger", "switch", "bail"),
             [([-1, 0, 0], clear_x, 0.5), ([0, 0, 1], m["pwm_lift"], 0.5), ([0, 1, 0], 90, 1)])])   # lift the solder pins over the back pads
    # then out the back past the glued holder, from the unclipped position
    fixed = others("chg_module", "chg_sink", "chg_tie", "back", "screws_back", "usb_trigger", "switch", "bail")
    ctx.solids["chg_module_unclipped"] = (ctx.solids["chg_module"] + ctx.solids["chg_sink"]).translate([-4, 0, 3.5])
    paths += ctx.paths([("chg_module_out", ["chg_module_unclipped"], fixed, [0, 1, 0], 45, 1)])
    del ctx.solids["chg_module_unclipped"]
    ctx.summary.append(f"{len(paths)} paths")

    # Insert pockets: core open, datasheet wall around it and the floor ring below it material
    inserts = ctx.insert_probes(m["inserts"])
    ctx.summary.append(f"{len(inserts)} inserts")

    return dict(dedication_line_gaps_mm=gaps, standard_screws=screws, contact_volumes_mm3=contacts, stops=stops, clearances=clearances,
                sampled_paths=paths, insert_probes=inserts, air_duct=duct)
