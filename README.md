# LEO-AC1 — a fan that looks like an air conditioner

Small battery fan for a child's room, styled like the outdoor unit of a split air conditioner (proportions of an 800 × 550 × 285 mm unit). A 140 mm PC fan blows forward through the round grille, which is printed in grey right into the front of the housing; air enters through the slots in the back cover and the left side. A round air duct between the front and the fan frame keeps the air from circulating back into the housing. On the right of the front sits the logo "LEO INDUSTRIES AC-1" in custom block letters above horizontal fake grooves like on Mitsubishi outdoor units; a breathing LED behind the O glows through the white PETG while the charger is plugged in. Behind it is a bay for the battery (3.2 V 6000 mAh LiFePO4) and the electronics. The speed knob sits on the right side above a glued-in service cover; USB-C charging socket and power switch are in the back cover.

Designed for a Bambu Lab H2S with AMS in Bambu PETG HF white and grey plus TPU. **Status:** first parts printed; USB-C socket fit confirmed. Remaining fit and functional checks are pending.

![Assembly](img/01_assembly.png?v=c47d54cb91b6)

| Back | Exploded |
|:---:|:---:|
| ![Back](img/02_back.png?v=d15003424212) | ![Exploded](img/03_exploded.png?v=5e54838e8867) |
| **Logo and grooves** | **Air duct from behind** |
| ![Logo](img/04_front_right.png?v=fedc2e010c7a) | ![Air duct](img/05_duct.png?v=24efae489d31) |
| **Knob and service cover** | **Underside with M5 thread and TPU feet** |
| ![Knob](img/06_knob.png?v=fa5f1665c26d) | ![Underside](img/07_underside.png?v=642f54ba61d8) |
| **Charge module in the air stream** | **LED pocket behind the O** |
| ![Charge module](img/08_charge_module.png?v=e1b5e0f3e6d9) | ![LED pocket](img/09_led.png?v=5c52239f3472) |
| **Folding bail, carrying position** | **Back cover bosses** |
| ![Folding bail](img/11_bail.png?v=f09462a9b7ec) | ![Back cover bosses](img/12_back_bosses.png?v=ca8cbc2f0462) |
| **TPU foot mount** | **USB-C socket** |
| ![TPU foot mount](img/13_foot_mount.png?v=7bbcfdc8da28) | ![USB-C socket](img/14_usb_c.png?v=4d440bb581d9) |
| **Power switch well** | **Battery saddles** |
| ![Power switch](img/15_switch.png?v=6b849d508072) | ![Battery saddles](img/16_saddles.png?v=713adbec40c9) |

## Printed parts

| Part | Qty | Material | Size (mm) | Print orientation |
|---|---|---|---|---|
| `body` housing | 1 | PETG white + grey (logo, dedication, fan grille) | 235 × 172 × 66 | front on the bed; logo as inlay in the first 0.6 mm, fake grooves open towards the bed; a dedication is raised in grey on the inside of the front plate |
| `back` back cover | 1 | PETG white + grey (QR code) | 235 × 172 × 45.8 | outside on the bed; QR code to this project as inlay in the first 0.6 mm; battery saddles and hold-down plate stand upright |
| `cover` service cover | 1 | PETG grey | 74.4 × 46 × 11.8 | outside on the bed; half-round notch around the knob, glued into a groove of the side wall |
| `knob` speed knob | 1 | PETG grey + white (pointer) | Ø 28 × 16.5 | top on the bed, pointer as inlay in the first 0.6 mm |
| `bail` folding bail | 1 | PETG grey | 234 × 44.5 × 53.5 | back faces of the lower legs and the grip on the bed, upper legs upright |
| `foot` foot | 2 | TPU | 16 × 52 × 5.5 | ground face on the bed, 100 % infill |

All parts are in the Bambu Studio project [`stl/leo_ac1_all_parts.3mf`](stl/leo_ac1_all_parts.3mf): plate 1 housing, plate 2 back cover, plate 3 grey parts (service cover, bail, knob), plate 4 TPU feet. Filaments: 1 PETG white, 2 PETG grey, 3 grey for logo, dedication, fan grille and QR code (same spool as 2), 4 TPU, 5 white for the knob pointer (same spool as 1). All parts print without supports. Bambu Studio estimates about **0.63 kg and 18 hours** in total. Single-colour STLs are in `stl/`, the colour pieces in `stl/multicolour/`.

Print profile: 0.20 mm layers, 5 walls, 4 top/bottom layers, 15 % gyroid (feet 100 %).

### Fit tests before the full print

The upper right section of the housing (from the partition to the right wall, from the electronics shelf up) and the matching part of the back cover, cut from the real parts in their print orientation, so the electronics can be fitted before the full print. The Bambu Studio project [`stl/leo_ac1_fit_tests.3mf`](stl/leo_ac1_fit_tests.3mf) holds both sections and a knob on one plate with light settings (2 walls, 3 top/bottom layers, 10 % infill): same geometry, less material, all single-colour in PETG white (no knob pointer inlay, no prime tower), about 90 g and 2.5 hours.

Check with the real parts: the PWM controller lies flat on its pads, the potentiometer housing sits in its wall pocket and washer and nut tighten from outside, the knob covers them; LED and the right bail pivot (M4 insert, flanged bushing and shoulder screw).

## Bought parts

| Part | Qty | Link | Notes |
|---|---|---|---|
| Fan Noctua NF-A14 PWM (or another quiet 140 × 25 mm 4-pin PWM fan) | 1 | [noctua.at](https://noctua.at/en/nf-a14-pwm) | 140 × 25 mm, 12 V, holes 124.5 mm apart; mounted from behind with M3 × 30, tighten by hand only |
| Battery 3.2 V 6000 mAh LiFePO4 pack with protection board (BMS), JST-PH 2.0 | 1 | [eremit.de](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker) | cell Ø 32.5 × 71.6 mm; charge only with a LiFePO4 charger (3.65 V), **no** TP4056 |
| Charge/boost module "2-in-1 3.2 V LiFePO4", **12 V variant** | 1 | [AliExpress](https://de.aliexpress.com/item/1005008094801881.html) | 32.2 × 11 × 3.7 mm; IN± 5 V charging, B± battery, O± 12 V; taped upright onto the partition behind the fan |
| PWM fan controller CNY-FA5-PRO, DC 8–24 V, with potentiometer and switch | 1 | [AliExpress](https://de.aliexpress.com/item/1005010113177510.html) | 41 × 32 × 15 mm; rests on pads under its pin-free long edges, potentiometer housing in a pocket on the inside of the right wall, washer and nut outside under the knob |
| USB-C PD trigger module, Type A (default 5 V) | 1 | [AliExpress](https://de.aliexpress.com/item/1005010610660644.html) | charging socket in the back cover. **Leave pads 1–4 open** (they select 9/12/15/20 V); the charge module only takes 4–6 V, check 5 V with a multimeter before connecting |
| ON-OFF rocker switch, snap-in, 21 × 15 mm (cut-out 19.2 × 12.2 mm) | 1 | [AliExpress](https://de.aliexpress.com/item/1005008871215158.html) | power switch in a shallow well low on the back cover; the rocker stands about 2 mm out |
| LED 3 mm, breathing/fading, 3.3 V, water clear | 1 | [AliExpress](https://de.aliexpress.com/item/1005005336879647.html) | glued from inside behind the O of the logo |
| Resistor 220 Ω, 1/4 W | 1 | – | series resistor for the LED on the 5 V USB input |
| Resettable PTC fuse Bourns MF-R160 or RXEF160 (1.6 A hold) | 1 | – | optional, between battery plus and the switch, in heat shrink |
| Heat-set inserts Ruthex RX-M3x5.7 | 14 | [ruthex.de](https://www.ruthex.de) | – |
| Heat-set inserts Ruthex RX-M4x8.1 | 2 | [ruthex.de](https://www.ruthex.de) | bail pivots, pressed into the inner walls of the top side steps |
| Heat-set insert Ruthex RX-M5x9.5 | 1 | [ruthex.de](https://www.ruthex.de) | mounting thread in the underside, pressed in from outside |
| M3 × 30, ISO 7380 Torx | 4 | – | fan |
| M3 × 8, ISO 7380 Torx | 10 | – | back cover (6), feet (4) |
| Double-sided, heat-resistant tape, ≤ 1.1 mm | – | – | charge module, e.g. 3M VHB; no hot glue |
| 2K epoxy or CA gel | – | – | service cover, LED |
| JST-PH 2.0 cable, 2-pin, mating the battery plug | 1 | – | battery to the switch and B+ / B− |
| Small cable ties, up to 5 mm wide | 2 | – | strain relief for the USB-C and switch wires on the inside of the back cover |
| Silicone wire 24 AWG, red and black | about 1 m | – | USB-C module, switch, LED, 12 V to the PWM controller |
| Heat-shrink tubing 2–3 mm | – | – | every solder joint |
| M4 shoulder screw, head Ø 8.8 × 3 mm, shoulder Ø 5 × 12 mm, thread 8 mm | 2 | – | bail pivots, the shoulder is clamped against the step wall |
| Flanged brass bushing Ø 7 / 5 × 10 mm, flange Ø 10 × 1 mm | 2 | – | pressed into the bail eyes, turns on the screw shoulder |
| Foam tape, self-adhesive, 1–2 mm | – | – | battery: a strip above and below keeps it from rattling |

## Wiring

```
USB-C PD trigger 5 V ─┬──► IN+ / IN−   charge/boost module (12 V) ──► O+ / O− 12 V ──► PWM controller ──► 4-pin fan
                      └──► 220 Ω ──► LED ──► IN−
battery (JST-PH, built-in BMS) ──► (PTC) ──► power switch ──► B+ / B−
```

- According to its listing the module charges the battery with up to 1 A and delivers 12 V at the same time, so the fan keeps running while charging. This is not verified on the built unit yet; use a USB power supply with at least 2 A.
- The BMS in the battery stays as a second protection layer; the listing states a 2.6 V cut-off for the module (not measured yet).
- With the switch in the battery line, off really disconnects the battery, and the battery only charges with the switch on. To charge without the fan running, turn the knob down until it clicks. Alternatively the switch can go between O+ and the PWM controller; then charging always works, but the boost converter draws its idle current from the battery.
- The LED shows that the charging cable is plugged in, not the charge state.
- Runtime is not measured yet. The NF-A14 PWM draws 1.19 W typical and 1.56 W at most (Noctua); with the converter losses a rough estimate is around 10 h at full speed and much longer at low speed.
- The charge module may get warm while charging without fan air flow; check its temperature in the closed housing. The listing mentions a lower charge current via a resistor change; do not modify the board before its schematic is confirmed.

## Assembly

1. Press in the heat-set inserts: 4 fan bosses inside the front, 6 on the back edge of the housing, 2 M4 inserts for the bail pivots into the inner walls of the top side steps; the M5 insert and 4 M3 inserts for the feet from below.
2. Glue the LED into the pocket behind the O and solder resistor and wires.
3. Slide the PWM controller in from behind onto the pads of its ribs and push the potentiometer housing into its pocket in the right wall; put washer and nut on the thread outside and tighten gently. Push the knob onto the shaft, it covers washer and nut. Glue the service cover in below it (thin bead in the groove).
4. Screw the fan on from behind with M3 × 30 (blowing forward) and route its cable through the upper notch of the partition. Tape the charge module upright onto the two pads on the partition, lower edge on the ledge.
5. Slide the battery in from behind, cable end up, protection board towards the partition; a strip of foam tape above and below keeps it from rattling.
6. Screw the TPU feet on with M3 × 8 from below; tighten only until the TPU starts to compress.
7. Solder about 15 cm of wire to the USB-C module and push it into its channel in the back cover; snap the switch into its well. Fix the USB-C wires and the switch wires each with a small cable tie through the loop beside them on the inside of the back cover (strain relief), then route the USB-C wires through the middle notch of the partition and the switch wires through the lower notch, leaving slack to lay the back cover aside. Put on the back cover and screw it on with M3 × 8.
8. Press a flanged bushing into each bail eye from outside, lay the bail arms into the steps along the top side edges and screw each pivot on from the side with an M4 shoulder screw; the shoulder clamps against the step wall, the bail swings on the bushings. To carry, swing it forward until the legs rest on the ramps at the front of the steps; swing it up before taking off the back cover.

## Design notes

- Walls and front 3.2 mm, back cover 4 mm, corner radius 6 mm, recessed screw heads.
- The battery sits in three closed rings: ribs in the housing and saddles on the back cover, stiffened by fillets and a rib.
- L-shaped folding bail (concept from the leoino case): the upper legs lie in steps along both top side edges and turn on M4 pivots at mid-depth, the lower legs run down behind the back cover to the grip just above the power switch. To carry, it rests on ramps at the front of the steps with the grip right above the pivots, so the fan hangs level with about 40 mm room for the hand. The eyes turn on pressed-in flanged brass bushings on the smooth shoulder of the screws, as on the leoino case; the screw heads sit recessed in the bail arms.
- Grille openings are below 6 mm; the grille bars are part of the 3.2 mm front plate.
- The TPU feet are screwed and keyed into pockets of the bottom wall.
- An M5 heat-set insert in the underside takes a tripod or wall mount.

## Build from source

Model: [`leo_ac.scad`](leo_ac.scad) (OpenSCAD, parameters at the top), project settings and checks: [`print_project.py`](print_project.py). The scripts in `scripts/` export and check the meshes, slice with the Bambu Studio CLI and build a 3D assembly viewer. The fan in the model and viewer is a simple parametric placeholder; no manufacturer CAD is used or needed.

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r scripts/requirements.txt
.venv/bin/python scripts/print_tools.py export     # export and check stl/, asm/, docs/verification.json
.venv/bin/python scripts/analyze.py islands        # floating regions
.venv/bin/python scripts/analyze.py thickness      # walls thinner than 1.2 mm
.venv/bin/python scripts/slice_check.py            # Bambu Studio CLI, project 3MF
.venv/bin/python scripts/build_viewer.py           # build/viewer.html
.venv/bin/python scripts/render_views.py           # img/, transparent PNGs (needs Pillow or ffmpeg)
```

## Licence

Model, printable files, images and documentation: [CC BY-NC-SA 4.0](LICENSE). Scripts in `scripts/`: [MIT](LICENSE-MIT).
