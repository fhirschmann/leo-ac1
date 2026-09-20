# AGENTS.md — working on LEO-AC1

Internal notes for coding agents (Claude, Codex). The README is public and stays free of process notes, audits, assumptions and tool internals; put those here.

## Working rules

- Talk to the user in German. README, AGENTS.md, code comments, viewer labels, slicer plate/material names and check messages are English.
- The project follows the skill `openscad-print-project` (`~/.claude/skills/openscad-print-project`). After every model change run the full loop: `print_tools.py export` → `analyze.py islands/overhangs/inlays/thickness` → `slice_check.py` → update README numbers → `build_viewer.py` and republish the viewer artifact → commit.
- `scripts/` must stay identical to the skill (`python3 ~/.claude/skills/openscad-print-project/scripts/skill_sync.py status -C .`). Improve tools in the skill and adopt/install them; no project-local forks.
- No painted or scripted local supports. Design geometry so every part prints without supports (45° flanks, short ledges); the user relies on Bambu Studio's own supports if ever needed.
- Viewer artifact (republish from `build/viewer.html`, keep the URL): a private Claude viewer artifact
- README images (`img/`, `VIEWS`) are public: transparent renders for dark pages, every body coloured, no image of the dedication (`body(dedication = false)` in views that see the inside of the front plate). Two-column image table in the README.
- After rendering README images, set each image link's `?v=` query to the first 12 hex digits of that PNG's SHA-256. Forgejo's branch image URLs can retain older cached PNGs even after a page reload.
- Commits: English message, one change per commit, ending with the co-author line; push to Forgejo right after every commit (user), no force push without an explicit request.
- Forgejo remote: `the user's private Forgejo remote`.

## User constraints and preferences

- Toy for the user's son: drop-resistant (walls ≥ 3.2 mm, corner radius ≥ 5), grille openings ≤ 6 mm, no sharp edges.
- Screws only ISO 7380 button head Torx from the user's set: M3 × 6/8/10/12/16/25; M3 × 30 for the fan is bought separately; the bail pivots use the user's M4 shoulder screws (head Ø 8.8 × 3, shoulder Ø 5 × 11, thread 8) with flanged brass bushings (Ø 7 / 5 × 10, flange Ø 10 × 1) as on the leoino case. No countersunk screws.
- Ruthex inserts per datasheet (RX series 08/2022): M3x5.7 hole 4.0, depth ≥ L + 1, wall ≥ 1.6, ≥ 3 mm material to visible faces; M5x9.5 hole 6.4, wall ≥ 2.6. Inserts must be pressable from an accessible side.
- Printer Bambu Lab H2S with AMS, Bambu PETG HF white/grey (plenty in stock), TPU for the feet. Housing white, grille/cover/bail/knob grey.

## Measured hardware (2026-09-15, measured by the user)

| Part | Value [mm] | Status |
|---|---|---|
| Battery cell body | Ø 32.50 × 71.60 | measured without the side BMS board |
| Battery BMS | approx. 20 wide over the full cell length, 4 thick | measured (width approx.); cable exit open |
| PWM module PCB | 41.05 × 32.00 × 1.6 | measured |
| PWM underside | solder pins 2–3 below the PCB; pin-free strips approx. 1.5 wide along both long edges | measured 2026-09-16 (the old full-width ribs pressed on the pins, board stood crooked) |
| PWM module height | 15.00 without fan connector; modelled 18 with plugged connector | measured without connector, +3 estimated (user); datum = PCB underside (assumed) |
| PWM module + pot to shaft tip | 56.30 | measured |
| Pot shaft | round, knurled, split, Ø 5.80, free length 9.50 | measured |
| Pot thread | Ø 6.73 × 5.00 from the housing shoulder | measured again 2026-09-16 (earlier 3.60) |
| Pot axis above PCB top | approx. 6.00 | approximate; modelled 6.30 so the axis stayed put when the supports went 0.3 lower (user) |
| Pot nut | 10 across flats (11.6 across corners), 2.15 thick | measured |
| Pot washer | Ø approx. 11; nut and washer together 3.00 | measured (washer modelled 0.85) |
| Pot housing | 13 × 13 square envelope | **assumed** (12 mm pot) |
| Charge module | 32.20 × 11.00 × 3.70, back clear | measured; no heatsinks yet (modelled envelopes are reservations) |
| Charge module tape | 1.1 | **assumed** (VHB) |
| USB-C module | 12.88 × 10.35 × 4.30 + receptacle projection 1.50 | measured |
| USB-C shell | 8.90 × 3.22, underside approx. 1.10 above module underside | measured / approximate; lateral centring assumed |
| Rocker switch | 20.90 × 14.70, depth 23.00 incl. contacts, cut-out 19.20 × 12.20, panel approx. 1.50, bezel 2 + rocker 5 above the panel | measured; body depth behind the panel **assumed** |

## Current design state (details in `leo_ac.scad` parameters)

- Knob Ø 28 on the right wall at z 104.4. PWM board 14.7 mm above the shelf on 1.2 mm pads under its pin-free long edges: two 3 mm ribs notched 3.5 mm under the pins, running on behind the board up to the hold-down plate (back pads ≥ 3 mm thick); the left rib stays beside the battery cable slot. Removal path: off the wall, lift over the pads, out the back. Potentiometer housing in a round pocket R 10 from inside, PCB edge in a 0.95 mm slot; 1.8 mm wall under washer and nut, which sit on the flat outer face (0.2 mm thread reserve) inside the knob recess; the pockets keep ≥ 1.2 mm to the cover glue groove (assert). Knob ≥ 6 mm proud of the cover, 9 mm on the shaft, slotted clamping sleeve, white pointer inlay.
- Service cover below the knob with a half-round notch, glued: 1.2 mm rim in a 45° groove.
- Back cover: rocker switch and USB-C socket in one column near the right edge at x 201.5, both below the shelf (user: not in the middle, switch may go low). USB-C module on top (z 68, between the top battery saddle and the shelf) in a channel, 1.5 mm skin for a flush receptacle, 4 × 6 mm wedge stop on the right wall that ends 1 mm beside the battery removal path; rocker switch below (z 44, between two saddles; the saddle root fillets have gaps for the channel and the well) in an 8 mm deep 45° well (rocker 1 mm below the back face), floor 1.5 mm, 0.2 mm floor margin (no support needed), well wall 2.2 mm horizontal = 1.56 mm across the flank.
- Partition with two cable notches (z 44 and 126); charge module centred between them, 5 mm behind the fan, 4.5 mm off the partition.
- Battery saddles on the back cover with root fillets and a tie rib; BMS cut-out 25 × 5.5 mm for the approx. 20 mm board. Printed fit accepted by the user (2026-09-16); foam tape above and below clamps the battery, no geometry change.
- Dedication (3 lines, 6/6/4 mm) raised in grey on the inside of the front plate above the PWM module; line gaps are checked on the inlay mesh.
- TPU feet screwed (2 × M3 × 8 each) into outside-pressed inserts; L-shaped folding bail like the user's leoino case (user: L for more hand room, folds back): upper legs in steps (9.8 × 12 mm) along both top side edges from the pivot to the back edge, side walls full height in front; lower legs down behind the back cover to the grip centred at z 125 (user: not too low; just above the power switch, over part of the upper back intake slots); carried at bail_carry (117.3°, grip above the pivots, fan level), stopped by a ramp at the front of each step (the upper leg face touches the chamfered ramp at bail_carry, 0.015 mm gap; contact check `bail_up@body` along the leg face normal — the old clearance offset left 0.49 mm and 3 degrees of overtravel); 1 mm chamfers on the step edges (top edges of ramp and inner wall as one hull so they meet cleanly; also in the back-cover corners); bail built from fully chamfered boxes and a chamfered eye (`chamfered_box`); step shell clipped to the rounded outer outline; 39.8 mm hand room, 206 mm grip; pivot stack measured from the leoino STLs: step 12 mm wide, arm 11 mm with 0.5 mm to side face and wall, eye 8.8 mm wide flush with the inner arm face (outer 2.2 mm cut back for flange and head), bore Ø 7.0, Ruthex M4 hole Ø 5.6 × 8.1; the shoulder screw head stands about 2 mm out of the side face as on the leoino; top back-cover bosses moved inwards beside the steps, back-cover lip and corners cut for the legs; swing sampled at half and full carrying angle as extra assembly bodies; printed with the back faces of the lower legs on the bed; swing the bail up before the back cover comes off (back_off path); M5 insert in the underside.

## Open items

- Measure: battery cable exit; PWM underside parts; switch body depth behind the panel; USB-C shell height/centring with a plugged cable; tape thickness; heatsinks if added.
- Fit test (user wants the whole right section, as little material as possible): `test_right` and `test_right_back` (quantity 0) are body and back cover from `part_x` to the right wall and from `shelf_z` up (user: only the upper part, battery holder and USB-C already confirmed), cut with `slice_box()` in print orientation; `TEST_PLATES` puts them with a knob into `stl/leo_ac1_fit_tests.3mf`, sliced with `TEST_PROCESS` (2 walls, 3 top/bottom, 10 % infill). Check: PWM board flat on its pads, potentiometer pocket, nut from outside, knob over washer and nut, LED, inserts (the power switch is below the shelf now, not in this test). The earlier small slices were removed.
- USB-C mechanical fit is confirmed (2026-09-16); full cable insertion and fit with soldered wires still need explicit confirmation. Results for the other fit tests are pending.
- Bail: check the Ruthex RX-M4x8.1 datasheet (hole 5.6 and depth 8.1 taken from the leoino case, wall 2.2 assumed); pinch check of the 0.5 mm gaps between arm, step wall and back cover on the print.
- Wiring: stow the 400 mm fan cable, keep wires out of the fan, saddles and back lip; leave slack at the back-cover modules.
- Measure the boost converter idle current, then decide the switch position (battery line vs. O+). Check charge-module temperature in the closed housing, also charging with the fan off.
- Air duct vs. real fan frame: the duct check uses the fan envelope; the real Noctua frame has chamfers, some back-flow is possible (a foam ring could help).

## Verification and known limits

- `print_tools.py export` checks meshes, bed placement, 253 assembly pairs, alignment of round features from the CSG dumps (296 coaxial pairs, none 0.2–2 mm off axis), contacts, stops, clearances (knob ≥ 0.4 running clearance, charge module ≥ 5 mm from the fan), 12 removal paths, 21 insert probes, screw engagement, colour pieces and project checks in `print_project.py` (knob, bail, feet, dedication line gaps). Reports: `docs/verification.json`, `docs/slicer-summary.json`.
- `analyze.py thickness` finds one wall under 1.2 mm, intended: the 0.8 mm skin in front of the LED. Until 2026-09-16 the CLI passed `--min-span` as the sharp-edge angle (2 degrees), which hid thin curved walls; fixed in the skill, re-run found nothing new. With `--min-span 0` the knob and bail report only edge and chamfer tips. The potentiometer wall under washer and nut is 1.8 mm; the switch-well wall 1.56 mm across its 45° flanks.
- Physical feedback (2026-09-16): the user has the printed parts and reports that the USB-C socket fits perfectly. No geometry adjustment is needed for this fit. The exact printed set and full cable insertion were not specified. The PWM board stood crooked because the full-width ribs pressed on its solder pins → pads under the pin-free long edges, 0.3 mm lower. The outside counterbore left the potentiometer wall too thin → housing pocket from inside, washer and nut on the flat outer face. The battery holder fits (foam tape).
- Bought parts are envelopes; physical fit is confirmed only for the USB-C socket. Strength, airflow, thermal performance and the remaining fits have not been validated.
- Accepted small overhangs: groove ends, screw-head pocket rings, knob flutes, connector openings, switch-floor ledge, PWM back pads (3.5 mm over the pin notch). `analyze.py overhangs test_right_back` reports the exact-45° switch-well flanks (about 120 mm² per layer) although the same flanks in `back` stay below the threshold: raster artifact of the shifted slice, not a real overhang. Likewise `overhangs bail` reports the exact-45° bed chamfer along the right lower leg only (about 165 mm², the mirrored left leg stays below the threshold).
- Freshly exported CGAL STLs (body, cover) are not byte-identical to committed ones; compare geometry, re-slice after export.
