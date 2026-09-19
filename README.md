# LEO-AC1 — a fan that looks like an air conditioner

Small battery fan for a child's room, styled like the outdoor unit of a split air conditioner (proportions of an 800 × 550 × 285 mm unit). A 120 mm PC fan blows forward through the round grille; air enters through the slots in the back cover and the left side. A round air duct between the front and the fan frame makes sure the air leaves at the front instead of circulating back into the housing. On the right of the front sits the logo "LEO INDUSTRIES AC-1" in custom block letters (LEO as stencil letters) above horizontal fake grooves like on Mitsubishi outdoor units; a breathing LED glued in behind the O glows through the white PETG while the charger is plugged in. Behind it is a bay for the battery (3.2 V 6000 mAh LiFePO4, JST-PH 2.0) and the electronics. Printed on a Bambu Lab H2S in PETG Basic white and grey.

![Assembly](img/01_assembly.png)

3D viewer (artifact, republished under the same URL after every model change): a private Claude viewer artifact

| Back | Exploded | Logo and grooves | Air duct from behind | Service cover with knob | Underside with M5 thread and TPU feet | Charge module in the air stream | LED pocket behind the O | Dedication inside the front | Handle mount, cut at the screws | Back cover bosses | TPU foot, cut at the screws | USB-C socket in the back cover, cut at its axis |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| ![Back](img/02_back.png) | ![Exploded](img/03_exploded.png) | ![Logo](img/04_front_right.png) | ![Air duct](img/05_duct.png) | ![Knob](img/06_knob.png) | ![Underside](img/07_underside.png) | ![Charge module](img/08_charge_module.png) | ![LED pocket](img/09_led.png) | ![Dedication](img/10_dedication.png) | ![Handle mount](img/11_handle_mount.png) | ![Back cover bosses](img/12_back_bosses.png) | ![TPU foot mount](img/13_foot_mount.png) | ![USB-C socket](img/14_usb_c.png) |

## Printed parts

| Part | Qty | Material | Size (mm) | Print orientation |
|---|---|---|---|---|
| `body` housing | 1 | PETG white + grey (logo) | 225 × 155 × 76 | front on the bed, logo as inlay in the first 0.6 mm, fake grooves 0.8 mm deep and open towards the bed; "Für Leo von Papa" with the date 14.09.2026 raised 0.8 mm in grey on the inside of the front plate, readable with the back cover off |
| `back` back cover | 1 | PETG white | 225 × 155 × 55 | outside on the bed, the three battery saddles and the hold-down plate stand upright |
| `grille` fan grille | 1 | PETG grey | Ø 136 × 7 | front on the bed |
| `cover` service cover | 1 | PETG grey | 77.3 × 46 × 11 | outside on the bed; right side below the knob, centred in depth, half-round notch around the knob in its upper edge (3 mm finger room plus a 3 mm chamfer); glued in: a 1.2 mm rim sits 0.8 mm deep in a groove of the side wall with 45° flanks, printable in every direction |
| `foot` foot | 2 | TPU (black) | 16 × 62 × 5.5 (lifts the housing 4.5 mm) | ground face on the bed; screwed with two M3 × 8 from below, heads recessed 1.2 mm |
| `knob` speed knob | 1 | PETG grey | Ø 28 × 17.5 dial on the side wall (7 mm proud of the service cover, hides nut and bushing), 18 grip grooves 1.2 mm deep, white pointer on the top | top on the bed with the pointer as inlay in the first 0.6 mm; underside with the D bore and the slotted clamping sleeve points up |
| `handle` handle | 1 | PETG grey | 170 × 42 × 24 plus 1.2 mm keys under the feet (30 mm clearance under the bar, 90 mm opening at the top) | lying on its side (layers along the pull direction), 45° bevels, keys with 45° flanks |

All parts are in the Bambu Studio project [`stl/leo_ac1_all_parts.3mf`](stl/leo_ac1_all_parts.3mf): plate 1 housing (with prime tower), plate 2 back cover, plate 3 grey parts (grille, service cover, handle, knob), plate 4 TPU feet. Filament 1 PETG Basic white, filament 2 PETG Basic grey, filament 3 grey for the logo and the dedication (same AMS spool as filament 2), filament 4 TPU (Generic TPU profile; set your TPU), filament 5 white for the pointer on the knob (same AMS spool as filament 1; plate 3 gets a small prime tower). To print the housing in one colour, use `stl/body.stl`.

Estimated **approx. 0.70 kg and 21.0 hours** (diagnostic slicing, every instance as its own print; housing alone 402 g / 10.3 h, the two TPU feet 13 g / 1.2 h).

## Bought parts

| Part | Qty | Link | Notes |
|---|---|---|---|
| Fan Noctua NF-F12 industrialPPC-2000 PWM | 1 | [noctua.at](https://noctua.at/en/nf-f12-industrialppc-2000-pwm) | 120 × 25 mm, hole spacing 105 mm, 12 V, max. 0.1 A / 1.2 W, 2000 rpm, 122 m³/h, 3.94 mm H₂O; silicone corner pads 1 mm proud of both frame faces (from the Noctua CAD); the pads rest on the bosses, M3 × 30 engages 3 mm, tighten by hand only |
| Battery 3.2 V 6000 mAh LiFePO4 pack with protection board (BMS), JST-PH 2.0 (32700 cell, Ø 34 × 70 mm) | 1 | [eremit.de](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker) | charge only with a LiFePO4 charger (3.65 V), **no** TP4056 (4.2 V) |
| Charge/boost module "2-in-1 3.2 V LiFePO4", **12 V variant** | 1 | [AliExpress 1005008094801881](https://de.aliexpress.com/item/1005008094801881.html) | 35.4 × 11 × 3.6 mm; pads IN± (5 V charging), B± (battery), O± (12 V, max. approx. 0.32 A); stands upright on the partition in the air stream 5 mm behind the fan, taped onto two pads, lower short edge on a ledge (pads and components at the edges stay free) |
| PWM fan controller CNY-FA5-PRO, DC 8–24 V 5 A, with potentiometer and switch | 1 | [AliExpress 1005010113177510](https://de.aliexpress.com/item/1005010113177510.html) | 4-pin fan; right-angle potentiometer on the board edge. The board lies flat on two 15 mm ribs above the electronics shelf (knob axis 107 mm above the bottom), potentiometer edge against the right wall, held by the potentiometer nut; knob above the battery, centred in depth (assumed: board 48 × 34 mm, components 13 mm high, potentiometer axis 8.5 mm above the board, potentiometer WH148 with D shaft Ø 6 × 15, M7) |
| LED 3 mm, breathing/fading, 3.3 V, water clear, through-hole | 1 | [AliExpress 1005005336879647](https://de.aliexpress.com/item/1005005336879647.html) | USB power indicator: pulses while the charging cable is plugged in (it does not show the charge state); glued from inside into the pocket behind the O of LEO: Ø 3.2 blind hole, 0.8 mm white PETG left in front of the LED, flange rests on a Ø 7 boss; wiring below |
| Resistor 220 Ω, 1/4 W | 1 | – | series resistor for the LED on the 5 V USB input (approx. 8 mA) |
| Aluminium heatsink 8.8 × 8.8 × 5 mm with thermal adhesive tape | 2 | – | on the chips of the charge/boost module, fins along the air flow |
| 2K epoxy or CA gel | – | – | service cover: a thin bead in the groove of the side wall, press the cover in |
| Double-sided, heat-resistant tape, up to 1.1 mm thick | – | – | for the charge module on its two pads: 3M VHB 1.1 mm (modelled, the pads are 1.1 mm shorter for it) or thinner double-sided Kapton (the board then sits further on the ledge); no hot glue |
| Resettable PTC fuse Bourns MF-R160 (1.6 A hold / 3.2 A trip) | 1 | – | optional, between battery plus and B+ (check the datasheet) |
| USB-C PD trigger module, Type A (default 5 V) | 1 | [AliExpress 1005010610660644](https://de.aliexpress.com/item/1005010610660644.html) | charging socket, 13 × 10 × 4 mm: sits in a channel on the inside of the back cover (low on the right, between two battery saddles), receptacle flush in the back cover; with the back cover on, a stop on the right wall behind the module takes the plug force; **leave pads 1–4 open** (1 = 9 V, 2 = 12 V, 3 = 15 V, 4 = 20 V), the charge module only takes 4–6 V; check 5 V with a multimeter before connecting |
| Rocker switch KCD11 10 × 15 mm, 2 pins, ON-OFF (3 A) | 1 | [AliExpress 1005008871215158](https://de.aliexpress.com/item/1005008871215158.html) | power switch in the battery plus line, snapped into the back cover left of the USB-C socket (I up); the back cover is thinned to 1.5 mm around the hole for the snap clips; hole 8.6 × 13.6 mm assumed, measure |
| Heat-set inserts Ruthex RX-M3x5.7 | 22 | [ruthex.de](https://www.ruthex.de) | hole Ø 4.0, depth 7 (datasheet: ≥ L + 1 = 6.7), wall ≥ 1.6 |
| Heat-set insert Ruthex RX-M5x9.5 | 1 | [ruthex.de](https://www.ruthex.de) | mounting thread in the underside (like a tripod thread): pressed in from outside, blind hole Ø 6.4 × 10.5 (L + 1), 2.5 mm floor above; wall 4.3 mm (datasheet ≥ 2.6) |
| M3 × 12, ISO 7380 Torx | 4 | – | grille, from the front, head in a 1.9 mm pocket of the grille ring (0.25 mm below the face) |
| **M3 × 30**, ISO 7380 Torx | 4 | – | fan, from behind through the frame (not in the nas-case screw set, buy separately) |
| M3 × 8, ISO 7380 Torx | 6 | – | back cover, from outside, head in a 1.9 mm pocket (0.25 mm below the face) |
| M3 × 12, ISO 7380 Torx | 4 | – | handle, from inside through the top wall and its doubler |
| M3 × 8, ISO 7380 Torx | 4 | – | TPU feet, from below, heads 1.2 mm below the ground face |

## Wiring

```
USB-C PD trigger 5 V ─┬──► IN+ / IN−   charge/boost module (12 V) ──► O+ / O− 12 V ──► PWM controller "DC 8–24V" ──► 4-pin fan
                      └──► 220 Ω ──► LED (USB power) ──► IN−
battery (JST-PH, built-in BMS) ──► (PTC) ──► power switch ──► B+ / B−
```

- The module charges the battery with up to 1 A to 3.6 V and delivers 12 V at the same time (UPS mode): the fan keeps running while charging. Use a power supply with at least 2 A.
- The BMS in the battery stays as a second protection layer (overcharge, deep discharge, short circuit); the module cuts off earlier at 2.6 V.
- Power switch in the battery plus line: off really disconnects the battery (no standby drain of the modules). The battery only charges with the switch on; to charge without the fan running, turn the knob down until it clicks. Alternative: put the switch between O+ of the charge module and the PWM controller, then charging works with the switch off, but the boost converter keeps drawing its idle current from the battery; decide after measuring that current (below about 1 mA this is the better choice). The switch position in the back cover fits both.
- The module sits 5 mm behind the fan in the intake air, centred in height between the upper and the lower cable notch of the partition, 4.5 mm off the partition on two supports (3.4 mm plus 1.1 mm tape, 7 mm high, 4 mm free at the board ends), so board and heatsinks reach further into the air flow; the ledge under the board stays beside the fan frame so the fan can still be pulled out towards the back. According to a buyer review the chip reaches approx. 70 °C when charging with 1 A without cooling; with R3 = 2.4 kΩ it charges with 0.5 A and stays cooler. With the fan switched off there is no air flow over the module while charging: charge with the fan running or use the 0.5 A setting. The temperature inside the closed housing (board, tape, PETG, battery) has not been measured yet.
- Power: the NF-F12 industrialPPC-2000 draws at most 1.2 W, so the module runs at approx. 31 % of its 3.84 W. Runtime roughly 10 h at full speed, 20 h at 70 % speed (battery 19.2 Wh, approx. 85 % efficiency).
- LED as USB power indicator: anode (long leg) via the 220 Ω resistor to IN+, cathode to IN− of the charge module, i.e. directly on the 5 V from the USB-C PD trigger (or at its + / − pads). It pulses whenever the charger is plugged in and is dark on battery, so it costs no runtime. It does not switch off when the battery is full: the module keeps the battery at 3.6 V and powers the fan from USB. The breathing LED has its own IC; if it flickers or stays dim, try 150 Ω.

## Assembly

1. Press in the heat-set inserts: 4 grille and 4 fan bosses inside the front, 6 bosses on the back edge of the housing, 4 in the handle feet; the M5 insert and 4 M3 inserts for the TPU feet from below into the blind holes in the underside.
2. Screw the handle on from inside with M3 × 12 while the housing is still empty (its keys sit in the recesses of the top wall); later the PWM board leaves only about 46 mm of tool room under the right screws. Glue the LED from inside into the pocket behind the O of LEO (top right behind the front; a drop of clear glue or hot glue on the flange), bend the legs back and solder the resistor and wires.
3. Slide the PWM board in from behind, potentiometer edge first, onto the two ribs above the electronics shelf; push the potentiometer through the right side wall and tighten its nut outside; push the knob onto the shaft (pointer line towards the flat of the shaft): its slotted sleeve clamps on the shaft, if it still turns loose add a drop of glue; glue the service cover in below it: a thin bead of 2K epoxy or CA gel in the groove of the side wall, press the cover in and hold it until the glue has set.
4. Put the grille on from the front (the collar centres it in the opening) and screw it on with M3 × 12.
5. Put the fan from behind onto the bosses behind the air duct, blowing forward, and screw it on with M3 × 30. Route the cable through the upper notch in the partition into the electronics bay. Tape the charge/boost module with its heatsinks (component side towards the fan) upright onto the two pads on the partition, lower edge on the ledge, O± end up towards the cable notch.
6. Slide the battery upright in from behind into the cradle, cable end up and BMS board towards the partition (rectangular cut-out in the cradle); the cable runs through the slot in the electronics shelf above.
7. Put the two TPU feet into the pockets in the underside and screw each on with two M3 × 8 from below; tighten only until the TPU just starts to compress.
8. Solder about 15 cm of wire to + and − of the USB-C module (enough slack to lay the back cover aside later), push the module into the channel on the inside of the back cover with the receptacle in the opening, and connect the wires through the lower cable notch in the partition to IN+ / IN− of the charge module. Snap the power switch into the back cover from outside (I up) and wire it into the battery plus line, also through the lower notch. Put on the back cover (its three saddles close the cradle to rings with 0.5 mm clearance all around, the hold-down plate covers the back edge of the shelf) and screw it on with M3 × 8.

## Print and robustness

All parts are designed to print without supports: `analyze.py islands`, `overhangs` (> 45°, patches from 100 mm²), `ridges` and `inlays` are clean and all four plates slice without supports, but nothing has been printed yet. Small bridges remain on purpose: the ends of the fake grooves, the rings of the screw head pockets (1.5 mm), the USB-C opening in the back cover.

- Housing with the front on the bed: walls, partition, battery cradle and electronics shelf stand upright; the back cover bosses run into the corners with cones flatter than 45°; side slots only bridge 1.6 mm; the fake grooves are open towards the front face on the bed, the LED pocket towards the inside; the dedication grows upwards from the inside of the front plate in grey (colour change only for its four layers at 3.2–4.0 mm).
- Air duct: round tube Ø 118 mm (like the grille opening), 3.2 mm wall, from the front to 0.2 mm in front of the fan frame (checked against the fan envelope: wall closed all around, tube end in front of the frame face; the real frame has chamfers at its inner edge, so per the Noctua CAD the gap there reaches several millimetres at some angles and some air may flow back — not measured); no dead corners between the round grille and the square frame.
- Built for drops (design measures, not drop-tested): walls and front 3.2 mm, back cover 4 mm (screw heads recessed), corner radius 6 mm, 4 mm fillet inside between front and walls, grille ring 4 mm with 2.4 mm bars, extra bar in the back cover slots.
- Back cover mounting: the six insert bosses at the back edge are Ø 10 mm (3 mm of material around the insert hole instead of 2 mm) and 16 mm long, joined to the wall corners and the partition by 20 mm long cones, so they are less likely to snap off in a drop onto the back cover.
- Handle mount: under each foot the top wall is doubled to 6.4 mm, with three 3.2 mm ribs from the front plate to the back lip (7 mm driver room next to the screws). A 1.2 mm key under each foot sits in a matching recess (0.2 mm clearance), so a drop or a jerk on the handle is taken as shear by the housing instead of bending the screws. The inserts start at the key face (pocket 8.5 mm), M3 × 12 engages the full 5.7 mm.
- Heat-set inserts in the front keep at least 3 mm of material to the visible face (grille 3.4 mm, fan 3.2 mm), so the front does not warp when pressing them in.
- Grille gap 4.9 mm (nominal, against fingers; not tested under force).
- USB-C module: the stop behind it is a 4 mm thick, 6 mm high wedge on the right wall that runs into the wall at 45°; the channel on the back cover has 2 mm walls and floor.
- M5 mount: the insert is pressed from outside into a blind hole (10.5 mm = L + 1 per datasheet) with a 2.5 mm floor above; the load on the mount presses it against this floor. The boss is deliberately only Ø 15 mm: its 4.3 mm wall is printed fully solid with 6 wall loops instead of infill. Plus a rib towards the back, a 45° ramp to the front and a 3 mm floor doubler inside from the front to the partition (60 × 56 mm) that leads leverage into the front and the partition. For real camera accessories there is also Ruthex RX-1/4x12.7 (1/4"-20, hole Ø 8.0, wall ≥ 3.3).
- Battery holder for drops: three closed rings (4 mm) around the cell, at the front as ribs in the housing, at the back as saddles across the whole bay on the back cover, 0.5 mm clearance all around with a cut-out for the BMS board. The electronics shelf above is 4 mm thick with 3 mm fillets on both sides into the partition and the side wall; a hold-down plate on the back cover rests 0.2 mm above its free back edge, which should keep the shelf from breaking off in a drop onto the top. Add a thin foam strip between battery and saddles if you like.
- Feet: two TPU strips (16 × 62 mm, 4.5 mm under the housing), each screwed with two M3 × 8 button heads from below into Ruthex inserts. The inserts are pressed from outside into Ø 9 bosses inside the bottom wall (2.5 mm around the hole). The top of each foot sits 1 mm deep in a pocket of the bottom wall with 45° ends, so sideways pushes go into the housing and not into the screws; 2.65 mm of TPU are clamped under each head, the heads stay 1.2 mm above the table. A floor doubler inside keeps the bottom wall at 3.2 mm.
- Slicer profile: 6 wall loops, 5 top/bottom layers, 30 % gyroid; the TPU feet 100 % (zig-zag). PETG is tougher than PLA.

## Open items

- Measure the BMS board on the battery (assumed 16 × 4 mm over the full length, facing the partition).
- Measure the PWM board CNY-FA5-PRO (assumed 48 × 34 mm, components 13 mm, potentiometer axis 8.5 mm above the board) and the potentiometer shaft (shape, length).
- Measure the battery (label Ø 34 × 70 mm; model: cell Ø 33.5 × 72 mm, holder rings Ø 34.5 mm, a real Ø 35 pack would not fit) and its cable exit.
- Measure the USB-C PD trigger (listing 13 × 10 × 4 mm; the receptacle must reach at least 2.4 mm beyond the board to sit flush in the back cover).
- Measure the power switch (KCD11: panel hole assumed 8.6 × 13.6 mm, housing 11 mm deep, snap clips for 1–2 mm panels).
- Fit tests before the full print: a slice of the battery holder, the knob on the real potentiometer shaft, the USB-C channel with a plugged cable, insert holes.
- Wiring: stow the excess of the 400 mm fan cable, keep all wires away from the fan blades and out of the saddles and the back lip, leave slack in the USB-C wires; check the charge module temperature while charging with the fan off.

## Model, exports and checks

Model: [`leo_ac.scad`](leo_ac.scad), settings and project checks: [`print_project.py`](print_project.py). Tools from the skill `openscad-print-project` (copies in `scripts/`). The Noctua CAD for the viewer is not part of the repo (licence): put `NF-F12_iPPC.stl` into `vendor/noctua/`.

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r scripts/requirements.txt
.venv/bin/python scripts/print_tools.py export     # check and replace stl/, asm/, docs/verification.json
.venv/bin/python scripts/analyze.py islands        # floating regions
.venv/bin/python scripts/analyze.py overhangs      # overhangs > 45°, bridges
.venv/bin/python scripts/slice_check.py            # Bambu CLI, project 3MF, docs/slicer-summary.json
.venv/bin/python scripts/build_viewer.py           # build/viewer.html
.venv/bin/python scripts/render_views.py           # img/
```

Checked: part list against the `part` branches, closed meshes, bed placement, build volume, no intersection between 21 assembly bodies (210 pairs, including the power switch, including the TPU feet and their screws, the USB-C module, the assumed PWM board, LED, screws, fan and battery envelopes), contact of grille, fan, back cover, service cover, handle, feet, USB-C module and power switch (back cover), potentiometer, charge module, LED and battery, stops of the battery (back, top, side) and of the USB-C module (stop on the right wall), 12 assembly/removal paths (including the power switch out of the back cover, the feet downwards, the USB-C module with the back cover and then out of its channel, the charge module towards the back before the fan, and the PWM board: first 19.2 mm away from the wall, then towards the back) in a realistic order, 23 insert holes (22 × M3, 1 × M5; axis free, full minimum wall per Ruthex datasheet, floor solid), screw engagement (≥ 3 mm = 1 × d in the brass, fan on silicone pads 3 mm, others ≥ 4.8 mm; tip 0.5–4 mm before the end of the pocket, smallest at the grille 0.5 mm), standard dimensions (120 mm fan, Ruthex M3), grille gap ≤ 6 mm (finger guard), multicolour coverage of logo and dedication. Printability: no floating regions, logo and dedication on their first layer without too narrow spots, ridges between the grooves ≥ 1.1 mm. No strength, airflow, temperature or fit test on the real part; all plates are sliced, nothing is printed yet.
