# LEO-AC1 — a fan that looks like an air conditioner

Small battery fan for a child's room, styled like the outdoor unit of a split air conditioner (proportions of an 800 × 585 × 240 mm unit). A 140 mm PC fan blows forward through the round grille, which is printed in grey right into the front of the housing; air enters through the slots in the back cover and the left side. A round air duct between the front and the fan frame keeps the air from circulating back into the housing. On the right of the front sits the logo "LEO INDUSTRIES AC-1" in custom block letters above horizontal fake grooves like on Mitsubishi outdoor units; a breathing LED behind the O glows through the white PETG while the charger is plugged in. Behind it is a bay for the battery (3.2 V 6000 mAh LiFePO4) and the electronics. The speed knob sits on the right side above a glued-in service cover; USB-C charging socket and power switch are in the back cover.

Designed for a Bambu Lab H2S with AMS in Bambu PETG HF white and grey plus TPU. **Status:** first parts printed; USB-C socket fit confirmed. Remaining fit and functional checks are pending.

![Assembly](img/01_assembly.png?v=4b221da66817)

| Back | Exploded |
|:---:|:---:|
| ![Back](img/02_back.png?v=8c70744b208b) | ![Exploded](img/03_exploded.png?v=a3b70341f774) |
| **Logo and grooves** | **Air duct from behind** |
| ![Logo](img/04_front_right.png?v=3eae1ab786b8) | ![Air duct](img/05_duct.png?v=64063b1695b3) |
| **Knob and service cover** | **Underside with M5 thread and TPU feet** |
| ![Knob](img/06_knob.png?v=8b8176a9594e) | ![Underside](img/07_underside.png?v=a6c2b16a2c13) |
| **Charge module in its clip holder, heatsink behind the IC** | **LED pocket behind the O** |
| ![Charge module](img/08_charge_module.png?v=198ee43e512d) | ![LED pocket](img/09_led.png?v=5c52239f3472) |
| **Folding bail, carrying position** | **Back cover bosses** |
| ![Folding bail](img/11_bail.png?v=eaf88b2a6829) | ![Back cover bosses](img/12_back_bosses.png?v=c757832413ae) |
| **TPU foot mount** | **USB-C socket** |
| ![TPU foot mount](img/13_foot_mount.png?v=7bbcfdc8da28) | ![USB-C socket](img/14_usb_c.png?v=4d440bb581d9) |
| **Power switch well** | **Battery saddles** |
| ![Power switch](img/15_switch.png?v=ffef34914115) | ![Battery saddles](img/16_saddles.png?v=7d706673f944) |

## Printed parts

| Part | Qty | Material | Size (mm) | Print orientation |
|---|---|---|---|---|
| `body` housing | 1 | PETG white + grey (logo, dedication, fan grille) | 235 × 172 × 66 | front on the bed; logo as inlay in the first 0.6 mm, fake grooves open towards the bed; a dedication is raised in grey on the inside of the front plate |
| `back` back cover | 1 | PETG white + grey (QR code) | 235 × 172 × 45.8 | outside on the bed; QR code to this project as inlay in the first 0.6 mm; battery saddles and hold-down plate stand upright |
| `cover` service cover | 1 | PETG grey | 74.4 × 46 × 8.8 | outside on the bed; half-round notch with a 45° finger scoop around the knob, glued into a groove of the side wall |
| `knob` speed knob | 1 | PETG grey + white (pointer) | Ø 28 × 15.5 | top on the bed, pointer as inlay in the first 0.6 mm |
| `bail` folding bail | 1 | PETG grey | 234 × 44.5 × 53.5 | back faces of the lower legs and the grip on the bed, upper legs upright |
| `foot` foot | 2 | TPU | 16 × 52 × 5.5 | ground face on the bed, 100 % infill |
| `tie_clip` cable tie clip | 6 | PETG grey | 14 × 11 × 5 | pad face on the bed; loose clips, glued into the housing wherever the wiring needs them, tunnel for ties up to 3.6 × 1.6 mm |
| `chg_holder` charge module holder | 1 | PETG grey | 30 × 17.4 × 18.7 | socket rims on the bed; its two sockets enclose the two pads on the partition and are glued over them, it grips only the cool OUT end of the charge module: L-shaped end stop, two snap hooks and a cable tie through its web |

All parts are in the Bambu Studio project [`stl/leo_ac1_all_parts.3mf`](stl/leo_ac1_all_parts.3mf): plate 1 housing, plate 2 back cover, plate 3 grey parts (service cover, bail, knob, charge module holder, six cable tie clips), plate 4 TPU feet. Filaments: 1 PETG white, 2 PETG grey, 3 grey for logo, dedication, fan grille and QR code (same spool as 2), 4 TPU, 5 white for the knob pointer (same spool as 1). All parts print without supports. Bambu Studio estimates about **0.64 kg and 19 hours** in total. Single-colour STLs are in `stl/`, the colour pieces in `stl/multicolour/`.

Print profile: 0.20 mm layers, 5 walls, 4 top/bottom layers, 15 % gyroid (feet 100 %).

### Fit tests before the full print

The upper right section of the housing (from the partition to the right wall, from the electronics shelf up) and the matching part of the back cover, cut from the real parts in their print orientation, so the electronics can be fitted before the full print. The Bambu Studio project [`stl/leo_ac1_fit_tests.3mf`](stl/leo_ac1_fit_tests.3mf) holds both sections and a knob on one plate with light settings (2 walls, 3 top/bottom layers, 10 % infill): same geometry, less material, all single-colour in PETG white (no knob pointer inlay, no prime tower), about 90 g and 2.5 hours.

Check with the real parts: the PWM controller lies flat on its pads, the potentiometer housing sits in its wall pocket and washer and nut tighten from outside, the knob covers them; LED and the right bail pivot (M4 insert, flanged bushing and shoulder screw).

## Bought parts

| Part | Qty | Link | Notes |
|---|---|---|---|
| Fan Noctua NF-A14 PWM | 1 | [noctua.at](https://noctua.at/en/nf-a14-pwm) | 140 × 25 mm (141 × 141 × 27 with its anti-vibration pads), 12 V, 1.19 W typical, holes 124.5 mm apart; mounted from behind with M3 × 32, tighten by hand only |
| Battery 3.2 V 6000 mAh LiFePO4 pack with protection board (BMS), JST-PH 2.0 | 1 | [eremit.de](https://www.eremit.de/p/3-2v-6000mah-pack-mit-schutz-arduino-aio-jst-ph-2-0-stecker) | cell Ø 32.5 × 71.6 mm; charge only with a LiFePO4 charger (3.65 V), **no** TP4056 |
| Charge/boost module "2-in-1 3.2 V LiFePO4", **12 V variant** | 1 | [AliExpress](https://de.aliexpress.com/item/1005008094801881.html) | eletechsup LFUPSMA, board 32.2 × 11 × 1.0 mm (3.7 mm with parts); IN± 5 V charging, B± battery, O± 12 V; clipped IN end up into the printed holder on the partition behind the fan |
| Aluminium heatsink 14 × 14 × 6 mm with an insulating silicone thermal pad, about 1 mm | 1 | – | on the metal pad on the back of the charge module, behind the charger IC; the pad must cover the whole heatsink face, because the heatsink overhangs the board edges and the IN end |
| PWM fan controller CNY-FA5-PRO, DC 8–24 V, with potentiometer and switch | 1 | [AliExpress](https://de.aliexpress.com/item/1005010113177510.html) | 41 × 32 × 15 mm; rests on pads under its pin-free long edges, potentiometer housing in a pocket on the inside of the right wall, washer and nut outside under the knob |
| USB-C PD trigger module, Type A (default 5 V) | 1 | [AliExpress](https://de.aliexpress.com/item/1005010610660644.html) | charging socket in the back cover. **Leave pads 1–4 open** (they select 9/12/15/20 V); the charge module only takes 4–6 V, check 5 V with a multimeter before connecting |
| ON-OFF rocker switch, snap-in, 21 × 15 mm (cut-out 19.2 × 12.2 mm) | 1 | [AliExpress](https://de.aliexpress.com/item/1005008871215158.html) | power switch in a shallow well low on the back cover; the rocker stands about 2 mm out. The printed hole is 0.2 mm wider per side than the datasheet cut-out, because PETG holes come out undersize |
| LED 3 mm, breathing/fading, 3.3 V, water clear | 1 | [AliExpress](https://de.aliexpress.com/item/1005005336879647.html) | glued from inside behind the O of the logo |
| Resistor 220 Ω, 1/4 W | 1 | – | series resistor for the LED on the 5 V USB input |
| Resettable PTC fuse Bourns MF-R160 or RXEF160 (1.6 A hold) | 1 | – | optional, between battery plus and the switch, in heat shrink |
| Heat-set inserts Ruthex RX-M3x5.7 | 14 | [ruthex.de](https://www.ruthex.de) | – |
| Heat-set inserts Ruthex RX-M4x8.1 | 2 | [ruthex.de](https://www.ruthex.de) | bail pivots, pressed into the inner walls of the top side steps |
| Heat-set insert Ruthex RX-M5x9.5 | 1 | [ruthex.de](https://www.ruthex.de) | M5 mounting thread in the underside, pressed in from outside; not a tripod thread |
| M3 × 32, ISO 7380 Torx | 4 | – | fan; 30 mm would leave only 3 mm of thread in the insert |
| M3 × 8, ISO 7380 Torx | 10 | – | back cover (6), feet (4) |
| 2K epoxy or CA gel | – | – | service cover, LED, charge module holder (CA gel) |
| JST-PH 2.0 cable, 2-pin, mating the battery plug | 1 | – | battery to the switch and B+ / B− |
| Small cable ties, 2.5–3.6 mm wide | 9 | – | strain relief for the USB-C and switch wires on the inside of the back cover; one 2.5 mm tie (at most 1.2 mm thick) holds the charge module in its holder; six more for the glue-in clips |
| Silicone wire 24 AWG, red and black | about 1 m | – | USB-C module, switch, LED, 12 V to the PWM controller |
| Heat-shrink tubing 2–3 mm | – | – | every solder joint |
| M4 shoulder screw, head Ø 8.8 × 3 mm, shoulder Ø 5 × 12 mm, thread 8 mm | 2 | – | bail pivots; the shoulder bottoms on the face of the brass insert, so press those two inserts in flush |
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
- The charger on the module is a CN3058E, a linear charger: at 1 A from 5 V it turns about 1.7 W into heat and gets too hot to touch. Its charge current is 1218 V / R_ISET; the fitted resistor next to IN is marked 122 (1.2 kΩ, 1.0 A). A 2.4 kΩ resistor (0805, marked 242) halves the current to 0.5 A and the heat to about 0.85 W; a full charge then takes about 12–13 hours. Before swapping it, check that it is the ISET resistor: about 1.2 kΩ between pins 2 (ISET) and 3 (GND) of the IC with the board unpowered.
- The heatsink on the back and the holder, which only touches the cool OUT end, keep that heat away from the housing. Check the IC temperature in the closed housing while charging.

## Assembly

1. Press in the heat-set inserts: 4 fan bosses inside the front, 6 on the back edge of the housing, 2 M4 inserts for the bail pivots into the inner walls of the top side steps; the M5 insert and 4 M3 inserts for the feet from below.
2. Glue the LED into the pocket behind the O and solder resistor and wires.
3. Slide the PWM controller in from behind onto the pads of its ribs and push the potentiometer housing into its pocket in the right wall; put washer and nut on the thread outside and tighten gently. Put a drop of CA gel in the knob bore and push the knob onto the shaft, it covers washer and nut; push it home until the shaft end bottoms in the bore; the knob then stops 1.2 mm off the wall and turns freely. Glue the service cover in below it (thin bead in the groove).
4. Screw the fan on from behind with M3 × 32 (blowing forward) and route its cable through the upper notch of the partition. Put CA gel into the two sockets of the grey charge module holder and push it over the two pads on the partition until they bottom in the sockets, its foot on the ledge below. Stick the heatsink with its insulating pad onto the metal pad on the back of the charge module, then set the module in IN end up: OUT end from above into the L-shaped end stop, then press the board back until both long edges snap under the hooks. Secure it with a small cable tie (2.5 mm) just above the hooks: through the tunnel in the web behind the board, round both long edges and across the ends of the inductor and the diode, head to the front. To take the fan out later, cut the tie, spread the hooks, lift the module out of the end stop and pull it out, unscrew the fan, pull it 1 mm back off the air duct, slide it 13–14 mm to the left past the holder and take it out towards the back.
5. Slide the battery in from behind, cable end up, protection board towards the partition; a strip of foam tape above and below keeps it from rattling.
6. Screw the TPU feet on with M3 × 8 from below; tighten only until the TPU starts to compress.
7. Solder about 15 cm of wire to the USB-C module and push it into its channel in the back cover; snap the switch into its well. Fix the USB-C wires and the switch wires each with a small cable tie through the loop beside them on the inside of the back cover (strain relief), then route the USB-C wires through the middle notch of the partition and the switch wires through the lower notch, leaving slack to lay the back cover aside. Put on the back cover and screw it on with M3 × 8.
8. Press a flanged bushing into each bail eye from outside, lay the bail arms into the steps along the top side edges and screw each pivot on from the side with an M4 shoulder screw; the shoulder bottoms on the face of the M4 insert, so press that insert in flush, and the bail swings on the bushings with a little axial play. To carry, swing it forward until the legs rest on the ramps at the front of the steps; swing it up before taking off the back cover.

## Design notes

- Walls and front 3.2 mm, back cover 4 mm, corner radius 6 mm, recessed screw heads.
- The battery sits in three closed rings: ribs in the housing and saddles on the back cover, stiffened by fillets and a rib.
- L-shaped folding bail (concept from the leoino case): the upper legs lie in steps along both top side edges and turn on M4 pivots at mid-depth, the lower legs run down behind the back cover to the grip, which lies over the upper band of back intake slots, 76 mm above the power switch. To carry, it rests on ramps at the front of the steps with the grip right above the pivots, so the fan hangs level with 38.3 mm of room for the hand. The eyes turn on pressed-in flanged brass bushings on the smooth shoulder of the screws, as on the leoino case; the screw heads sit recessed in the bail arms.
- Grille openings are 5.0 mm, below the 5.6 mm probe used to judge what a child under three can reach. The bars run 7 mm deep: grey through the 3.2 mm front plate, white on into the air duct.
- The TPU feet are screwed and keyed into pockets of the bottom wall.
- An M5 heat-set insert in the underside takes an M5 wall or bracket mount (a tripod screw is 1/4"-20 and does not fit).

## Build from source

Model: [`leo_ac.scad`](leo_ac.scad) (OpenSCAD, parameters at the top), project settings and checks: [`print_project.py`](print_project.py). The scripts in `scripts/` export and check the meshes, slice with the Bambu Studio CLI and build a 3D assembly viewer. The fan in the model and viewer is a simple parametric placeholder; no manufacturer CAD is used or needed.

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r scripts/requirements.txt
.venv/bin/python scripts/print_tools.py export     # export and check stl/, asm/, docs/verification.json
.venv/bin/python scripts/analyze.py islands        # floating regions
.venv/bin/python scripts/analyze.py thickness      # walls thinner than 1.2 mm
.venv/bin/python scripts/analyze.py fins           # slender towers with a free tip
.venv/bin/python scripts/slice_check.py            # Bambu Studio CLI, project 3MF
.venv/bin/python scripts/build_viewer.py           # build/viewer.html
.venv/bin/python scripts/render_views.py           # img/, transparent PNGs (needs Pillow or ffmpeg)
```

## Licence

Model, printable files, images and documentation: [CC BY-NC-SA 4.0](LICENSE). Scripts in `scripts/`: [MIT](LICENSE-MIT).
