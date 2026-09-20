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
- Commits: English message, one change per commit, ending with the co-author line.
- Forgejo remote: `the user's private Forgejo remote`.

## User constraints and preferences

- Toy for the user's son: drop-resistant (walls ≥ 3.2 mm, corner radius ≥ 5), grille openings ≤ 6 mm, no sharp edges.
- Screws only ISO 7380 button head Torx from the user's set: M3 × 6/8/10/12/16/25, M4 × 12; M3 × 30 for the fan is bought separately. No countersunk screws.
- Ruthex inserts per datasheet (RX series 08/2022): M3x5.7 hole 4.0, depth ≥ L + 1, wall ≥ 1.6, ≥ 3 mm material to visible faces; M5x9.5 hole 6.4, wall ≥ 2.6. Inserts must be pressable from an accessible side.
- Printer Bambu Lab H2S with AMS, Bambu PETG HF white/grey (plenty in stock), TPU for the feet. Housing white, grille/cover/handle/knob grey.

## Measured hardware (2026-09-15, measured by the user)

| Part | Value [mm] | Status |
|---|---|---|
| Battery cell body | Ø 32.50 × 71.60 | measured without the side BMS board |
| Battery BMS | approx. 20 wide over the full cell length, 4 thick | measured (width approx.); cable exit open |
| PWM module PCB | 41.05 × 32.00 × 1.6 | measured |
| PWM module height | 15.00 without fan connector; modelled 18 with plugged connector | measured without connector, +3 estimated (user); datum = PCB underside (assumed) |
| PWM module + pot to shaft tip | 56.30 | measured |
| Pot shaft | round, knurled, split, Ø 5.80, free length 9.50 | measured |
| Pot thread | Ø 6.73 × 3.60 | measured |
| Pot axis above PCB top | approx. 6.00 | approximate |
| Pot nut | 10 across flats (11.6 across corners), 2.15 thick | measured |
| Pot washer | Ø approx. 11, 0.35 thick | measured |
| Charge module | 32.20 × 11.00 × 3.70, back clear | measured; no heatsinks yet (modelled envelopes are reservations) |
| Charge module tape | 1.1 | **assumed** (VHB) |
| USB-C module | 12.88 × 10.35 × 4.30 + receptacle projection 1.50 | measured |
| USB-C shell | 8.90 × 3.22, underside approx. 1.10 above module underside | measured / approximate; lateral centring assumed |
| Rocker switch | 20.90 × 14.70, depth 23.00 incl. contacts, cut-out 19.20 × 12.20, panel approx. 1.50, bezel 2 + rocker 5 above the panel | measured; body depth behind the panel **assumed** |

## Current design state (details in `leo_ac.scad` parameters)

- Knob Ø 28 on the right wall at z 107.3 (PWM board on 15 mm ribs); pot shoulder on the full inner wall, washer + nut in an outside counterbore Ø 15 (wrench room) with a 1.0 mm clamped ring (0.1 mm thread reserve); knob ≥ 6 mm proud of the cover, 9 mm on the shaft, slotted clamping sleeve, white pointer inlay.
- Service cover below the knob with a half-round notch, glued: 1.2 mm rim in a 45° groove.
- Back cover: USB-C module low right (x 205, z 44) in a channel, 1.5 mm skin for a flush receptacle, 4 × 6 mm wedge stop on the right wall; rocker switch top right (x 201, z 124) in an 8 mm deep 45° well (rocker 1 mm below the back face), floor 1.5 mm, 0.2 mm floor margin (no support needed), well wall 2.2 mm horizontal = 1.56 mm across the flank.
- Partition with two cable notches (z 44 and 126); charge module centred between them, 5 mm behind the fan, 4.5 mm off the partition.
- Battery saddles on the back cover with root fillets and a tie rib; BMS cut-out 25 × 5.5 mm for the approx. 20 mm board.
- Dedication (3 lines, 6/6/4 mm) raised in grey on the inside of the front plate above the PWM module; line gaps are checked on the inlay mesh.
- TPU feet screwed (2 × M3 × 8 each) into outside-pressed inserts; handle with doubled top wall, ribs and keys; M5 insert in the underside.

## Open items

- Measure: battery cable exit; PWM underside parts; switch body depth behind the panel; USB-C shell height/centring with a plugged cable; tape thickness; heatsinks if added.
- Fit tests before the full print: `test_*` parts (quantity 0, not in the project 3MF) are slices of the real body/back cover made with `slice_box()` — pot counterbore with washer/nut, USB-C channel with plugged cable, switch well with clips, battery ring with BMS, horizontal M3 foot insert and M5 mount insert — plus one knob on the real shaft and one TPU foot. Adjust parameters after the user's results.
- Wiring: stow the 400 mm fan cable, keep wires out of the fan, saddles and back lip; leave slack at the back-cover modules.
- Measure the boost converter idle current, then decide the switch position (battery line vs. O+). Check charge-module temperature in the closed housing, also charging with the fan off.
- Air duct vs. real fan frame: the duct check uses the fan envelope; the real Noctua frame has chamfers, some back-flow is possible (a foam ring could help).

## Verification and known limits

- `print_tools.py export` checks meshes, bed placement, 210 assembly pairs, alignment of round features from the CSG dumps (201 coaxial pairs, none 0.2–2 mm off axis), contacts, stops, clearances (knob ≥ 0.4 running clearance, charge module ≥ 5 mm from the fan), 12 removal paths, 23 insert probes, screw engagement, colour pieces and project checks in `print_project.py` (knob, handle, feet, dedication line gaps). Reports: `docs/verification.json`, `docs/slicer-summary.json`.
- `analyze.py thickness` finds two walls under 1.2 mm, both intended: the 1.0 mm clamped ring at the pot (body, right wall) and the 0.8 mm skin in front of the LED. The switch-well wall was raised to 1.56 mm across its 45° flanks.
- Bought parts are envelopes; no strength, airflow, thermal or physical fit validation. Nothing has been printed.
- Accepted small overhangs: groove ends, screw-head pocket rings, knob flutes, connector openings, switch-floor ledge.
- Freshly exported CGAL STLs (body, cover) are not byte-identical to committed ones; compare geometry, re-slice after export.
