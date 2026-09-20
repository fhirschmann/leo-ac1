// LEO-AC1: battery fan styled like the outdoor unit of an air conditioner, 140 mm PC fan,
// 3.2 V 6000 mAh LiFePO4 pack. Skill openscad-print-project. Units mm, Z up.
// Installed frame: x = width (left to right seen from the front), y = depth (front face at y = 0,
// back face at y = body_d), z = height (underside of the body at z = 0).
// Modules build every part in its INSTALLED position; the part branches at the end put each print
// part into PRINT orientation (largest flat face on the bed at z = 0). The tools set `part`.

part = "assembly";   // print part, "body_base" / "body_label" / "body_dedication" / "body_grille", "back_base" / "back_qr", "assembly", "exploded", "metrics", "none"
$fa = 2;
$fs = 0.6;
eps = 0.01;
tip = 0.2;           // thickness of hull tips (slices a cone runs out to): eps-thin tips leave degenerate triangles in Manifold exports

/* [Body] */
body_w = 235;        // outer width (x); 140 mm fan (branch fan-140): 18 mm wider than with the 120 mm fan, margins round the grille as before (user)
body_h = 172;        // outer height (z); 18 mm taller for the 140 mm fan between feet/mount bosses and the bail steps
body_d = 70;         // outer depth (y) without the service cover
wall = 3.2;          // side, top and bottom walls, eight 0.4 mm lines (drop resistance)
front_t = 3.2;       // front plate
corner_r = 6;        // corner radius seen from the front, spreads the load of a drop on a corner
edge_c = 1.5;        // 45 degree chamfer on the bed edges (front of the body, back of the cover)
part_x = 164;        // left face of the partition between fan section and electronics bay
part_t = 2.4;
inner_c = 4;         // 45 degree fillet between front plate and walls (stiffness, printable)

/* [Fan: 140 x 25 mm PWM, e.g. Noctua NF-A14 PWM (user: the 120 mm industrialPPC was too loud)] */
fan_size = 140;
fan_t = 25;
fan_pitch = 124.5;   // mounting hole spacing (140 mm fans)
fan_hole_d = 4.3;
fan_blade_d = 136;   // swept blade diameter (typical)
fan_cx = 88;         // fan axis x
fan_cz = 85.5;       // fan axis z: just above the feet and mount bosses, just below the bail steps
fan_standoff = 8;    // bosses between front plate and fan frame
fan_boss_d = 9;
fan_pad = 1;         // anti-vibration pads, proud of both frame faces (141 x 141 x 27 mm with pads for the NF-A14 PWM, Noctua)
fan_pad_side = 0.5;  // pads stand out of the frame sides by this much
fan_pad_leg = 41;    // pads cover the corner triangle (fan_size/2, leg) - (fan_size/2, fan_size/2) - (leg, fan_size/2), scaled from the 120 mm fan
shroud_t = 3.2;      // round duct front plate -> fan frame, bore = grille opening: air leaves only through the grille
shroud_gap = 0.6;    // duct end to the fan frame face: more than the 1 mm silicone pads compress under the screws, otherwise the rigid ring seats the fan and shorts out its isolation

/* [Grille: printed into the front plate in grey (user, AMS), flush with the front face] */
open_r = 69;         // opening in the front plate, spanned by the grille bars
grille_r = 74;       // outer radius of the grey ring inlay on the front face round the opening (user: a bit narrower)
grille_groove = [1, 0.6];   // small groove round the ring so the grille looks set in (user): width, depth
grille_bar = 2;      // ring and spoke width
grille_depth = 7;    // bars from the front face into the duct (as deep as the former separate grille): grey through the front plate, white behind it
grille_hub_r = 8;
grille_rings = 8;   // openings 5.0 mm: below the 5.6 mm accessibility probe for children under 36 months (7 rings gave 5.875, which the probe passes)
grille_spokes = 8;

/* [Back cover] */
back_t = 4;          // screw heads recessed 1.9 mm, 2.1 mm below
lip_h = 4;           // lip reaching into the body
lip_t = 3;
lip_cl = 0.25;       // clearance per side between lip and body wall
back_boss_d = 10;    // back cover bosses: 3 mm of material around the Ruthex hole (datasheet 1.6)
boss_inset = 6.5;    // back bosses: axis distance from the outer edges (top corners: from the top only, see boss_top_x)
back_boss_len = 16;  // solid column behind the insert
gusset = 20;         // cone below the back bosses into the wall corner (print orientation), flatter than 45 degrees
slot_w = 1.6;        // intake slots, back and left side
slot_pitch = 3.2;
back_bar_x = fan_cx; // extra vertical bar through the back intake slots
back_slot_rows = 5;  // back intake slots: rows of equal height between z 14 and body_h - 14
back_slot_bar = 3;   // horizontal bar between the rows

/* [Battery, 3.2 V 6000 mAh LiFePO4 pack] */
bat_d = 32.5;        // measured cell body, excluding the separate protection board, 2026-09-15
bat_bms = [20, 4];   // BMS board on one side, facing the partition (-x): width approx. 20 over the full length (y) and thickness (x) measured
bat_bms_cut = [2, 1];         // extra room around the BMS board in the cradle rings and saddles: per side across (y), in depth (x)
bat_l = 71.6;        // measured cell-body length; cable end up, through the shelf slot
cable_slot_w = 10;   // slot in the shelf above the battery, open towards the back
bat_cx = 190;
bat_clear = 0.5;     // radial clearance in the cradle
bat_front_gap = 4.5; // front plate to battery, clears the inner fillet
// three closed rings around the battery for drops: front half as ribs in the body, back half as saddles on the back cover
cradle_z = [14, 28, 56];  // lower faces of the rings, clear of the corner bosses (z <= 10.5) and the cover bosses (z 34-42)
cradle_t = 4;
saddle_gap = 0.3;    // rib end to saddle along y
saddle_gusset = 6;            // 45 degree fillets between the back cover and the battery saddles (not below the lowest: back bosses)
saddle_rib = [3, 190];         // rib across the three saddles behind the battery: thickness, x position
saddle_rib_slot = [12, 12];    // wire passage through the rib at the lower cable notch: height, depth from the back cover (pointed end)
shelf_gap = 3;       // battery top to electronics shelf (cable, protection board)
shelf_t = 4;         // stops the battery when the unit falls on its top
shelf_fillet = 3;    // 45 degree fillets along its joints with partition and right wall, above and below
shelf_hold = [5, 3, 0.2];  // hold-down plate on the back cover over the free shelf edge: overlap (y), thickness, gap
shelf_d = 54;        // shelf depth from the front plate, carries the PWM board

/* [Service cover, right side] */
cover_y = body_d / 2; // centre, in the middle of the side depth
cover_z0 = 30;       // lower edge; the upper edge is at the knob axis, with a half-round notch around the knob
cover_w = 46;        // along y, wide enough for solid corners beside the notch
cover_out = 11;      // protrusion
cover_t = 2.4;
cover_r = 4;
cover_glue = [0.8, 1.2, 0.2];  // glued in: rim depth into the groove, rim width (inner part of the cover wall), clearance per side and at the floor
cover_notch_c = 3;           // 45 degree chamfer along the notch at the outer face (finger room)

/* [Speed knob, potentiometer of the PWM fan controller] */
pot_shaft_d = 5.8;        // measured outside the knurling; round split shaft, not a D shaft
pot_shaft_free = 9.5;     // measured shaft length beyond the threaded bushing
pot_bush = [6.73, 5];      // bushing outside diameter and thread length from the housing shoulder (measured)
pot_nut = [11.6, 2.15];    // nut across corners (10 across flats, measured) and thickness (measured)
pot_washer = [11, 0.85];   // washer outside diameter (approx. measured); nut and washer together 3 mm (measured)
pot_thread_reserve = 0.2;  // thread left beyond the nut
pot_bush_cl = 0.4;         // diameter clearance of the bushing through-bore in the wall
pot_housing = 13;          // potentiometer housing on the PCB edge: square envelope (12 mm pot assumed)
pot_recess_r = 10;         // round pocket from inside around the axis: the housing reaches into the wall, shoulder on the pocket floor
pot_tab = [2.1, 0.8, 1.2, 2.1];   // anti-rotation tab on the housing front below the shaft (measured 2026-09-17): width, height, protrusion, gap to the shaft
pot_tab_cl = 0.2;          // clearance round the tab slot; the gap may be measured from the shaft or the thread, the slot covers both (0.3 left only 1.135 mm of wall to the bushing bore)
pot_pcb_cl = 0.3;          // clearance around the PCB edge in its shallow slot in the wall
pot_mount_t = pot_bush[1] - pot_nut[1] - pot_washer[1] - pot_thread_reserve;   // wall under washer and nut; flat outer face, the knob covers them
// PWM board CNY-FA5-PRO: right-angle potentiometer on its edge, shaft parallel to the board. The board lies on two ribs
// above the shelf and is held by the potentiometer nut. Measured board/module dimensions, 2026-09-15.
pwm_pcb = [41.05, 32, 1.6]; // measured length, width and PCB thickness
pwm_total_h = 18;          // measured 15 without the fan connector, +3 estimated for the plugged connector and wires
pwm_total_len = 56.30;     // measured rear PCB edge to shaft tip, including potentiometer
pwm_comp_h = pwm_total_h - pwm_pcb[2]; // component height above the PCB
pwm_standoff = 14.7;      // board underside above the shelf: raises the knob into the upper part of the side; 0.3 lower after the fit test
pot_axis_h = 6.3;         // PCB top to shaft centre: approx. 6 measured, +0.3 so the axis stayed put when the supports went 0.3 mm lower
pwm_pins = 3;             // solder pins below the PCB, 2-3 mm (measured), everywhere except along both long edges
pwm_edge_free = 1.5;      // pin-free strips on the underside along both long PCB edges (measured)
pwm_pad = 1.2;            // rib pads under those strips, 0.3 mm inside their border
pwm_pin_cl = 0.5;         // clearance below the pins
pwm_rib = 3;              // support ribs on the shelf: thickness (the left one stays beside the battery cable slot)
pwm_rib_hole = [16, 7, 2];   // cable passage through the left rib under the board (user; none in the rib at the wall): length (y), height (z), web below it; pointed at 45 degrees towards the back (printable)
knob_d = 28;              // dial on the side wall, sits in the half-round notch of the service cover
knob_gap = 0.5;           // underside to the wall face
knob_niche = 3;           // radial gap to the notch of the service cover: room for fingertips
knob_skin = 2;            // closed top above the round shaft bore (at least)
knob_proud = 6;           // knob top at least this far beyond the service cover face, for grip
knob_cavity_d = 13;       // recess in the underside over nut and bushing
knob_stem_d = 10;         // clamping sleeve around the round bore, free in a ring gap
knob_stem_cl = 0.5;       // sleeve end above the bushing end
knob_bore_cl = 0;         // nominal 5.8 mm bore; validate push-fit on the real knurled shaft with a test print
knob_slit = [1, 6];       // slit through the sleeve from its end: width, length (= length of the ring gap)
knob_flutes = 18;         // grip grooves
knob_flute = [2, 1.2];    // grip groove width, depth
knob_c = 1.2;

/* [Charge/boost module in the air stream] */
chg_pcb = [32.2, 11, 1.0];     // measured length/width 2026-09-15, thickness 2026-09-18 (board stands with its long axis along z)
chg_pad_pcb = 1.6;             // PCB thickness the printed housing pads and ledge were laid out for (assumed before it was measured)
chg_total_h = 3.7;             // measured total board height including components
chg_comp_h = chg_total_h - chg_pcb[2]; // height of the parts above the PCB
chg_sink = [8.8, 8.8, 5, 6];   // planned clearance envelopes only: no heatsinks bought/measured yet; y, z, height, gap
cable_notch = [7, 12];         // cable notches at the back edge of the partition: length (y), height
cable_notch_z = [44, 126];     // centres: low (switch wires, between two battery saddles) and high (fan cable); a third notch at the USB-C height (usb_notch_z)
tie_loop = [8, 6, 6, 5, 2.5];  // cable tie loops on the inside of the back cover (user): width (x), height (z), stand-off (y), tunnel width, tunnel depth next to the plate
tie_loop_xz = [[186, 68], [180, 44]];   // beside the USB-C channel and beside the switch well, on the way to the partition notches
chg_gap = 4.5;                 // board back to partition: pads plus tape; board and heatsinks further in the intake air, but the ledge under
                               // the board must stay beside the fan frame, otherwise the fan cannot be pulled out towards the back
chg_tape = 1.1;                // double-sided tape between board and pads (3M VHB 1.1 mm); thinner tape moves the board further onto the ledge
chg_fan_gap = 5;               // free space from the fan's back pads to the front edge of the upright board (intake air)
// solder pads (IN, B, O) and parts reach the long edges: no grooves. The board back sits on two pads with heat-resistant
// double-sided tape, its lower edge on a ledge that stays behind the part side. The board itself overlaps the fan in x, so
// the fan cannot be withdrawn towards the back until the module is peeled off the partition (the ledge is not what blocks it).
chg_pads = [[4, 7], [chg_pcb[0] - 4 - 7, 7]]; // supports from the board's lower end: start, height; keep 4 mm free at both ends
chg_ledge = [2, 0.3];          // ledge under the lower board edge: height, set back from the part side
// the charger IC (CN3058E, linear, 1 A with the fitted 1.2 kOhm ISET resistor) runs too hot to touch, and one housing pad sat
// right behind it (user, 2026-09-18; housing already printed): a grey holder is glued onto both pads with CA gel and stands on
// the ledge. The board (eletechsup LFUPSMA) stands in it IN end up and is only gripped at its cool OUT end (user): a lip under
// the end, two snap hooks over the long edges of the part side, back stops under the edges. The IN half with the IC stands free,
// with the user's heatsink on the metal pad behind the IC. Board from the user's photos, from the OUT end: back - OUT pads with
// wires in both corners (0-2.8), 5/9/12 V solder jumpers (6.3-8.1, 3.4-8.7 across, 12 V bridged), BAT pads at one long edge
// (16.7-21.2), metal pad (21.9-29.5); part side - inductor 1.0 and SS34 diode 0.7 from the long edges between 5 and 12.5,
// castellations and the B wires from 13 on
chg_glue = 0.1;                // CA gel between holder and housing pads (user: superglue instead of VHB)
chg_holder = [2, 2, 4];        // plate thickness, lip under the lower board edge (z), lip and web width (y, between the OUT pads)
chg_clip = [3, 11, 2, 0.4, 0.2, [0.6, 2.6]];   // snap hooks at both long edges: from / to (from the OUT end), jaw thickness, overlap on the part side,
                               // edge clearance, back stop under the edge from / to (0.8 mm slot to the jaw so the slicer cannot close it; jumpers from 3.4)
chg_rear_sink = [14, 14, 6, 1, 1];     // user's heatsink: length (along the board), width, height, insulating silicone pad over its whole face, gap to the holder plate
chg_sink_end = 10;             // lower heatsink end from the IN end: 1 mm before the BAT pads; it overhangs the IN end by 4 mm
chg_web_gap = 1.5;             // the web from lip to plate stays this far behind the board (OUT pads, jumper solder)
fan_side_shift = 11;           // the glued holder stays in the fan's way out: unscrewed fan 1 mm back off the duct ring, this far left, then out the back

/* [Folding bail on top, like the leoino case: steps along both top side edges over the full depth, pivots at mid-depth] */
bail_arm = [15, 12];        // legs: width (x; leoino 11, 3 mm wider outwards for the sunk screw heads, 1 mm for the 12 mm shoulder, user), thickness = eye diameter; the upper legs lie in the side steps
bail_bar = 13;              // grip bar height when folded (as thick as the legs)
bail_drop = 134;            // folded: centre height of the grip bar behind the back cover, above the power switch (user: L bail, grip not too low)
bail_cl = 0.5;              // clearance of the bail in the steps and behind the back cover
bail_y = body_d / 2;        // pivot axis at mid-depth: the fan hangs level (user)
bail_screw = [8.8, 3, 5, 12, 8];   // M4 shoulder screw (user): head diameter, head height, shoulder diameter, shoulder length (12, 1 mm longer than on the leoino, user), thread length
bail_bush = [7, 10, 1, 10];        // flanged brass bushing pressed into the eye (user): outside diameter, flange diameter, flange thickness, total length (bore 5)
bail_band = 16;                    // side step width from the side face to the insert wall (leoino 12 + 3 for the sunk heads + 1 for the 12 mm shoulder, user); the arm has 0.5 mm on both sides
bail_head_room = 6;                // cut-back of the outer arm ends this far behind the pivot axis (flange radius 5)
bail_eye_w = 9.8;                  // eye width, flush with the inner arm face (leoino 8.8 + 1 for the 12 mm shoulder): the outer 5.2 mm are cut back round the eye for flange and head, the head sits 0.5 mm below the arm face
bail_c = 1;                 // 45 degree chamfers on the bar and arm edges
m4_insert = [5.6, 8.1, 2.2];   // Ruthex RX-M4x8.1: hole (as in the leoino case), length, minimum wall (check against the datasheet)

/* [USB-C charging socket: PD trigger module (Type A, pads 1-4 open = 5 V) in the back cover] */
usbc_board = [12.88, 10.35, 4.30]; // measured 2026-09-15: length without the projecting receptacle (y), width (x), height incl. components (z)
usbc_protrusion = 1.5;       // measured receptacle projection beyond the front PCB edge
usbc = [usbc_board[0] + usbc_protrusion, usbc_board[1], usbc_board[2]]; // total module envelope: 14.38 x 10.35 x 4.30
usbc_shell = [8.9, 3.22];    // measured receptacle shell width and height, 2026-09-15
usbc_shell_bottom = 1.1;     // approximately measured from module underside to shell underside; 1.1 + 3.22 ~= 4.30 overall
usbc_plate = usbc_protrusion; // local cover thickness: PCB edge rests inside, receptacle face flush outside
usbc_xz = [205.5, 68];       // module envelope centre: near the right edge, 2.5 mm towards the middle (user; the wall stop keeps 2.9 mm on the board end beside the battery path), above the power switch, between the top battery saddle and the shelf
usbc_cl = 0.2;               // clearance in channel, plate opening and to the stop
usbc_wall = 2;               // channel on the inside of the back cover: side walls and floor, open at the top for the wires
usbc_stop = [4, 6];          // stop on the right wall behind the module end (takes the plug force with the back cover on): thickness, height
                             // (reaches below the module, the wires leave its end at the top)

/* [Power switch: measured 14.7 x 20.9 mm rocker, snap-in, in a well of the back cover] */
sw_xz = [205.5, 44];         // low near the right edge (user), between two battery saddles, in one column below the USB-C socket (user)
sw_cut = [19.2, 12.2];       // measured required panel hole; long side horizontal
sw_cut_cl = 0.2;             // print clearance per side on that hole: PETG holes come out undersize and the panel's first layer is an unsupported ledge
sw_bezel = [20.9, 14.7, 2];  // measured outside width/height and bezel thickness
sw_rocker = 5;               // measured rocker rise above the bezel
sw_body = [sw_cut[0] - 0.2, sw_cut[1] - 0.2, 11]; // conservative body below the hole; depth still assumed
sw_total_depth = 23;         // measured overall depth including contacts
sw_pins = sw_total_depth - sw_bezel[2] - sw_rocker - sw_body[2]; // inferred from the provisional front/body depth split
sw_panel = 1.5;              // user-confirmed approximate panel thickness for the snap clips
sw_well = [5, 0.2, 2.2];     // well: panel below the back face (user: 3 mm shallower than 8, the frame stays inside, the rocker stands about 2 mm out), floor margin around the frame (small: short overhang, no support),
                             // wall measured horizontally (2.2 = 1.56 mm across the 45 degree flank)

/* [Feet: TPU strips, each screwed with two M3 x 8 from below into Ruthex inserts] */
foot_w = 16;          // width (x)
foot_len = 52;        // length (y), ends before the back lip
foot_y0 = 8;          // front end of the feet
foot_lift = 4.5;      // housing above the ground
foot_key = 1;         // the foot top sits this deep in a pocket of the bottom wall and takes the shear
foot_c = 1;           // 45 degree chamfers: ground edges all around, top ends (match the pocket ends)
foot_cl = 0.2;        // clearance of the TPU in the pocket, per side
foot_inset = 17;      // foot axis from the side faces
foot_screw_dy = 17;   // screw axes from the foot centre along y (9 mm from the foot ends, as before the feet got shorter)
foot_head_recess = 1.2;   // screw heads below the ground face
foot_boss_d = 9;      // bosses inside the bottom wall for the inserts, pressed in from outside

/* [Mount insert in the underside, like a camera thread] */
mount_xy = [135, 36];      // near the centre of mass (fan left, battery right)
// Ruthex RX-M5x9.5 (datasheet RX series 08/2022): outer 7.1 / 6.3, length 9.5, hole 6.4, min. wall 2.6, blind hole >= L + 1
mount_insert = [6.4, 9.5, 2.6];   // hole diameter, insert length, minimum wall around the hole
mount_floor = 2.5;         // above the blind hole: the weight on a mount pushes the insert against it
mount_boss_d = 15;         // 4.3 mm wall: solid with 6 wall loops (2.4 mm from each side) instead of infill
mount_rib = [2.4, 16];     // rib from the boss towards the back (a vertical wall in print): thickness, length
mount_doubler = [62, 56, 3];  // floor doubler around the boss: width (x, ends at the partition), depth from the front, thickness

/* [Screws, M3 heat-set inserts] */
insert_hole_d = 4.0; // Ruthex M3 x 5.7
insert_len = 5.7;
insert_depth = 7;    // pocket depth; Ruthex datasheet: at least L + 1 mm = 6.7
insert_w_min = 1.6;  // Ruthex datasheet: minimum wall around the 4.0 hole
screw_clear_d = 3.4;
// ISO 7380 button head Torx screws (same set as the nas-case project: M3 x 6, 8, 10, 12, 16, 25), no countersunk heads
screw_head_d = 5.7;
screw_head_h = 1.65;
head_pocket = [6.4, 1.9];  // screw head recess: diameter, depth
len_fan = 32;        // M3 x 32, from behind the fan (not in the nas-case set; 30 left exactly 3.00 mm of thread, the 1 x d floor, because the engagement is len_fan - fan_t - 2 * fan_pad)
len_back = 8;        // M3 x 8, from the back, head on the surface
len_foot = 8;        // M3 x 8, from below through the TPU feet

/* [Decor] */
inlay_t = 0.6;       // multicolour inlay depth: the first three 0.2 mm layers

/* [QR code on the back cover (user): grey inlay on the back face, links to the project] */
qr_module = 1;       // module size; inlays need >= 0.8 mm lines
qr_quiet = 4;        // modules of plain white around the code for scanners
qr_xz = [sw_xz[0], 97];   // centre in model x, z: in one column with switch and USB-C socket (user), below the folded grip
// BEGIN qr (generated by qr_code.py: https://github.com/fhirschmann/leo-ac1, version 3, error level M)
qr_url = "https://github.com/fhirschmann/leo-ac1";
qr_n = 29;
qr_runs = [[0, 0, 7], [0, 8, 10], [0, 12, 13], [0, 16, 17], [0, 19, 21], [0, 22, 29], [1, 0, 1], [1, 6, 7], [1, 8, 11], [1, 12, 15], [1, 16, 17], [1, 22, 23], [1, 28, 29], [2, 0, 1], [2, 2, 5], [2, 6, 7], [2, 9, 10], [2, 13, 15], [2, 16, 17], [2, 19, 20], [2, 22, 23], [2, 24, 27], [2, 28, 29], [3, 0, 1], [3, 2, 5], [3, 6, 7], [3, 8, 9], [3, 11, 12], [3, 13, 14], [3, 15, 16], [3, 17, 18], [3, 19, 20], [3, 22, 23], [3, 24, 27], [3, 28, 29], [4, 0, 1], [4, 2, 5], [4, 6, 7], [4, 9, 13], [4, 15, 20], [4, 22, 23], [4, 24, 27], [4, 28, 29], [5, 0, 1], [5, 6, 7], [5, 10, 11], [5, 13, 14], [5, 17, 18], [5, 19, 20], [5, 22, 23], [5, 28, 29], [6, 0, 7], [6, 8, 9], [6, 10, 11], [6, 12, 13], [6, 14, 15], [6, 16, 17], [6, 18, 19], [6, 20, 21], [6, 22, 29], [7, 8, 9], [7, 10, 13], [7, 16, 19], [7, 20, 21], [8, 0, 1], [8, 2, 4], [8, 5, 8], [8, 9, 10], [8, 13, 14], [8, 15, 19], [8, 22, 23], [8, 25, 26], [8, 27, 29], [9, 1, 3], [9, 5, 6], [9, 7, 9], [9, 11, 13], [9, 18, 21], [9, 22, 25], [9, 28, 29], [10, 0, 1], [10, 4, 5], [10, 6, 7], [10, 8, 9], [10, 10, 12], [10, 14, 15], [10, 16, 17], [10, 20, 22], [10, 23, 24], [10, 26, 28], [11, 3, 4], [11, 5, 6], [11, 7, 9], [11, 13, 14], [11, 15, 16], [11, 18, 19], [11, 20, 23], [11, 24, 25], [11, 28, 29], [12, 1, 4], [12, 5, 7], [12, 8, 9], [12, 10, 13], [12, 17, 18], [12, 25, 27], [13, 3, 4], [13, 5, 6], [13, 7, 8], [13, 9, 17], [13, 19, 20], [13, 22, 23], [13, 26, 29], [14, 2, 4], [14, 6, 7], [14, 11, 12], [14, 14, 15], [14, 19, 21], [14, 22, 23], [14, 26, 29], [15, 0, 2], [15, 4, 6], [15, 7, 10], [15, 12, 14], [15, 15, 17], [15, 18, 25], [15, 27, 28], [16, 0, 7], [16, 9, 10], [16, 11, 12], [16, 18, 21], [16, 24, 26], [16, 27, 28], [17, 1, 3], [17, 5, 6], [17, 7, 8], [17, 10, 11], [17, 13, 14], [17, 15, 16], [17, 17, 18], [17, 23, 24], [17, 25, 28], [18, 0, 1], [18, 3, 5], [18, 6, 7], [18, 8, 10], [18, 15, 16], [18, 20, 21], [18, 22, 25], [18, 26, 27], [19, 2, 3], [19, 8, 9], [19, 10, 11], [19, 16, 19], [19, 22, 25], [19, 26, 27], [20, 1, 2], [20, 3, 14], [20, 15, 19], [20, 20, 27], [21, 8, 9], [21, 12, 15], [21, 16, 17], [21, 18, 19], [21, 20, 21], [21, 24, 29], [22, 0, 7], [22, 8, 10], [22, 12, 14], [22, 16, 18], [22, 19, 21], [22, 22, 23], [22, 24, 26], [22, 27, 28], [23, 0, 1], [23, 6, 7], [23, 8, 10], [23, 11, 13], [23, 15, 16], [23, 18, 19], [23, 20, 21], [23, 24, 26], [24, 0, 1], [24, 2, 5], [24, 6, 7], [24, 9, 11], [24, 12, 13], [24, 14, 15], [24, 17, 18], [24, 20, 25], [24, 26, 27], [25, 0, 1], [25, 2, 5], [25, 6, 7], [25, 8, 9], [25, 10, 16], [25, 19, 20], [25, 21, 22], [25, 23, 26], [25, 28, 29], [26, 0, 1], [26, 2, 5], [26, 6, 7], [26, 8, 9], [26, 10, 12], [26, 14, 15], [26, 16, 19], [26, 20, 21], [26, 23, 24], [26, 26, 27], [26, 28, 29], [27, 0, 1], [27, 6, 7], [27, 9, 11], [27, 12, 15], [27, 16, 17], [27, 18, 19], [27, 20, 22], [27, 23, 24], [27, 25, 26], [27, 27, 28], [28, 0, 7], [28, 8, 10], [28, 14, 16], [28, 18, 23], [28, 27, 28]];   // [row from the top, first column, end column] of dark modules
// END qr
brand = "LEO";             // big stencil letters, as wide as the second line
brand_sub = "INDUSTRIES";  // second line, sets the block width
brand_model = "AC-1";      // third line
logo_cx = 199.5;           // centre of the left-aligned block, front view x (right of the grille)
logo_top = 161;            // top of the big letters, front view z
line_gap = 3;
big_size = [13, 18];       // letter box
big_stroke = 3;
sub_size = [4, 6];
sub_stroke = 1.2;          // >= 3 lines, also the gaps inside A, E and S
sub_gap = 1.5;
stencil_gap = 1.2;         // bridges in the big letters
groove_count = 17;         // decorative grooves right of the grille, as on Mitsubishi outdoor units
groove_pitch = 6;
groove_w = 1.2;
groove_depth = 0.8;        // open to the bed in print
groove_z0 = 19;            // axis of the lowest groove
groove_x = [170, 229];
led_cl = 0.2;              // pocket diameter clearance; bounded from above by the LED flange, which seats on the ring between bore and boss face and sets the insertion depth:
                           // 0.5 left a 0.15 mm ring that PETG cannot print (contact check led@body fell to 0.085 mm3). A tight LED gets the bore reamed instead.
led_d = 3;                 // 3 mm breathing LED as charge indicator, glued in from inside; shines through the white PETG in the counter of the O
led_skin = 0.8;            // white PETG left in front of the LED (four layers)
led_boss = [7, 5.8];       // boss around the LED pocket: diameter, height from the front face; the LED flange rests on it
dedication = ["Für Leo", "von Papa", "14.09.2026"];   // raised on the inside of the front plate, readable from behind with the back cover off
dedication_font = "Liberation Sans:style=Bold";   // bundled with OpenSCAD
dedication_size = [6, 6, 4];     // per line, the date smaller; fits between the PWM module (with plugged connector) and the bail recess
dedication_w = [30, 38, 28];     // measured line widths (incl. bold) for the LED boss and bay checks
dedication_x = 192;              // centre of the lines, left of the LED boss
dedication_bold = 0.15;    // extra stroke per side: thin joints of the font reach two lines (0.8 mm) in grey
dedication_h = 0.8;        // raised height (four layers)
dedication_z = [131.7, 124.2, 116.8];   // baselines above the PWM module; glyphs measured per line, line gaps checked on the grey inlay

// ---------- derived values ----------
pot_nose_len = pwm_total_len - pwm_pcb[0] - pot_shaft_free - pot_bush[1]; // housing shoulder ahead of the PCB edge
pwm_wall_gap = pot_mount_t + pot_nose_len - wall; // PCB edge to the inner wall face; negative: the edge reaches into the wall slot
pot_recess = wall - pot_mount_t;                  // depth of the round housing pocket from inside
function pot_bush_bore() = pot_bush[0] + pot_bush_cl;   // the hole the wall actually gets, not the nominal bushing
function pot_tab_z() = [pot_shaft_d / 2 + pot_tab[3] - pot_tab_cl, pot_bush[0] / 2 + pot_tab[3] + pot_tab[1] + pot_tab_cl];   // tab slot below the axis: from its nearest to its farthest possible edge
pwm_pcb_slot = max(0, -pwm_wall_gap) + pot_pcb_cl;  // depth of the shallow slot for the PCB edge
pot_shaft_tip = pot_shaft_free + pot_bush[1] - pot_mount_t; // shaft tip relative to the outer wall
function pwm_rib_x() = let (x1 = body_w - wall - pwm_wall_gap) [x1 - pwm_pcb[0] + 0.3, body_w - wall - pwm_rib];   // under both board ends; the right rib stands against the wall (user)
// material between a pocket from inside (radius r around the knob axis, floor t below the outer face) and the cover glue groove
function cover_groove_gap(r, t) = let (gd = cover_glue[0] + cover_glue[2], r0 = cover_notch_r + cover_t - cover_glue[1] - cover_glue[2])
    r < r0 ? norm([r0 - r, t - gd]) : t - gd;
pot_yz = [cover_y, wall + bat_l + shelf_gap + shelf_t + pwm_standoff + pwm_pcb[2] + pot_axis_h];   // knob axis above the battery, centred in the depth
mount_top = mount_insert[1] + 1 + mount_floor;        // boss top inside; blind hole L + 1 from the underside
knob_sleeve_z = pot_bush[1] - pot_mount_t + knob_stem_cl - knob_gap; // sleeve end above bushing, relative to knob underside
knob_bore_top = pot_shaft_tip + 1 - knob_gap;                 // 1 mm beyond the shaft end
knob_len = max(knob_bore_top + knob_skin, cover_out + knob_proud - knob_gap);   // top face
cover_notch_r = knob_d / 2 + knob_niche;                       // half-round notch of the service cover around the knob
cover_hgt = pot_yz[1] - cover_z0;                              // upper edge at the knob axis
cover_z = cover_z0 + cover_hgt / 2;
logo_w = text_w(brand_sub, sub_size, sub_stroke, sub_gap);
big_gap = (logo_w - text_w(brand, big_size, big_stroke, 0)) / (len(brand) - 1);
logo_x0 = logo_cx - logo_w / 2;
logo_bottom = logo_top - big_size[1] - 2 * (line_gap + sub_size[1]);
led_xz = [logo_x0 + text_x(brand, big_size, big_stroke, big_gap, 2) + big_size[0] / 2, logo_top - big_size[1] / 2];   // centre of the O
fan_y = front_t + fan_standoff;                       // front face of the fan frame
chg_y0 = fan_y + fan_t + fan_pad + chg_fan_gap;       // front edge of the upright charge module
chg_z = (cable_notch_z[0] + cable_notch_z[1]) / 2;    // charge module centred between the two cable notches
chg_hx1 = part_x - (chg_gap - chg_tape) - chg_glue;   // back face of the holder, glued onto the housing pads
chg_hz0 = chg_z - chg_pcb[0] / 2;                      // holder foot on the housing ledge
chg_air = chg_rear_sink[2] + chg_rear_sink[3] + chg_rear_sink[4];   // board back to holder plate
chg_bx0 = chg_hx1 - chg_holder[0] - chg_air - chg_pcb[2];   // part side of the board on the holder
chg_bz0 = chg_hz0 + chg_holder[1];                     // lower (B/O) board edge on the holder lip
chg_sink_z0 = chg_bz0 + chg_pcb[0] - chg_sink_end;     // lower heatsink end, behind the IC near the upper (IN) end
usb_notch_z = usbc_xz[1];                             // USB-C wires to the charge module: the top saddle and the shelf close the bay between the other notches
bat_cy = front_t + bat_front_gap + bat_d / 2;         // battery axis y
shelf_z = wall + bat_l + shelf_gap;
bay_x0 = part_x + part_t;
bay_x1 = body_w - wall;
lip_y0 = body_d - back_t - lip_h;
part_y1 = lip_y0 - lip_cl;
ring_in = open_r;                                     // the bars span the whole opening
grille_gap = (ring_in - grille_hub_r - grille_rings * grille_bar) / (grille_rings + 1);
function fan_holes() = [for (sx = [-1, 1], sz = [-1, 1]) [fan_cx + sx * fan_pitch / 2, fan_cz + sz * fan_pitch / 2]];
// back bosses: [axis (x, z), footprint rectangle corner a, corner b, gusset tip corner a, corner b]
function back_bosses() = concat(
    [for (sx = [0, 1]) let (   // bottom corners: into the wall corner
        c = [sx ? body_w - boss_inset : boss_inset, boss_inset],
        w = [sx ? body_w - wall + 1 : wall - 1, wall - 1],
        t = [sx ? body_w - wall + 0.5 : wall - 0.5, wall - 0.5])   // cone tips end inside the walls, not on their faces (clean meshes)
     [c, w, c, w, t]],
    [for (sx = [0, 1]) let (   // top: beside the bail steps, into the top wall
        c = [sx ? body_w - boss_top_x : boss_top_x, body_h - boss_inset],
        w = [c[0] - back_boss_d / 2, body_h - wall + 1],
        t = [c[0] + back_boss_d / 2, body_h - wall + 0.5])
     [c, w, [c[0] + back_boss_d / 2, c[1]], w, t]],   // footprint over the full boss width, as in the middle: half of it left the lip clearance a bare arc, which leaves a free crescent beside the bail step
    [for (sz = [0, 1]) let (   // middle of the width, top and bottom (user: evenly spread), into the top or bottom wall
        c = [body_w / 2, sz ? body_h - boss_inset : boss_inset],
        w = [c[0] - back_boss_d / 2, sz ? body_h - wall + 1 : wall - 1],
        t = [c[0] + back_boss_d / 2, sz ? body_h - wall + 0.5 : wall - 0.5])
     [c, w, [c[0] + back_boss_d / 2, c[1]], w, t]]);
bail_z = body_h - bail_arm[1] / 2;                     // pivot axis height
bail_floor = body_h - bail_arm[1];                     // floor of the side steps
bail_x = [(bail_band - bail_arm[0]) / 2, (bail_band + bail_arm[0]) / 2];   // left arm: outer and inner face (right arm mirrored)
bail_eye_x = [bail_x[1] - bail_eye_w, bail_x[1]];   // eye faces; the shoulder screw head sits in the cut-back outer part of the arm
bail_leg_y = [body_d + bail_cl, body_d + bail_cl + bail_arm[1]];     // folded: lower legs and bar behind the back cover
bail_bar_z = [bail_drop - bail_bar / 2, bail_drop + bail_bar / 2];
bail_reach = [bail_leg_y[0] + bail_arm[1] / 2 - bail_y, bail_z - bail_drop];   // pivot to bar centre along the upper and the lower leg
bail_carry = 180 - atan(bail_reach[0] / bail_reach[1]);   // carrying angle: bar above the pivot, the fan hangs level; the step ramp stops it
// lowest corner of the chamfered grip bar below its centre at the carrying angle (the bar is rotated, so half its
// folded height is not the support distance: that read 1.61 mm too much)
function bail_bar_drop() = let (a = bail_bar / 2, b = bail_arm[1] / 2, c = bail_c, s = abs(sin(bail_carry)), k = abs(cos(bail_carry)))
    max((b - c) * s + a * k, b * s + (a - c) * k);
function bail_room() = bail_reach[0] * sin(bail_carry) - bail_reach[1] * cos(bail_carry) - bail_bar_drop() - (body_h - bail_z);   // hand room above the top
// ramp at the front end of a side step, taken 1 mm above the top face: the raised upper leg rests against it at bail_carry
function bail_ramp_y() = let (r = bail_arm[1] / 2 - 0.1,   // the upper leg face rests on the chamfered ramp at bail_carry (with bail_cl it swung 3 degrees further)
     n = [-sin(bail_carry), cos(bail_carry)], p = [bail_y + r * n[0], bail_z + r * n[1]])
    p[0] + (body_h + 1 - p[1]) / sin(bail_carry) * cos(bail_carry);
boss_top_x = bail_band + wall + back_boss_d / 2 + 1;   // top back-cover bosses moved inwards beside the steps
usbc_y0 = body_d - usbc[0];                             // inner end of the module, in the bay
function usbc_channel_x() = [usbc_xz[0] - usbc[1] / 2 - usbc_cl - usbc_wall, usbc_xz[0] + usbc[1] / 2 + usbc_cl + usbc_wall];
function usbc_channel_z() = [usbc_xz[1] - usbc[2] / 2 - usbc_cl - usbc_wall, usbc_xz[1] + usbc[2] / 2 + usbc_cl];
function usbc_stop_x0() = max(usbc_xz[0] - usbc[1] / 2, bat_cx + bat_d / 2 + bat_clear + 1);   // stop from the right wall, ending beside the battery removal path
function sw_well_half() = [sw_bezel[0] / 2, sw_bezel[1] / 2] + [1, 1] * (sw_well[1] + sw_well[2] + sw_well[0] - back_t);   // well box half size on the inner back face (x, z)
function foot_x() = [foot_inset, body_w - foot_inset];
function foot_screws() = [for (fx = foot_x(), dy = [-1, 1]) [fx, foot_y0 + foot_len / 2 + dy * foot_screw_dy]];
foot_doubler_hw = foot_w / 2 + foot_cl + 1.2;        // half width of the floor doubler over a foot pocket
foot_boss_top = foot_key + insert_depth + 1.5;       // closed boss top above the insert pocket
foot_screw_skin = foot_key + foot_lift - foot_head_recess - screw_head_h;   // TPU under the head: head face to insert mouth
// thread engagement in the insert and margin of the screw tip to the pocket end
screw_table = [
    // name, length, engagement, tip margin
    ["fan", len_fan, (fan_y - fan_pad) - max(fan_y + fan_t + fan_pad - len_fan, fan_y - fan_pad - insert_len),
     (fan_y + fan_t + fan_pad - len_fan) - (fan_y - fan_pad - insert_depth)],
    ["back", len_back, (body_d - back_t) - max(body_d - head_pocket[1] - len_back, body_d - back_t - insert_len),
     (body_d - head_pocket[1] - len_back) - (body_d - back_t - insert_depth)],
    ["bail", bail_screw[1] + bail_screw[3] + bail_screw[4], min(bail_screw[4], m4_insert[1]), m4_insert[1] + 1 - bail_screw[4]],
    ["feet", len_foot, min(len_foot - foot_screw_skin, insert_len), insert_depth - (len_foot - foot_screw_skin)]];

assert(wall >= 3.2 && front_t >= 3.2 && back_t >= 3 && corner_r >= 5, "Drop resistance: walls >= 3.2 mm (back 3 mm), corner radius >= 5 mm");
// heat-set inserts need material between pocket and visible face, otherwise the face deforms when pressing
assert(fan_y - fan_pad - insert_depth >= 3, "Fan insert pocket too close to the front face");
assert(grille_gap <= 5.5, "Grille openings wider than 5.5 mm: a 5.6 mm probe reaches the impeller (finger safety)");
assert(grille_r - open_r >= 4 && grille_bar >= 1.6 && front_t >= 3 && grille_depth <= fan_y - fan_pad - 2 && grille_groove[1] < inlay_t + 0.01 && logo_x0 > fan_cx + grille_r + grille_groove[0] + 3, "Grille: ring inlay narrower than 4 mm, bars thinner than 4 lines, or front plate too thin for stiff bars");
assert(fan_blade_d / 2 < open_r, "Front opening smaller than the fan blades");
assert(open_r < fan_size / 2 - 0.5, "Air duct does not sit on the fan frame face");
assert(fan_cx - open_r - shroud_t > wall + inner_c && fan_cx + open_r + shroud_t < part_x
       && fan_cz - open_r - shroud_t > wall + inner_c && fan_cz + open_r + shroud_t < body_h - wall - inner_c,
       "Air duct hits the walls or the partition");
assert(shelf_z + shelf_t < body_h - wall, "Shelf above the top wall");
assert(front_t + shelf_d - shelf_hold[0] > pot_yz[0] + pwm_pcb[1] / 2 + 0.5, "Shelf hold-down plate reaches the PWM board");
assert(chg_fan_gap >= 5 && chg_gap - chg_tape >= 3
       && max(chg_y0 - 1 - (chg_gap + chg_pad_pcb - chg_ledge[1]), fan_y + fan_t + fan_pad + 0.5) + (chg_gap + chg_pad_pcb - chg_ledge[1]) < chg_y0 + chg_pcb[1] - 4
       && chg_pads[len(chg_pads) - 1][0] + chg_pads[len(chg_pads) - 1][1] <= chg_pcb[0] - 4 && chg_pads[0][0] >= 4
       && chg_y0 + chg_pcb[1] < body_d - back_t - 1 && chg_z + chg_pcb[0] / 2 < cable_notch_z[1] - cable_notch[1] / 2 - 2
       && chg_z - chg_pcb[0] / 2 - chg_ledge[0] > cable_notch_z[0] + cable_notch[1] / 2 + 2
       && cable_notch_z[0] - cable_notch[1] / 2 > cradle_z[1] + cradle_t + 1 && cable_notch_z[0] + cable_notch[1] / 2 < cradle_z[2] - 1,
       "Charge module reaches the fan frame, the back or the cable notch");
assert(chg_clip[0] >= 3 && chg_clip[1] <= 12.5 && chg_clip[3] + chg_clip[4] <= 0.7 && chg_clip[5][0] + chg_clip[4] >= 0.8 && chg_clip[5][1] <= 3 && chg_sink_z0 > chg_bz0 + chg_clip[1] + 5 && chg_sink_end >= 9.5
       && chg_sink_z0 + chg_rear_sink[0] < cable_notch_z[1] - cable_notch[1] / 2 - 2
       && chg_hz0 + chg_pads[1][0] + chg_pads[1][1] < chg_sink_z0 + chg_rear_sink[0],
       "Charge module holder: hooks on the OUT pads or beside the inductor, heatsink too close to the clip or off the metal pad, or it reaches the fan cable notch");
assert(chg_gap - chg_tape >= 0.5 && (part_x - chg_gap) - max(part_x - chg_gap - chg_pad_pcb + chg_ledge[1], fan_cx + fan_size / 2 + 0.3) >= 1,
       "Charge module: pads too thin for the tape, or less than 1 mm of board on the ledge beside the fan frame");
assert(bat_cx - bat_d / 2 - bat_bms[1] - bat_clear - bat_bms_cut[1] > bay_x0 + 1, "BMS board of the battery with its clearance hits the partition");
assert(cable_notch_z[0] - saddle_rib_slot[0] / 2 > cradle_z[1] + cradle_t + saddle_gusset - 0.5 && cable_notch_z[0] + saddle_rib_slot[0] / 2 < cradle_z[2] - saddle_gusset + 0.5
       && body_d - back_t - saddle_rib_slot[1] - saddle_rib_slot[0] / 2 > bat_cy + bat_d / 2 + bat_clear + 5,
       "Saddle stiffening: wire passage in the rib hits a fillet or reaches the battery end of the rib");
assert(mount_top < fan_cz - fan_size / 2 - 2 && (mount_boss_d - mount_insert[0]) / 2 >= mount_insert[2] + 1.5 && mount_floor >= 2,
       "Mount boss hits the fan, is thinner than the datasheet wall + 1.5 mm, or its floor is too thin");
assert(mount_xy[0] + mount_doubler[0] / 2 >= part_x - 1, "Mount doubler does not reach the partition");
assert(back_t - head_pocket[1] >= 2, "Back cover too thin under the recessed screw heads");
assert(usbc_xz[0] + usbc[1] / 2 - usbc_stop_x0() >= 2.5,
       "USB-C module: its stop on the right wall, kept out of the battery removal path, covers less than 2.5 mm of the board end");
assert(sw_bezel[2] <= sw_well[0] - 1 && sw_body[0] < sw_cut[0] && sw_body[1] < sw_cut[1] && sw_bezel[0] > sw_cut[0] + 2 * sw_cut_cl + 1 && sw_bezel[1] > sw_cut[1] + 2 * sw_cut_cl + 1
       && (sw_xz[1] - sw_well_half()[1] > shelf_z + shelf_t + shelf_hold[2] + shelf_hold[1] + 1 || sw_xz[1] + sw_well_half()[1] < shelf_z - 1)
       && sw_xz[1] + (sw_bezel[1] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t) < body_h - wall - 1
       && (sw_xz[0] + sw_body[0] / 2 + 1 < body_w - wall - pwm_wall_gap - pwm_pcb[0] || sw_xz[1] - sw_body[1] / 2 > shelf_z + shelf_t + pwm_standoff + pwm_total_h + 1 || sw_xz[1] + sw_body[1] / 2 < shelf_z - 1)
       && sw_xz[0] - sw_body[0] / 2 > bay_x0 + 1 && sw_xz[0] - (sw_bezel[0] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t) > part_x - 4 + slot_w / 2 + 1.2
       && sw_xz[0] + (sw_bezel[0] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t) < bay_x1 - lip_cl - lip_t,
       "Power switch: well hits the hold-down plate, top wall, back lip or intake slots, housing reaches the PWM module or the partition, or hole and frame do not match");
assert(usbc_stop[0] >= 4 && usbc_wall >= 2 && usbc_plate >= 1.2 && back_t - usbc_plate >= 1 && usbc_board[0] >= 8, "USB-C module: cover skin too thin, recess too shallow or board too short for the channel");
assert(usbc_xz[0] + usbc[1] / 2 + usbc_cl < bay_x1 - lip_cl - lip_t && usbc_xz[0] - usbc[1] / 2 - usbc_cl - usbc_wall > bay_x0 + 5
       && usbc_xz[1] + usbc[2] / 2 + usbc_cl < body_h - wall - 1
       && len([for (z = cradle_z) if (usbc_channel_z()[1] > z - 1 && usbc_channel_z()[0] < z + cradle_t + 1) z]) == 0 && usbc_channel_z()[1] < shelf_z - 1,   // between saddles, below the shelf
       "USB-C module hits the back lip, the top wall or a battery saddle");
assert(foot_key <= wall - 2 && foot_screw_skin >= 2.5 && foot_len / 2 - foot_screw_dy - head_pocket[0] / 2 - foot_c >= 3 && (foot_boss_d - insert_hole_d) / 2 >= insert_w_min + 0.5,
       "Feet: pocket too deep, too little TPU under the screw heads or beside them at the foot ends, or boss wall below the Ruthex minimum");
assert(body_w - foot_inset - max(foot_doubler_hw, foot_boss_d / 2) > bat_cx + bat_d / 2 + 1 && foot_inset - foot_w / 2 > corner_r
       && foot_y0 > edge_c + 3 && foot_y0 + foot_len < part_y1 && foot_boss_top < min(fan_cz - fan_size / 2 - 2, cradle_z[0] - 1),
       "Feet: doubler or boss reaches the battery, the fan or the cradle, or foot in the corner radius or beyond the body");
assert((back_boss_d - insert_hole_d) / 2 >= 3 && back_boss_len >= insert_depth + 6 && boss_inset + back_boss_d / 2 + 1 < 14,
       "Back bosses: wall around the insert, column length, or reaching the back cover slots");
// hand under the raised bail: child hand breadth about 55-70 mm, adult 80-90 mm; comfortable finger clearance 30-35 mm
assert(bail_room() >= 38 && body_w - 2 * bail_x[1] >= 90 && bail_ramp_y() > front_t + inner_c + wall
       && bail_bar_z[0] > sw_xz[1] + sw_bezel[1] / 2 + sw_well[1] + sw_well[0] + 1,
       "Bail: too little room for the hand, step ramp too far forward, or the folded grip bar covers the power switch");
assert(cover_w / 2 - cover_notch_r >= 6 && wall - cover_glue[0] - cover_glue[2] >= 1.8 && cover_glue[1] + cover_glue[2] < cover_t
       && cover_t - cover_glue[1] - cover_glue[2] >= cover_glue[0] + cover_glue[2] && cover_notch_c < 2 * cover_t,
       "Service cover: corners beside the notch too narrow, or the glue groove too deep for the wall or too wide for the cover rim");
assert(pot_yz[0] - pwm_pcb[1] / 2 > front_t + inner_c && pot_yz[0] + pwm_pcb[1] / 2 < front_t + shelf_d
       && body_w - wall - pwm_wall_gap - pwm_pcb[0] - (pot_shaft_tip + wall + 1) > bay_x0 + 0.5
       && pot_yz[1] + pwm_comp_h + 2 < body_h - wall - 10
       && (usbc_xz[1] + usbc[2] / 2 < shelf_z || pot_yz[1] - pot_axis_h + pwm_comp_h < usbc_xz[1] + usbc[2] / 2 - usbc_stop[1] - 1),
       "PWM board: beyond the shelf, no room to pull it off the wall, too high, or its parts reach the USB-C stop");
assert(pot_tab_z()[1] < pot_axis_h + pwm_pcb[2] && pot_tab[2] < pot_mount_t + 1 && pot_tab_z()[0] > pot_bush_bore() / 2 + 1.2 &&   // against the drilled bore, not the nominal bushing: the wall between slot and bore is a real wall
       pot_mount_t >= 1.6 && pot_thread_reserve >= 0.1 && pot_nose_len > 0 && pwm_pcb_slot < pot_recess - 0.2
       && pot_recess_r >= pot_housing / 2 * sqrt(2) + 0.5 && pot_nut[0] < knob_cavity_d - 1
       && cover_groove_gap(pot_recess_r, pot_mount_t) >= 1.2
       && cover_groove_gap(norm([pwm_pcb[1] / 2 + pot_pcb_cl, pot_axis_h + pwm_pcb[2] + pot_pcb_cl]), wall - pwm_pcb_slot) >= 1.2,
       "Potentiometer: wall under the nut too thin, no thread reserve, housing pocket too small or too shallow for the PCB slot, knob recess misses the nut, or a pocket comes within 1.2 mm of the cover glue groove");
assert(pwm_pad < pwm_edge_free && pwm_standoff > pwm_pins + pwm_pin_cl + 3 && pwm_rib >= 2.4
       && pwm_standoff - pwm_pins - pwm_pin_cl - pwm_rib_hole[2] - pwm_rib_hole[1] >= 2 && pwm_rib_hole[0] + pwm_rib_hole[1] / 2 < pwm_pcb[1] - 2 * pwm_pad
       && pwm_rib_x()[0] + pwm_rib <= bat_cx + 10 - cable_slot_w / 2 - 0.2 && pwm_rib_x()[1] + pwm_rib <= body_w - wall,
       "PWM supports: pads wider than the pin-free edges, cable passage leaving less than 2 mm under the pin notch or longer than the notch, no rib left under the pin clearance, rib too thin, left rib over the battery cable slot, or right rib in the wall");
assert(pot_shaft_tip - knob_gap - knob_sleeve_z >= 8 && knob_skin >= 2 && knob_cavity_d > pot_nut[0] + 1 && knob_gap + knob_sleeve_z > pot_washer[1] + pot_nut[1] + 0.3   // recess over washer and nut on the outer face
       && knob_sleeve_z + knob_slit[1] < knob_len - knob_skin - 2 && knob_gap + knob_len - cover_out <= 8,
       "Knob: shaft engagement, top skin, nut recess, slit length or protrusion");
assert((bail_arm[1] - bail_bush[0]) / 2 >= 2.2 && bail_band - bail_screw[3] - bail_screw[1] >= bail_x[0] + 0.3 && bail_band - bail_screw[3] + bail_bush[2] <= bail_eye_x[0]
       && bail_band - bail_screw[3] + bail_bush[3] <= bail_eye_x[1] && bail_screw[0] / 2 + 0.5 <= bail_arm[1] / 2 + 0.5 && bail_bush[1] / 2 < bail_arm[1] / 2 + 0.5
       && bail_screw[4] <= m4_insert[1] && bail_arm[1] / 2 - m4_insert[0] / 2 >= m4_insert[2] && bail_screw[2] < bail_bush[0] - 1,
       "Bail pivot: eye wall round the bushing, flange hits the eye, bushing longer than the eye, head or flange bigger than the recess, thread longer than the insert, or insert boss wall");
assert(bail_floor - wall > fan_cz + fan_size / 2 + 1 && bail_floor - wall > sw_xz[1] + sw_bezel[1] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t + 1
       && bail_floor - wall > body_h - 18 + slot_w
       && boss_top_x - back_boss_d / 2 > bail_band + wall,
       "Bail steps reach the fan, the switch well, the side intake slots, the logo or the LED boss, or the top back bosses reach a step");
assert(let (h = (qr_n / 2 + qr_quiet) * qr_module) qr_module >= 0.8 && qr_xz[0] - h > part_x - 4 + slot_w / 2 + 1
       && qr_xz[1] - h > usbc_xz[1] - usbc[2] / 2 + usbc_shell_bottom + usbc_shell[1] + usbc_cl + 1 && qr_xz[0] + h < body_w - wall - lip_t - 2
       && qr_xz[1] + h < bail_bar_z[0] - bail_cl && qr_xz[1] - h > sw_xz[1] + sw_well_half()[1] + sw_well[0],
       "QR code: modules below the inlay minimum, or code plus quiet zone reaching the intake slots, USB-C socket, switch well, the side edge or the folded grip");
assert(usb_notch_z - cable_notch[1] / 2 > cradle_z[2] + cradle_t && usb_notch_z + cable_notch[1] / 2 < shelf_z
       && chg_y0 + chg_pcb[1] < part_y1 - cable_notch[0] + 1 - 2
       && min([for (p = tie_loop_xz) p[0] - tie_loop[0] / 2]) > part_x + part_t + 5 && tie_loop[2] - tie_loop[4] >= 3
       && tie_loop_xz[0][0] + tie_loop[0] / 2 < usbc_xz[0] - usbc[1] / 2 - usbc_cl - usbc_wall - 3
       && tie_loop_xz[1][0] + tie_loop[0] / 2 < saddle_rib[1] - saddle_rib[0] / 2 - 1 && tie_loop_xz[1][0] + tie_loop[0] / 2 < sw_xz[0] - sw_well_half()[0] - 1
       && abs(tie_loop_xz[1][1] - sw_xz[1]) + tie_loop[1] / 2 < cradle_z[2] - (cradle_z[1] + cradle_t) - saddle_gusset,
       "Cable routing: USB-C notch outside the bay between top saddle and shelf or at the charge module, or a tie loop hitting the partition, USB-C channel, saddle rib, switch well or saddle fillets, or its bar too thin");
assert(logo_x0 > fan_cx + grille_r + 3 && logo_x0 + logo_w < body_w - corner_r - 2 && logo_top < body_h - corner_r - 2,
       "Logo outside the free front area");
assert(big_gap >= 2, "Big letters too wide for the second line");
assert(sub_stroke >= 1.2 && stencil_gap >= 1.2, "Logo lines or gaps below 1.2 mm");
assert(len(dedication_size) == len(dedication) && len(dedication_z) == len(dedication) && len(dedication_w) == len(dedication)
       && min(dedication_z) - 0.5 > shelf_z + shelf_t + pwm_standoff + pwm_pcb[2] + pwm_comp_h   // the lowest line (date) has no descenders
       && max([for (i = [0:len(dedication) - 1]) dedication_z[i] + dedication_size[i]]) < bail_floor - wall - 1
       && len([for (i = [0:len(dedication) - 1]) if (!(dedication_z[i] + dedication_size[i] < led_xz[1] - led_boss[0] / 2 - 1
                                                       || dedication_x + dedication_w[i] / 2 < led_xz[0] - led_boss[0] / 2 - 1)) i]) == 0
       && dedication_x - max(dedication_w) / 2 > bay_x0 + 2,
       "Dedication hidden behind the PWM board, under the bail recess, into the LED boss or into the partition");
assert(brand[2] == "O" && led_skin > inlay_t && led_d / 2 + 1 < (big_size[0] - 2 * big_stroke) / 2, "LED pocket does not fit into the counter of the O");
assert(front_t - groove_depth >= 1.2 && groove_pitch - groove_w >= 1.1, "Grooves too deep or webs too thin");
assert(groove_z0 + (groove_count - 1) * groove_pitch + groove_w < logo_bottom - 3, "Grooves run into the logo");
// thread engagement at least 1 x d in the brass inserts (the fan screws sit on 1 mm silicone pads)
for (s = screw_table) assert(s[2] >= 3 - 0.01 && s[3] >= 0.3, str("Screw ", s[0], ": engagement ", s[2], ", tip margin ", s[3]));

// ---------- helpers ----------
module rrect(size, r) offset(r = r) offset(delta = -r) square(size, center = true);
module rect(a, b) translate([min(a[0], b[0]), min(a[1], b[1])]) square([max(abs(b[0] - a[0]), eps), max(abs(b[1] - a[1]), eps)]);
// 2D children in (x, z) extruded along y, and in (y, z) extruded along x
module along_y(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();
module along_x(x0, x1) translate([x0, 0, 0]) multmatrix([[0, 0, 1, 0], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]]) linear_extrude(x1 - x0) children();
module cyl_y(c, y0, y1, r1, r2 = -1) translate([c[0], y0, c[1]]) rotate([-90, 0, 0]) cylinder(r1 = r1, r2 = r2 < 0 ? r1 : r2, h = y1 - y0);
module cyl_x(c, x0, x1, r1, r2 = -1) translate([x0, c[0], c[1]]) rotate([0, 90, 0]) cylinder(r1 = r1, r2 = r2 < 0 ? r1 : r2, h = x1 - x0);
module slot2d(a, b, w) hull() { translate(a) circle(d = w); translate(b) circle(d = w); }
// Point the local +z axis along an axis-aligned direction
module orient(d) {
    if (d[2] < 0) rotate([180, 0, 0]) children();
    else if (d[1] > 0) rotate([-90, 0, 0]) children();
    else if (d[1] < 0) rotate([90, 0, 0]) children();
    else if (d[0] > 0) rotate([0, 90, 0]) children();
    else if (d[0] < 0) rotate([0, -90, 0]) children();
    else children();
}

// Multicolour inlays, applied in print orientation: children(0) = part with the decorated face on the bed,
// children(1) = 2D inlay in print-orientation xy. The pieces overlap nowhere and together are the part.
module inlay_zone(d = inlay_t, z0 = 0) translate([0, 0, z0 - eps]) linear_extrude(d + eps) children();   // z0: face the inlay sits on
module inlay_base(d = inlay_t) difference() { children(0); inlay_zone(d) children(1); }
module inlay_piece(d = inlay_t) intersection() { children(0); inlay_zone(d) children(1); }

// ---------- body ----------
module body_outline(inset = 0) translate([body_w / 2, body_h / 2]) rrect([body_w - 2 * inset, body_h - 2 * inset], max(corner_r - inset, 0.5));
module body_inner(extra = 0) body_outline(wall + extra);
module boss_footprint(b) hull() { translate(b[0]) circle(d = back_boss_d); rect(b[1], b[2]); }

module back_boss(b) {
    y1 = body_d - back_t;
    along_y(y1 - back_boss_len, y1) boss_footprint(b);
    hull() {                       // cone down to the wall corner, printable without support
        along_y(y1 - back_boss_len, y1 - back_boss_len + tip) boss_footprint(b);
        along_y(y1 - back_boss_len - gusset, y1 - back_boss_len - gusset + tip) rect(b[3], b[4]);
    }
}

module intake_slots_back() {
    h = (body_h - 28 - (back_slot_rows - 1) * back_slot_bar) / back_slot_rows;
    bars = [for (i = [0:back_slot_rows - 1]) let (z = 14 + i * (h + back_slot_bar)) [z, z + h]];
    for (x = [14.8:slot_pitch:part_x - 4], z = bars) if (abs(x - back_bar_x) > slot_w / 2 + 1.5) slot2d([x, z[0] + slot_w / 2], [x, z[1] - slot_w / 2], slot_w);
}

module intake_slots_side() {
    for (z = [18:slot_pitch:body_h - 18], y = [[12, 37.5], [40.5, body_d - back_t - lip_h - 1.5]])   // rear slots end before the back-cover lip
        slot2d([y[0] + slot_w / 2, z], [y[1] - slot_w / 2, z], slot_w);
}

module body(dedication = true) difference() {   // dedication = false for public images
    union() {
        difference() {
            hull() {
                along_y(0, eps) body_outline(edge_c);
                along_y(edge_c, body_d - back_t) body_outline();
            }
            along_y(front_t, body_d + 1) body_inner();
        }
        // 45 degree fillet along the joint of front plate and walls
        difference() {
            along_y(front_t - eps, front_t + inner_c) body_inner();
            hull() {
                along_y(front_t - 2 * eps, front_t) body_inner(inner_c);
                along_y(front_t + inner_c, front_t + inner_c + eps) body_inner();
            }
        }
        cyl_y(led_xz, front_t - eps, led_boss[1], led_boss[0] / 2);   // boss for the LED behind the O
        if (dedication) along_y(front_t - eps, front_t + dedication_h) dedication_2d();   // dedication on the inside of the front plate, grey in print
        // round air duct from the front plate to the fan frame face
        difference() {
            cyl_y([fan_cx, fan_cz], front_t - eps, fan_y - shroud_gap, open_r + shroud_t);
            cyl_y([fan_cx, fan_cz], front_t - 1, fan_y, open_r);
        }
        // partition between fan section and electronics bay
        translate([part_x, front_t - eps, wall - eps]) cube([part_t, part_y1 - front_t + eps, body_h - 2 * wall + 2 * eps]);
        for (p = fan_holes()) cyl_y(p, front_t - eps, fan_y - fan_pad, fan_boss_d / 2);   // the corner pads rest on them
        for (b = back_bosses()) back_boss(b);
        // grille bars behind the front plate, into the duct: stiffness of the printed-in grille (grey part ends at the plate)
        along_y(front_t - 0.5, grille_depth) translate([fan_cx, fan_cz]) intersection() { grille_bars_2d(); circle(r = open_r + shroud_t / 2); }   // ends inside plate and duct wall (clean mesh)
        // battery cradle ribs, open towards the back
        for (z = cradle_z) difference() {
            translate([bay_x0 - eps, front_t - eps, z]) cube([bay_x1 - bay_x0 + 2 * eps, bat_cy - front_t + eps, cradle_t]);
            translate([bat_cx, bat_cy, z - 1]) cylinder(r = bat_d / 2 + bat_clear, h = cradle_t + 2);
            // rectangular cut-out for the BMS board, open towards the back like the cradle
            translate([bat_cx - bat_d / 2 - bat_bms[1] - bat_clear - bat_bms_cut[1], bat_cy - bat_bms[0] / 2 - bat_clear - bat_bms_cut[0], z - 1])
                cube([bat_bms[1] + bat_clear + bat_bms_cut[1] + bat_d / 2, bat_bms[0] + 2 * (bat_clear + bat_bms_cut[0]), cradle_t + 2]);
        }
        // boss for the M5 mount insert, with a 45 degree cone to the bottom wall towards the front (printable)
        let (zd = wall + mount_doubler[2]) {
            hull() {
                translate([mount_xy[0], mount_xy[1], wall - eps]) cylinder(d = mount_boss_d, h = mount_top - wall + eps);
                translate([mount_xy[0] - mount_boss_d / 2, mount_xy[1] - mount_boss_d / 2 - (mount_top - zd), zd - 1]) cube([mount_boss_d, tip, 1]);
            }
            translate([mount_xy[0] - mount_rib[0] / 2, mount_xy[1], wall - eps]) cube([mount_rib[0], mount_boss_d / 2 + mount_rib[1], mount_top - wall + eps]);
            // floor doubler from the front plate to the partition: spreads lever loads of the mount
            translate([mount_xy[0] - mount_doubler[0] / 2, front_t - eps, wall - eps])
                cube([part_x + eps - (mount_xy[0] - mount_doubler[0] / 2), mount_doubler[1] - front_t + eps, mount_doubler[2] + eps]);
        }
        // folding bail: floor and inner wall of both side steps from the pivot to the back edge, running out into the wall corner at
        // 45 degrees towards the front (printable), and bosses for the M4 pivot inserts with a 45 degree underside towards the front
        intersection() {   // clipped to the outer outline, it would stand out of the rounded top corners
            along_y(-1, body_d + 1) body_outline();
            bail_sides() let (y0 = min(bail_y - bail_arm[1] / 2 - bail_cl, bail_ramp_y()) - wall) hull() {
                translate([wall - eps, y0, bail_floor - wall]) cube([bail_band + eps, body_d - back_t - y0, bail_arm[1] + wall - eps]);
                translate([wall - eps, max(front_t, y0 - (bail_arm[1] + wall + bail_band)), body_h - wall]) cube([0.2, 0.2, wall - 0.1]);
            }
        }
        bail_sides() {
            along_x(bail_band - eps, bail_band + m4_insert[1] + 2.5) hull() {
                translate([bail_y, bail_z]) circle(d = bail_arm[1]);
                translate([bail_y - bail_arm[1] / 2 / sqrt(2) - (body_h - wall - bail_z + bail_arm[1] / 2 / sqrt(2)), body_h - wall]) square([tip, wall - eps]);
            }
        }
        // two ribs on the shelf carry the PWM board on pads under its pin-free long edges, the solder pins in between stay
        // free; the ribs start at the front plate (printable), the back pad overhangs only the pin clearance
        // (the ribs run on behind the board edge up to the hold-down plate, so the back pads are not thin blades)
        for (i = [0, 1]) let (x = pwm_rib_x()[i], w = pwm_rib + (i ? 0.5 : 0)) difference() {   // the right rib reaches 0.5 into the wall
            translate([x, front_t - eps, shelf_z + shelf_t - eps]) cube([w, front_t + shelf_d - shelf_hold[0] - 0.3 - front_t, pwm_standoff + eps]);
            translate([x - 1, pot_yz[0] - pwm_pcb[1] / 2 + pwm_pad, shelf_z + shelf_t + pwm_standoff - pwm_pins - pwm_pin_cl])
                cube([pwm_rib + (i ? 1 : 2), pwm_pcb[1] - 2 * pwm_pad, pwm_pins + pwm_pin_cl + 1]);   // pin notch, not into the wall
            if (i == 0) let (h = pwm_rib_hole, z0 = shelf_z + shelf_t + h[2], y0 = pot_yz[0] - h[0] / 2) hull() {   // cable passage below the board (none at the wall, user)
                translate([x - 1, y0, z0]) cube([pwm_rib + 2, h[0], h[1]]);
                translate([x - 1, y0 + h[0] + h[1] / 2 - tip, z0 + h[1] / 2 - tip / 2]) cube([pwm_rib + 2, tip, tip]);
            }
        }
        // charge/boost module standing upright: board back on two pads (tape), lower short edge on a ledge behind the
        // part side; 45 degree cones towards the front (printable)
        let (xb = part_x - chg_gap - chg_pad_pcb, zb = chg_z - chg_pcb[0] / 2) {   // printed layout: the holder now sits on pads and ledge
            for (pd = chg_pads) hull() {
                translate([xb + chg_pad_pcb + chg_tape, chg_y0 + 1, zb + pd[0]]) cube([chg_gap - chg_tape + eps, chg_pcb[1] - 2, pd[1]]);
                translate([part_x, chg_y0 + 1 - (chg_gap - chg_tape), zb + pd[0]]) cube([1, tip, pd[1]]);
            }
            // ledge: its 45 degree cone starts behind the fan frame and reaches full width towards the back
            let (x0 = max(xb + chg_ledge[1], fan_cx + fan_size / 2 + 0.3), reach = part_x - x0, ya = max(chg_y0 - 1 - reach, fan_y + fan_t + fan_pad + 0.5), yf = ya + reach) hull() {
                translate([x0, yf, zb - chg_ledge[0]]) cube([reach + eps, chg_y0 + chg_pcb[1] + 1 - yf, chg_ledge[0]]);
                translate([part_x, ya, zb - chg_ledge[0]]) cube([1, tip, chg_ledge[0]]);
            }
        }
        // floor doublers over the foot pockets keep the bottom wall at 3.2 mm; bosses for the foot inserts with 45 degree
        // cones towards the front; all start at the front plate or on the floor (printable)
        for (fx = foot_x()) translate([fx - foot_doubler_hw, front_t - eps, wall - eps])
            cube([2 * foot_doubler_hw, part_y1 - front_t + eps, foot_key + eps]);
        for (p = foot_screws()) let (zf = wall + foot_key) hull() {
            translate([p[0], p[1], wall - eps]) cylinder(d = foot_boss_d, h = foot_boss_top - wall + eps);
            translate([p[0] - foot_boss_d / 2, p[1] - foot_boss_d / 2 - (foot_boss_top - zf), zf - 1]) cube([foot_boss_d, tip, 1]);
        }
        // stop on the right wall behind the USB-C module in the back cover, ending beside the battery removal path; 45 degree wedge towards the front (printable)
        let (x0 = usbc_stop_x0(), ys = usbc_y0 - usbc_cl, z0 = usbc_xz[1] + usbc[2] / 2 - usbc_stop[1]) hull() {
            translate([x0, ys - usbc_stop[0], z0]) cube([bay_x1 - x0 + eps, usbc_stop[0], usbc_stop[1]]);
            translate([bay_x1 - eps, ys - usbc_stop[0] - (bay_x1 - x0), z0]) cube([0.5 + tip, tip, usbc_stop[1]]);
        }
        // electronics shelf, also stops the battery upwards
        translate([bay_x0 - eps, front_t - eps, shelf_z]) cube([bay_x1 - bay_x0 + 2 * eps, shelf_d + eps, shelf_t]);
        along_y(front_t - eps, front_t + shelf_d) {
            for (zj = [shelf_z + eps, shelf_z + shelf_t - eps], s = [-1, 1]) let (dz = zj > shelf_z + 1 ? shelf_fillet : -shelf_fillet) {
                polygon([[bay_x0 - eps, zj], [bay_x0 + shelf_fillet, zj], [bay_x0 - eps, zj + dz]]);
                polygon([[bay_x1 + eps, zj], [bay_x1 - shelf_fillet, zj], [bay_x1 + eps, zj + dz]]);
            }
        }
    }
    difference() {   // front opening; the grille bars stay as part of the front plate (grey, flush with the front face)
        cyl_y([fan_cx, fan_cz], -1, front_t + 1, open_r);
        along_y(-2, front_t + 2) translate([fan_cx, fan_cz]) grille_bars_2d();
    }
    // small groove round the grey ring: the grille looks set into the front (open to the bed in print)
    along_y(-1, grille_groove[1]) translate([fan_cx, fan_cz]) difference() { circle(r = grille_r + grille_groove[0]); circle(r = grille_r); }
    // pockets for the tops of the TPU feet, 45 degree ends; inserts pressed in from below
    for (fx = foot_x()) translate([fx, foot_y0, 0]) hull() {
        translate([-foot_w / 2 - foot_cl, -foot_cl - 1, -1]) cube([foot_w + 2 * foot_cl, foot_len + 2 * foot_cl + 2, tip]);
        translate([-foot_w / 2 - foot_cl, foot_key - foot_cl, foot_key - tip]) cube([foot_w + 2 * foot_cl, foot_len + 2 * foot_cl - 2 * foot_key, tip]);
    }
    for (p = foot_screws()) translate([p[0], p[1], foot_key - eps]) cylinder(d = insert_hole_d, h = insert_depth + eps);
    cyl_y(led_xz, led_skin, led_boss[1] + 1, (led_d + led_cl) / 2);   // LED pocket, blind towards the front
    for (i = [0:groove_count - 1]) let (z = groove_z0 + i * groove_pitch)
        along_y(-1, groove_depth) slot2d([groove_x[0] + groove_w, z], [groove_x[1] - groove_w, z], groove_w);
    for (p = fan_holes()) cyl_y(p, fan_y - fan_pad - insert_depth, fan_y + 1, insert_hole_d / 2);
    for (b = back_bosses()) cyl_y(b[0], body_d - back_t - insert_depth, body_d + 1, insert_hole_d / 2);
    // cable notches at the back edge of the partition: low for the USB-C wires, high for the fan cable
    for (z = concat(cable_notch_z, [usb_notch_z])) translate([part_x - 1, part_y1 - cable_notch[0] + 1, z - cable_notch[1] / 2]) cube([part_t + 2, cable_notch[0], cable_notch[1]]);
    // battery cable slot through the shelf; the shelf rim still stops the battery upwards
    translate([bat_cx + 10 - cable_slot_w / 2, bat_cy - 6, shelf_z - 1]) cube([cable_slot_w, shelf_d + front_t - bat_cy + 7, shelf_t + 2]);
    along_x(-1, wall + 1) intake_slots_side();
    cyl_x(pot_yz, body_w - wall - 1, body_w + 1, pot_bush_bore() / 2);   // potentiometer bushing, nutted to the wall
    // from inside: round pocket for the potentiometer housing (shoulder on its floor) and a shallow slot for the PCB edge;
    // washer and nut sit on the flat outer face under the knob
    cyl_x(pot_yz, body_w - wall - 1, body_w - pot_mount_t, pot_recess_r);
    translate([body_w - wall - 1, pot_yz[0] - pwm_pcb[1] / 2 - pot_pcb_cl, pot_yz[1] - pot_axis_h - pwm_pcb[2] - pot_pcb_cl])
        cube([1 + pwm_pcb_slot, pwm_pcb[1] + 2 * pot_pcb_cl, pwm_pcb[2] + 2 * pot_pcb_cl]);
    // slot through the thin wall for the anti-rotation tab below the shaft (it tilted the potentiometer when tightened, user);
    // its far end reaches past washer and nut, so it is the knob that covers it outside
    translate([body_w - pot_mount_t - 1, pot_yz[0] - pot_tab[0] / 2 - pot_tab_cl, pot_yz[1] - pot_tab_z()[1]])
        cube([pot_mount_t + 2, pot_tab[0] + 2 * pot_tab_cl, pot_tab_z()[1] - pot_tab_z()[0]]);
    // folding bail: steps along both top side edges from the pivot to the back (the bail only folds backwards, the side wall stays
    // full height in front); a ramp in front of the eye stops the bail at the carrying angle; M4 insert holes in the inner walls
    bail_sides() let (r = bail_arm[1] / 2 + bail_cl) {
        translate([-1, bail_y, bail_floor]) cube([bail_band + 1, body_d + 2 - bail_y, bail_arm[1] + 1]);   // the upper legs rest on this floor
        hull() {   // around the eye, with the ramp that stops the bail at the carrying angle
            cyl_x([bail_y, bail_z], -1, bail_band, r);
            translate([-1, bail_ramp_y(), body_h + 1]) cube([bail_band + 1, 0.2, 1]);
        }
        cyl_x([bail_y, bail_z], bail_band - eps, bail_band + m4_insert[1] + 1, m4_insert[0] / 2);
        // outer edge of the whole step outline (ramp, arc round the eye, floor) chamfered on the side face and round the rounded top corner
        bail_step_edge_chamfer();
        // top edges of the step (ramp and inner wall) chamfered as one hull, so both chamfers meet in a clean corner:
        // a slab of the step outline 1 mm below the top face and one grown by 2 mm 1 mm above it
        let (k = -cos(bail_carry) / sin(bail_carry), y1 = bail_ramp_y() + k, c = bail_c) hull() {
            translate([-1, y1 + c * k, body_h - c]) cube([bail_band + 1, body_d + 1 - (y1 + c * k), tip]);
            translate([-1, y1 - 2 * c - c * k, body_h + c]) cube([bail_band + 2 * c + 1, body_d + 1 - (y1 - 2 * c - c * k), tip]);
        }
    }
    // groove for the glued-in service cover with 45 degree flanks, printable in every direction (the side wall stands upright in
    // print, vertical flanks would leave overhanging groove ceilings); 0.2 mm steps, the rim sits on the floor with a glue gap
    let (gd = cover_glue[0] + cover_glue[2], fo = cover_t - cover_glue[1] - cover_glue[2], fi = cover_t + cover_glue[2], n = ceil(gd / 0.2))
        for (k = [0:n - 1]) let (s = gd * (k + 1) / n)
            along_x(body_w - s, body_w - gd * k / n + (k == 0 ? 1 : eps)) difference() {
                cover_2d(fo - (gd - s));
                cover_2d(fi + (gd - s));
            }
    translate([mount_xy[0], mount_xy[1], -1]) cylinder(d = mount_insert[0], h = mount_insert[1] + 1 + 1);   // M5 insert from the underside
}

// ---------- logo: block letters in industrial / cyberpunk style ----------
// Glyphs on a 4 x 6 grid as polylines, stroked with octagons (45 degree chamfers), corner cuts top left /
// bottom right. No font dependency and a guaranteed stroke width for the inlay.
function glyph(c) =
    c == "L" ? [[[0, 6], [0, 0], [4, 0]]] :
    c == "E" ? [[[4, 6], [0, 6], [0, 0], [4, 0]], [[0, 3], [3, 3]]] :
    c == "O" ? [[[0, 0], [3, 0], [4, 1], [4, 6], [1, 6], [0, 5], [0, 0]]] :
    c == "I" ? [[[0, 0], [0, 6]]] :
    c == "N" ? [[[0, 0], [0, 6], [4, 0], [4, 6]]] :
    c == "D" ? [[[0, 0], [0, 6], [3, 6], [4, 5], [4, 1], [3, 0], [0, 0]]] :
    c == "U" ? [[[0, 6], [0, 0], [3, 0], [4, 1], [4, 6]]] :
    c == "S" ? [[[4, 6], [1, 6], [0, 5], [0, 3], [4, 3], [4, 1], [3, 0], [0, 0]]] :
    c == "T" ? [[[0, 6], [4, 6]], [[2, 6], [2, 0]]] :
    c == "R" ? [[[0, 0], [0, 6], [3, 6], [4, 5], [4, 4], [3, 3], [0, 3]], [[2, 3], [4, 0]]] :
    c == "A" ? [[[0, 0], [0, 5], [1, 6], [4, 6], [4, 0]], [[0, 3], [4, 3]]] :
    c == "C" ? [[[4, 6], [1, 6], [0, 5], [0, 0], [4, 0]]] :
    c == "-" ? [[[0, 3], [3, 3]]] :
    c == "1" ? [[[0, 6], [1.5, 6], [1.5, 0]]] :
    c == " " ? [] :
    assert(false, str("No glyph for ", c)) [];
// stencil bridges: [grid x, grid y, "v" = vertical band through x, "h" = horizontal band through y]
function stencil(c) = c == "L" || c == "E" ? [[1.2, 0, "v"]] : c == "O" ? [[0, 3, "h"]] : [];
// advance width from the widest grid point; a space is half a letter
function glyph_w(c, size, stroke) = c == " " ? size[0] / 2 :
    max([for (path = glyph(c)) for (p = path) p[0]]) / 4 * (size[0] - stroke) + stroke;
function text_w(s, size, stroke, gap, i = 0) =
    i >= len(s) ? -gap : glyph_w(s[i], size, stroke) + gap + text_w(s, size, stroke, gap, i + 1);
function text_x(s, size, stroke, gap, i) =
    i == 0 ? 0 : text_x(s, size, stroke, gap, i - 1) + glyph_w(s[i - 1], size, stroke) + gap;

module oct_dot(w) rotate(22.5) circle(r = w / 2 / cos(22.5), $fn = 8);   // flat to flat = w
module glyph_2d(c, size, stroke, cut = false) {
    k = [(size[0] - stroke) / 4, (size[1] - stroke) / 6];
    function at(g) = [g[0] * k[0] + stroke / 2, g[1] * k[1] + stroke / 2];
    difference() {
        for (path = glyph(c)) for (i = [0:len(path) - 2]) hull() {
            translate(at(path[i])) oct_dot(stroke);
            translate(at(path[i + 1])) oct_dot(stroke);
        }
        if (cut) for (s = stencil(c))
            if (s[2] == "v") translate([at(s)[0] - stencil_gap / 2, -1]) square([stencil_gap, size[1] + 2]);
            else translate([-1, at(s)[1] - stencil_gap / 2]) square([size[0] + 2, stencil_gap]);
    }
}
module block_text(s, size, stroke, gap, cut = false) {   // starts at x = 0, baseline y = 0
    for (i = [0:len(s) - 1]) translate([text_x(s, size, stroke, gap, i), 0]) glyph_2d(s[i], size, stroke, cut);
}

// Front view (x, z) of the logo, three left-aligned lines; in print xy it is mirrored in y (pose below)
module label_front_2d() {
    translate([logo_x0, logo_top - big_size[1]]) block_text(brand, big_size, big_stroke, big_gap, cut = true);
    translate([logo_x0, logo_top - big_size[1] - line_gap - sub_size[1]]) block_text(brand_sub, sub_size, sub_stroke, sub_gap);
    translate([logo_x0, logo_bottom]) block_text(brand_model, sub_size, sub_stroke, sub_gap);
}
module body_print_pose() rotate([90, 0, 0]) children();       // front face on the bed: (x, y, z) -> (x, -z, y)
module body_install_pose() rotate([-90, 0, 0]) children();
module body_label_print_2d() mirror([0, 1]) label_front_2d();
// dedication in front view coordinates (x, z), mirrored in x so it reads from behind
module dedication_2d() for (i = [0:len(dedication) - 1])
    translate([dedication_x, dedication_z[i]]) mirror([1, 0]) offset(delta = dedication_bold)
        text(dedication[i], size = dedication_size[i], font = dedication_font, halign = "center");
module body_dedication_print_2d() mirror([0, 1]) dedication_2d();
// multicolour pieces of the body in print orientation: logo inlay on the bed, dedication raised on the inside of the front plate
// grille in grey: the bars through the whole front plate inside the opening, a ring inlay round it on the front face
module body_grille_zone() {
    inlay_zone(front_t + eps) mirror([0, 1]) translate([fan_cx, fan_cz]) circle(r = open_r + 0.01);
    inlay_zone() mirror([0, 1]) translate([fan_cx, fan_cz]) circle(r = grille_r);
}
module body_piece(piece)
    if (piece == "base") difference() {
        body_print_pose() body();
        inlay_zone() body_label_print_2d();
        inlay_zone(dedication_h + eps, front_t) body_dedication_print_2d();
        body_grille_zone();
    }
    else intersection() {
        body_print_pose() body();
        if (piece == "label") inlay_zone() body_label_print_2d();
        else if (piece == "grille") body_grille_zone();
        else inlay_zone(dedication_h + eps, front_t) body_dedication_print_2d();
    }

// ---------- grille ----------
module grille_bars_2d() {
    circle(r = grille_hub_r);
    for (k = [1:grille_rings]) let (r0 = grille_hub_r + k * grille_gap + (k - 1) * grille_bar)
        difference() { circle(r = r0 + grille_bar); circle(r = r0); }
    for (i = [0:grille_spokes - 1]) rotate(i * 360 / grille_spokes) translate([0, -grille_bar / 2]) square([ring_in + 1, grille_bar]);
}


// ---------- back cover ----------
module back() difference() {
    y1 = body_d - back_t;
    union() {
        hull() {
            along_y(y1, body_d - edge_c) body_outline();
            along_y(body_d - eps, body_d) body_outline(edge_c);
        }
        along_y(lip_y0, y1 + eps) difference() {
            body_inner(lip_cl);
            body_inner(lip_cl + lip_t);
            for (b = back_bosses()) offset(r = 0.8) boss_footprint(b);
            bail_sides() translate([-1, bail_floor - wall - lip_cl]) square([bail_band + wall + lip_cl + 1, body_h]);   // clear of the step walls
        }
        // hold-down plate over the free back edge of the battery shelf
        translate([bay_x0 + shelf_fillet + 0.5, front_t + shelf_d - shelf_hold[0], shelf_z + shelf_t + shelf_hold[2]])
            cube([bay_x1 - bay_x0 - 2 * shelf_fillet - 1, y1 - (front_t + shelf_d - shelf_hold[0]) + eps, shelf_hold[1]]);
        // saddles closing the cradle rings around the battery, across the whole bay, with the BMS cut-out
        for (z = cradle_z) difference() {
            translate([bay_x0 + 0.5, bat_cy + saddle_gap, z]) cube([bay_x1 - bay_x0 - 1, y1 - bat_cy - saddle_gap + eps, cradle_t]);
            translate([bat_cx, bat_cy, z - 1]) cylinder(r = bat_d / 2 + bat_clear, h = cradle_t + 2);
            // out past the saddle edge: the strip between the saddle edge and the BMS board stood free above the cut-out as a
            // 1.35 mm web (the body rib is fused to the partition there, the saddle has to clear it and had nothing behind it)
            let (bx = bay_x0 - 1) translate([bx, bat_cy - 1, z - 1])
                cube([bat_cx - bx, bat_bms[0] / 2 + bat_clear + bat_bms_cut[0] + 1, cradle_t + 2]);
        }
        // stiffening against drops: 45 degree fillets at the saddle roots, rib tying the saddles together behind the battery
        for (i = [0:len(cradle_z) - 1], s = [-1, 1]) if (i > 0 || s > 0) let (z = s > 0 ? cradle_z[i] + cradle_t : cradle_z[i],
                zg = [min(z, z + s * saddle_gusset), max(z, z + s * saddle_gusset)],
                gaps = [[usbc_channel_x(), usbc_channel_z()], [[sw_xz[0] - sw_well_half()[0], sw_xz[0] + sw_well_half()[0]], [sw_xz[1] - sw_well_half()[1], sw_xz[1] + sw_well_half()[1]]], for (q = tie_loop_xz) [[q[0] - tie_loop[0] / 2 - 1, q[0] + tie_loop[0] / 2 + 1], [q[1] - tie_loop[1] / 2 - saddle_gusset, q[1] + tie_loop[1] / 2 + saddle_gusset]]]) difference() {
            along_x(bay_x0 + 0.5, bay_x1 - 0.5) polygon([[y1 + eps, z - s * eps], [y1 - saddle_gusset, z - s * eps], [y1 + eps, z + s * saddle_gusset]]);
            for (g = gaps) if (zg[0] < g[1][1] && zg[1] > g[1][0])   // gaps for the USB-C channel, the switch well and the tie loops (the tie passes along the plate)
                translate([g[0][0], y1 - saddle_gusset - 1, zg[0] - 1]) cube([g[0][1] - g[0][0], saddle_gusset + 2, zg[1] - zg[0] + 2]);
        }
        let (ry = bat_cy + bat_d / 2 + bat_clear + 1) difference() {
            translate([saddle_rib[1] - saddle_rib[0] / 2, ry, cradle_z[0]])
                cube([saddle_rib[0], y1 - ry + eps, cradle_z[len(cradle_z) - 1] + cradle_t - cradle_z[0]]);
            let (zc = cable_notch_z[0], h = saddle_rib_slot[0], d = saddle_rib_slot[1])   // pointed towards the bay: printable
                along_x(saddle_rib[1] - saddle_rib[0], saddle_rib[1] + saddle_rib[0])
                    polygon([[y1 + 1, zc - h / 2], [y1 - d, zc - h / 2], [y1 - d - h / 2, zc], [y1 - d, zc + h / 2], [y1 + 1, zc + h / 2]]);
        }
        sw_funnel(body_d - sw_well[0] - sw_panel, y1 + eps, sw_well[2]);   // box around the switch well, reaching into the bay
        // channel for the USB-C module on the inside, open towards the bay and at the top (wires)
        let (x0 = usbc_xz[0] - usbc[1] / 2 - usbc_cl, z0 = usbc_xz[1] - usbc[2] / 2 - usbc_cl) difference() {
            translate([x0 - usbc_wall, usbc_y0 + 2, z0 - usbc_wall]) cube([usbc[1] + 2 * (usbc_cl + usbc_wall), y1 - usbc_y0 - 2 + eps, usbc[2] + 2 * usbc_cl + usbc_wall]);
            translate([x0, usbc_y0 - 1, z0]) cube([usbc[1] + 2 * usbc_cl, y1 - usbc_y0 + 2, usbc[2] + 2 * usbc_cl + 1]);
        }
        // cable tie loops: a chamfered block with a tunnel along z next to the plate; the tie runs through it round the wires
        for (p = tie_loop_xz) difference() {
            chamfered_box([p[0] - tie_loop[0] / 2, y1 - tie_loop[2], p[1] - tie_loop[1] / 2], [p[0] + tie_loop[0] / 2, y1 + 1, p[1] + tie_loop[1] / 2], 0.8);
            translate([p[0] - tie_loop[3] / 2, y1 - tie_loop[4], p[1] - tie_loop[1] / 2 - 1]) cube([tie_loop[3], tie_loop[4] + eps, tie_loop[1] + 2]);
        }
    }
    along_y(y1 - 1, body_d + 1) intake_slots_back();
    bail_sides() { translate([-1, lip_y0 - 1, bail_floor]) cube([bail_band + 1, body_d - lip_y0 + 2, bail_arm[1] + 1]); bail_step_chamfers(lip_y0 - 1); }   // the bail steps run through
    // power switch: well from outside with 45 degree walls (printable on the back face), hole in its thin floor
    sw_funnel(body_d - sw_well[0], body_d + 1, 0);
    let (h = sw_cut + [1, 1] * 2 * sw_cut_cl)   // the envelope sw_body stays on the datasheet value
        translate([sw_xz[0] - h[0] / 2, body_d - sw_well[0] - sw_panel - 1, sw_xz[1] - h[1] / 2]) cube([h[0], sw_panel + 2, h[1]]);
    // USB-C module: recess from the inside leaves usbc_plate in front of the board, opening for the receptacle
    translate([usbc_xz[0] - usbc[1] / 2 - usbc_cl, y1 - 1, usbc_xz[1] - usbc[2] / 2 - usbc_cl]) cube([usbc[1] + 2 * usbc_cl, 1 + back_t - usbc_plate, usbc[2] + 2 * usbc_cl]);
    usbc_stadium(body_d - usbc_plate - 1, body_d + 1, usbc_cl);
    for (b = back_bosses()) {
        cyl_y(b[0], body_d - head_pocket[1], body_d + 1, head_pocket[0] / 2);   // recessed heads
        cyl_y(b[0], y1 - 1, body_d + 1, screw_clear_d / 2);
    }
}
module back_print_pose() translate([0, 0, body_d]) rotate([-90, 0, 0]) children();   // back face on the bed
module back_install_pose() rotate([90, 0, 0]) translate([0, 0, -body_d]) children();
// QR code in model (x, z) = print (x, y): seen from behind, the viewer's right is -x, so columns run towards -x
// (dark modules grown by 0.05 per side: modules that only touch at a corner overlap instead of meeting in a degenerate point)
module qr_2d() let (m = qr_module, x0 = qr_xz[0] + qr_n * m / 2, z0 = qr_xz[1] + qr_n * m / 2) offset(delta = 0.05)
    for (run = qr_runs) translate([x0 - run[2] * m, z0 - (run[0] + 1) * m]) square([(run[2] - run[1]) * m, m]);
module back_piece(piece)   // multicolour pieces of the back cover in print orientation: white cover, grey QR inlay on the bed
    if (piece == "base") inlay_base() { back_print_pose() back(); qr_2d(); }
    else inlay_piece() { back_print_pose() back(); qr_2d(); }

// ---------- service cover ----------
module cover_panel_2d(inset = 0) translate([cover_y, cover_z]) rrect([cover_w - 2 * inset, cover_hgt - 2 * inset], max(cover_r - inset, 0.5));
module cover_2d(inset = 0) difference() {   // rounded panel below the knob, half-round notch around it in the upper edge
    cover_panel_2d(inset);
    translate([cover_y, pot_yz[1]]) circle(r = cover_notch_r + inset);
}
module cover() {   // glued in: the outer part of its wall rests on the side wall, the inner rim sits in the groove
    x0 = body_w;
    x1 = body_w + cover_out;
    union() {
        difference() {
            intersection() {   // a hull would fill the notch: chamfered convex panel cut to the notched outline
                hull() {
                    along_x(x0, x1 - edge_c) cover_panel_2d();
                    along_x(x1 - eps, x1) cover_panel_2d(edge_c);
                }
                along_x(x0 - 1, x1 + 1) cover_2d();
            }
            along_x(x0 - 1, x1 - cover_t) cover_2d(cover_t);
            translate([x1 - cover_notch_c, cover_y, pot_yz[1]]) rotate([0, 90, 0])   // 45 degree chamfer along the notch at the outer face
                cylinder(r1 = cover_notch_r, r2 = cover_notch_r + cover_notch_c + eps, h = cover_notch_c + eps);
        }
        along_x(x0 - cover_glue[0], x0) difference() {   // shared face at x0 avoids sliver triangles at the interrupted rim
            cover_2d(cover_t - cover_glue[1]);
            cover_2d(cover_t);
        }
    }
}
module cover_print_pose() translate([0, 0, body_w + cover_out]) rotate([0, 90, 0]) children();   // outer face on the bed

// ---------- speed knob ----------
module knob_local() difference() {   // z = 0 at the underside (knob_gap off the wall), top face at knob_len
    union() {
        cylinder(d = knob_d, h = knob_len - knob_c);
        translate([0, 0, knob_len - knob_c - eps]) cylinder(d1 = knob_d, d2 = knob_d - 2 * knob_c, h = knob_c + eps);
    }
    for (i = [0:knob_flutes - 1]) rotate(i * 360 / knob_flutes)   // grip flutes around the dial
        translate([knob_d / 2 - knob_flute[1], -knob_flute[0] / 2, 1]) cube([knob_flute[1] + 1, knob_flute[0], knob_len - knob_c - 1]);
    translate([0, 0, -eps]) cylinder(d = knob_cavity_d, h = knob_sleeve_z + eps);   // over nut and bushing
    difference() {   // ring gap around the clamping sleeve
        translate([0, 0, knob_sleeve_z - eps]) cylinder(d = knob_cavity_d, h = knob_slit[1] + eps);
        translate([0, 0, knob_sleeve_z - 2 * eps]) cylinder(d = knob_stem_d, h = knob_slit[1] + 3 * eps);
    }
    translate([0, 0, knob_sleeve_z - eps]) cylinder(d = pot_shaft_d + 2 * knob_bore_cl, h = knob_bore_top - knob_sleeve_z + eps);
    translate([-knob_slit[0] / 2, -knob_stem_d / 2 - 1, knob_sleeve_z - eps]) cube([knob_slit[0], knob_stem_d + 2, knob_slit[1] + eps]);   // clamping slit
}
module knob() translate([body_w + knob_gap, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) knob_local();
module knob_print_pose() translate([0, 0, knob_len]) mirror([0, 0, 1]) children();   // top face on the bed
module knob_install_pose() translate([body_w + knob_gap, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) mirror([0, 0, 1]) translate([0, 0, -knob_len]) children();
module knob_pointer_2d() translate([knob_d / 2 - knob_c - 9, -0.8]) square([7.5, 1.6]); // white pointer; align on the real shaft at its stop
module knob_piece(piece)   // multicolour pieces in print orientation: grey knob, white pointer inlay in the top face
    if (piece == "base") inlay_base() { knob_print_pose() knob_local(); knob_pointer_2d(); }
    else inlay_piece() { knob_print_pose() knob_local(); knob_pointer_2d(); }
module pot_local(nut = true) {       // z = 0 at the outer face of the right wall
    // housing from 1 mm behind the PCB edge to its shoulder in the wall pocket, on the PCB top; the rest is covered by
    // pwm_board_env(). Local x maps to -world z.
    translate([-pot_housing / 2, -pot_housing / 2, -pot_mount_t - pot_nose_len - 1])
        cube([pot_housing / 2 + pot_axis_h, pot_housing, pot_nose_len + 1]);
    translate([0, 0, -pot_mount_t - eps]) cylinder(d = pot_bush[0], h = pot_bush[1] + eps);
    if (nut) {   // washer on the outer face, nut on top
        cylinder(d = pot_washer[0], h = pot_washer[1]);
        translate([0, 0, pot_washer[1] - eps]) cylinder(d = pot_nut[0], h = pot_nut[1] + eps);
    }
    translate([0, 0, -pot_mount_t + pot_bush[1] - eps]) cylinder(d = pot_shaft_d, h = pot_shaft_free + eps); // knurling/shaft slit simplified as outside envelope
}
module pot_env(nut = true) translate([body_w, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) pot_local(nut);
module pot_nut_env() translate([body_w, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) difference() {
    union() {   // washer on the outer face, nut on top
        cylinder(d = pot_washer[0], h = pot_washer[1]);
        translate([0, 0, pot_washer[1] - eps]) cylinder(d = pot_nut[0], h = pot_nut[1] + eps);
    }
    translate([0, 0, -1]) cylinder(d = pot_bush[0] + 0.1, h = pot_washer[1] + pot_nut[1] + 2);
}
module led_env() {                   // 3 mm LED: body in the pocket, flange on the boss
    cyl_y(led_xz, led_skin + 0.3, led_boss[1], led_d / 2);
    cyl_y(led_xz, led_boss[1], led_boss[1] + 1, 1.9);
}
module usbc_stadium(y0, y1, grow) along_y(y0, y1) translate([usbc_xz[0], usbc_xz[1] - usbc[2] / 2 + usbc_shell_bottom + usbc_shell[1] / 2]) hull()
    for (s = [-1, 1]) translate([s * (usbc_shell[0] - usbc_shell[1]) / 2, 0]) circle(d = usbc_shell[1] + 2 * grow);
// rectangle around the switch frame at the well floor, growing 45 degrees towards the back face; grow = offset for the outer box
module sw_funnel(y0, y1, grow) hull() for (y = [y0, y1]) let (g = grow + sw_well[1] + y - (body_d - sw_well[0]))
    translate([sw_xz[0] - sw_bezel[0] / 2 - g, y, sw_xz[1] - sw_bezel[1] / 2 - g]) cube([sw_bezel[0] + 2 * g, eps, sw_bezel[1] + 2 * g]);
module sw_env() {                  // measured rocker lies horizontal; front/rear depth split remains provisional
    yf = body_d - sw_well[0];
    translate([sw_xz[0] - sw_bezel[0] / 2, yf, sw_xz[1] - sw_bezel[1] / 2]) cube([sw_bezel[0], sw_bezel[2], sw_bezel[1]]);
    translate([sw_xz[0] - sw_bezel[0] / 2 + 1, yf + sw_bezel[2] - eps, sw_xz[1] - sw_bezel[1] / 2 + 1]) cube([sw_bezel[0] - 2, sw_rocker + eps, sw_bezel[1] - 2]);
    translate([sw_xz[0] - sw_body[0] / 2, yf - sw_body[2], sw_xz[1] - sw_body[1] / 2]) cube([sw_body[0], sw_body[2] + eps, sw_body[1]]);
    translate([sw_xz[0] - 4, yf - sw_body[2] - sw_pins, sw_xz[1] - 3]) cube([8, sw_pins + eps, 6]);
}
module usbc_env() {                 // PD trigger: board with parts up to the thinned back cover, receptacle through it
    translate([usbc_xz[0] - usbc[1] / 2, usbc_y0, usbc_xz[1] - usbc[2] / 2]) cube([usbc[1], usbc_board[0], usbc[2]]);
    usbc_stadium(body_d - usbc_protrusion - eps, body_d, 0);
}
module chg_module_env() {            // board upright in the holder, IN end up, parts and heatsinks towards the fan section
    x0 = chg_bx0;
    z0 = chg_bz0;
    translate([x0, chg_y0, z0]) cube([chg_pcb[2], chg_pcb[1], chg_pcb[0]]);
    difference() {   // parts up to the edges, except beside the snap hooks (inductor and diode 0.7-1.0 from the edges there)
        translate([x0 - chg_comp_h, chg_y0, z0]) cube([chg_comp_h + eps, chg_pcb[1], chg_pcb[0]]);
        for (y = [chg_y0 - 1, chg_y0 + chg_pcb[1] - chg_clip[3] - 0.2]) translate([x0 - chg_comp_h - 1, y, z0 + chg_clip[0]])
            cube([chg_comp_h + 1, chg_clip[3] + 1.2, chg_clip[1] - chg_clip[0]]);
    }
    for (i = [0, 1]) translate([x0 - chg_comp_h - chg_sink[2], chg_y0 + (chg_pcb[1] - chg_sink[1]) / 2,
                                z0 + (chg_pcb[0] - 2 * chg_sink[0] - chg_sink[3]) / 2 + i * (chg_sink[0] + chg_sink[3])])
        cube([chg_sink[2] + eps, chg_sink[1], chg_sink[0]]);
}
// user's 14 x 14 x 6 heatsink with its insulating pad over the metal pad behind the IC; wider than the board, over the IN end
module chg_rear_sink_env() let (s = chg_rear_sink)
    translate([chg_bx0 + chg_pcb[2], chg_y0 + (chg_pcb[1] - s[1]) / 2, chg_sink_z0]) cube([s[2] + s[3], s[1], s[0]]);
// holder, printed separately because the housing was already printed: plate glued onto the two housing pads, foot on the housing
// ledge; it grips only the OUT end of the board: a lip under the end between the OUT pads (0.3 behind the part side) with a web
// behind the board, back stops under both long edges, and a jaw beside each edge with a snap hook over the part side. The jaws
// spring 0.6 mm on their free length from the plate; the hooks have a 45 degree lead-in, the board clips in from the front
module chg_holder() let (xs = chg_hx1 - chg_holder[0], w = chg_pcb[1], c = chg_clip, yl = chg_y0 + (w - chg_holder[2]) / 2,
                         z0 = chg_bz0 + c[0], dz = c[1] - c[0], xh = chg_bx0 - c[3] - c[4], ym = chg_y0 + w / 2) {
    translate([xs, chg_y0 - c[4] - c[2], chg_hz0]) cube([chg_holder[0], w + 2 * (c[4] + c[2]), chg_bz0 + c[1] - chg_hz0]);   // plate with the jaw roots
    translate([xs, chg_y0, chg_hz0]) cube([chg_holder[0], w, chg_pads[1][0] + chg_pads[1][1] + 1]);                         // over both pads
    translate([chg_bx0 + chg_ledge[1], yl, chg_hz0]) cube([xs - chg_bx0 - chg_ledge[1] + eps, chg_holder[2], chg_holder[1]]);   // lip
    translate([chg_bx0 + chg_pcb[2] + chg_web_gap, yl, chg_hz0]) cube([xs - chg_bx0 - chg_pcb[2] - chg_web_gap + eps, chg_holder[2], chg_bz0 + c[1] - chg_hz0]);   // web
    for (m = [0, 1]) translate([0, ym, 0]) mirror([0, m, 0]) translate([0, -ym, 0]) {   // one jaw per long edge
        translate([chg_bx0 + chg_pcb[2], chg_y0 + c[5][0], z0]) cube([xs - chg_bx0 - chg_pcb[2] + eps, c[5][1] - c[5][0], dz]);   // back stop under the edge
        translate([xh, chg_y0 - c[4] - c[2], z0]) cube([xs - xh + eps, c[2], dz]);   // jaw, free from the plate
        hull() {   // hook: flat seat on the part side, 45 degree lead-in towards the front
            translate([chg_bx0 - tip, chg_y0 - c[4] - c[2], z0]) cube([tip, c[2] + c[4] + c[3], dz]);
            translate([xh, chg_y0 - c[4] - c[2], z0]) cube([tip, c[2], dz]);
        }
    }
}
module chg_holder_print_pose() rotate([0, 90, 0]) translate([-chg_hx1, chg_clip[2] + chg_clip[4] - chg_y0, -chg_hz0]) children();   // pad face on the bed
module pwm_board_env() {             // board on the rib pads: parts above, solder pins below except along the long edges
    x1 = body_w - wall - pwm_wall_gap;   // PCB edge, in the wall slot
    translate([x1 - pwm_pcb[0], pot_yz[0] - pwm_pcb[1] / 2, shelf_z + shelf_t + pwm_standoff]) {
        cube(pwm_pcb);
        // measured populated height; parts end 1 mm before the wall edge, where only the potentiometer housing continues
        translate([0, 0, pwm_pcb[2] - eps]) cube([pwm_pcb[0] - 1, pwm_pcb[1], pwm_comp_h + eps]);
        translate([0, pwm_edge_free, -pwm_pins]) cube([pwm_pcb[0] - 1, pwm_pcb[1] - 2 * pwm_edge_free, pwm_pins + eps]);   // solder pins
    }
}

// ---------- folding bail (concept of the leoino case) ----------
// L-shaped U bail: its upper legs lie in the side steps and turn on sleeves at mid-depth, the lower legs run down behind the back
// cover to the grip bar below the power switch. Folded = angle 0; carried at bail_carry, where the bar is above the pivot and the
// upper legs rest on the step ramps. Swing it up before removing the back cover.
module bail_sides() { children(); translate([body_w, 0, 0]) mirror([1, 0, 0]) children(); }
// 45 degree chamfers along a left side step from y0 to the back: top edge of the inner wall, side face to step floor
// outline of a side step in (y, z): arc round the eye, ramp, floor to the back; grow = outward offset
// step outline in two convex pieces (a hull of both would slope the floor down to the eye clearance): 0 eye and ramp, 1 floor
module bail_step_profile_2d(grow = 0, piece = 0) offset(delta = grow)
    if (piece == 0) hull() {
        translate([bail_y, bail_z]) circle(r = bail_arm[1] / 2 + bail_cl);
        translate([bail_ramp_y(), body_h + 1]) square([0.2, 1]);
    }
    else translate([bail_y, bail_floor]) square([body_d + 2 - bail_y, bail_arm[1] + 1]);
// chamfer where the step outline leaves the outer surface: for each tangent plane of the rounded top corner (and the flat side face)
// the hull of the outline 1 mm outside the plane grown by bail_c + 1 and the plain outline bail_c inside it; the slabs meet the hull with
// their inner faces, so the flanks are exactly 45 degrees. Tangent planes lie outside the convex corner: no cut goes deeper than bail_c.
module bail_step_edge_chamfer() for (a = [0:15:75], piece = [0, 1]) let (n = [-cos(a), 0, sin(a)], tv = [sin(a), 0, cos(a)],
        p0 = [corner_r * (1 - cos(a)), 0, body_h - corner_r + corner_r * sin(a)], u = a == 0 ? [-30, 2] : [-2, 2],
        m = [[tv[0], 0, -n[0], p0[0]], [0, 1, 0, 0], [tv[2], 0, -n[2], p0[2]], [0, 0, 0, 1]]) hull() {
    intersection() { multmatrix(m) translate([u[0], -1, -1 - tip]) cube([u[1] - u[0], body_d + 2, tip]); along_x(-12, bail_band) bail_step_profile_2d(bail_c + 1, piece); }
    intersection() { multmatrix(m) translate([u[0], -1, bail_c - tip]) cube([u[1] - u[0], body_d + 2, tip]); along_x(-12, bail_band) bail_step_profile_2d(0, piece); }
}
module bail_step_chamfers(y0, top = true) {
    if (top) along_y(y0, body_d + 1) polygon([[bail_band - 1, body_h - bail_c - 1], [bail_band + bail_c + 1, body_h + 1], [bail_band - 1, body_h + 1]]);
    along_y(max(y0, bail_y), body_d + 1) polygon([[-1, bail_floor - bail_c - 1], [bail_c + 1, bail_floor + 1], [-1, bail_floor + 1]]);
}
module chamfered_rect_2d(size, c) polygon([[c, 0], [size[0] - c, 0], [size[0], c], [size[0], size[1] - c], [size[0] - c, size[1]], [c, size[1]], [0, size[1] - c], [0, c]]);
// box from corner a to corner b with all twelve edges chamfered at 45 degrees
module chamfered_box(a, b, c) let (s = b - a) translate(a) hull() {
    translate([c, c, 0]) cube([s[0] - 2 * c, s[1] - 2 * c, s[2]]);
    translate([c, 0, c]) cube([s[0] - 2 * c, s[1], s[2] - 2 * c]);
    translate([0, c, c]) cube([s[0], s[1] - 2 * c, s[2] - 2 * c]);
}
module bail(angle = 0) translate([0, bail_y, bail_z]) rotate([angle, 0, 0]) translate([0, -bail_y, -bail_z]) difference() {
    union() {   // every piece with all edges chamfered, so the outer corners of the joints are chamfered too
        chamfered_box([bail_x[0], bail_leg_y[0], bail_bar_z[0]], [body_w - bail_x[0], bail_leg_y[1], bail_bar_z[1]], bail_c);   // grip bar
        bail_sides() {
            chamfered_box([bail_x[0], bail_y - bail_c, bail_floor], [bail_x[1], bail_leg_y[1], body_h], bail_c);   // upper leg: its front chamfer stays inside the eye, no groove
            chamfered_box([bail_x[0], bail_leg_y[0], bail_bar_z[0]], [bail_x[1], bail_leg_y[1], body_h], bail_c);   // lower leg
            hull() {   // eye with chamfered faces
                cyl_x([bail_y, bail_z], bail_x[0] + bail_c, bail_x[1] - bail_c, bail_arm[1] / 2);
                cyl_x([bail_y, bail_z], bail_x[0], bail_x[1], bail_arm[1] / 2 - bail_c);
            }
        }
    }
    bail_sides() {
        cyl_x([bail_y, bail_z], bail_x[0] - 1, bail_x[1] + 1, bail_bush[0] / 2);                 // bore for the pressed-in bushing
        // outer part of the arm cut back round the eye for flange and screw head: a straight cut ending bail_head_room behind the axis
        // (a round cut wider than the arm left knife edges, user); its outer edges chamfered, inner corners left square
        bail_head_cut(0);
        bail_head_chamfer();
    }
}
// the head cut-out of the left arm (right one mirrored by bail_sides), grown by g for the chamfer hulls
module bail_head_cut(g) let (h = bail_arm[1] / 2) translate([bail_x[0] - 3 - g, bail_y - h - 3 - g, bail_z - h - 3 - g])
    cube([bail_eye_x[0] + g - (bail_x[0] - 3 - g), bail_y + bail_head_room + g - (bail_y - h - 3 - g), 2 * (h + 3 + g)]);
// 45 degree chamfers of the cut-out edges: one hull per tangent plane of the arm surface (eye cylinder in 15 degree steps, flat top
// and bottom, outer face); both slabs touch the hull with their deeper face, the cut grown by bail_c + 1 gives mitred inner corners
module bail_head_chamfer() let (h = bail_arm[1] / 2, c = bail_c, r = bail_head_room + 5) {
    for (a = [0:15:180]) let (n = [0, -sin(a), cos(a)], tv = [0, cos(a), sin(a)], p0 = [0, bail_y - h * sin(a), bail_z + h * cos(a)],
            u = a == 0 ? [-3, r] : a == 180 ? [-r, 3] : [-2, 2],
            m = [[1, 0, -n[0], p0[0]], [0, tv[1], -n[1], p0[1]], [0, tv[2], -n[2], p0[2]], [0, 0, 0, 1]])
        bail_plane_chamfer(m, [bail_x[0] - 3, bail_eye_x[0] + 5], u);
    bail_plane_chamfer([[0, 0, 1, bail_x[0]], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]], [bail_y - h - 3, bail_y + r], [bail_z - h - 1, bail_z + h + 1]);
}
module bail_plane_chamfer(m, s, u) hull() {
    intersection() { multmatrix(m) translate([s[0], u[0], -1 - tip]) cube([s[1] - s[0], u[1] - u[0], tip]); bail_head_cut(bail_c + 1); }
    intersection() { multmatrix(m) translate([s[0], u[0], bail_c - tip]) cube([s[1] - s[0], u[1] - u[0], tip]); bail_head_cut(0); }
}
module bail_print_pose() translate([0, 0, bail_leg_y[1]]) rotate([-90, 0, 0]) children();   // back faces of lower legs and bar on the bed

// ---------- bought parts: envelopes for the checks ----------
module fan_env() {                  // frame block plus the silicone corner pads on both faces
    translate([fan_cx - fan_size / 2, fan_y, fan_cz - fan_size / 2]) cube([fan_size, fan_t, fan_size]);
    for (sx = [-1, 1], sz = [-1, 1], y = [fan_y - fan_pad, fan_y + fan_t - eps]) translate([fan_cx, 0, fan_cz]) scale([sx, 1, sz])
        along_y(y, y + fan_pad + eps) let (e = fan_size / 2 + fan_pad_side) polygon([[fan_pad_leg, fan_size / 2 - 1], [e, fan_pad_leg - 1], [e, e], [fan_pad_leg - 1, e]]);
}
module fan_visual() translate([fan_cx, fan_y, fan_cz]) rotate([-90, 0, 0]) {   // local z along +y
    difference() {
        translate([-fan_size / 2, -fan_size / 2, 0]) cube([fan_size, fan_size, fan_t]);
        translate([0, 0, -1]) cylinder(d = fan_blade_d + 2, h = fan_t + 2);
        for (sx = [-1, 1], sy = [-1, 1]) translate([sx * fan_pitch / 2, sy * fan_pitch / 2, -1]) cylinder(d = fan_hole_d, h = fan_t + 2);
    }
    let (s = fan_size / 120, hub = 20 * s) {   // placeholder hub, blades and struts scaled from the 120 mm look
        cylinder(r = hub, h = fan_t - 3);
        for (i = [0:6]) rotate(i * 360 / 7) translate([hub - 1, 0, 11]) rotate([40, 0, 0]) translate([0, -9 * s, -0.75]) cube([fan_blade_d / 2 - hub - 1, 18 * s, 1.5]);
        for (i = [0:3]) rotate(45 + i * 90) translate([hub - 2, -1.5, fan_t - 3]) cube([fan_size / 2 * sqrt(2) - hub - 3 * s, 3, 3]);
    }
}
module battery_env() translate([bat_cx, bat_cy, wall]) {
    cylinder(d = bat_d, h = bat_l);
    translate([-bat_d / 2 - bat_bms[1], -bat_bms[0] / 2, 0]) cube([bat_bms[1] + bat_d / 4, bat_bms[0], bat_l]);   // BMS board
}

// Local +z = screw direction, z = 0 at the surface under the head. socket = hex key recess for the viewer,
// the checks use the plain envelope.
module foot() difference() {   // local: x centred, y from the front end, z = 0 at the housing bottom
    hull() {
        translate([-foot_w / 2 + foot_c, foot_c, -foot_lift]) cube([foot_w - 2 * foot_c, foot_len - 2 * foot_c, eps]);
        translate([-foot_w / 2, 0, -foot_lift + foot_c]) cube([foot_w, foot_len, foot_lift - foot_c]);
        translate([-foot_w / 2, foot_key, foot_key - eps]) cube([foot_w, foot_len - 2 * foot_key, eps]);
    }
    for (dy = [-1, 1]) translate([0, foot_len / 2 + dy * foot_screw_dy, -foot_lift - 1]) {
        cylinder(d = screw_clear_d, h = foot_lift + foot_key + 2);
        cylinder(d = head_pocket[0], h = 1 + foot_head_recess + screw_head_h);
    }
}
module place_feet() for (fx = foot_x()) translate([fx, foot_y0, 0]) foot();
module foot_print_pose() translate([0, 0, foot_lift]) children();   // ground face on the bed

module screw(len, socket = false) difference() {   // ISO 7380 button head, head above z = 0
    union() {
        translate([0, 0, -screw_head_h]) cylinder(d = screw_head_d, h = screw_head_h);
        translate([0, 0, -screw_head_h]) cylinder(r = 1.5, h = len + screw_head_h);
    }
    if (socket) translate([0, 0, -screw_head_h - eps]) cylinder(d = 2.5 / cos(30), h = 1, $fn = 6);   // drive recess, viewer only
}
module screws_fan(socket = false) for (p = fan_holes()) translate([p[0], fan_y + fan_t + fan_pad, p[1]]) orient([0, -1, 0]) screw(len_fan, socket);
module screws_back(socket = false) for (b = back_bosses()) translate([b[0][0], body_d - head_pocket[1], b[0][1]]) orient([0, -1, 0]) screw(len_back, socket);
module screws_feet(socket = false) for (p = foot_screws()) translate([p[0], p[1], -foot_lift + foot_head_recess + screw_head_h]) orient([0, 0, 1]) screw(len_foot, socket);
module screws_bail(socket = false) bail_sides() let (xh = bail_band - bail_screw[3]) {   // M4 shoulder screw and flanged bushing (bought)
    cyl_x([bail_y, bail_z], xh - bail_screw[1], xh, bail_screw[0] / 2);                      // head
    cyl_x([bail_y, bail_z], xh - eps, bail_band, bail_screw[2] / 2);                         // shoulder, clamped against the step wall
    cyl_x([bail_y, bail_z], bail_band - eps, bail_band + bail_screw[4], 2);                  // thread in the insert
    cyl_x([bail_y, bail_z], xh, xh + bail_bush[2], bail_bush[1] / 2);                        // bushing flange
    cyl_x([bail_y, bail_z], xh + bail_bush[2] - eps, xh + bail_bush[3], bail_bush[0] / 2 - 0.1);    // bushing, pressed into the eye (0.1 under the bore: facets of the rotated swing samples)
}

module assembly(explode = 0, bail_angle = 0) {
    body_install_pose() {
        color("#f2f2ee") body_piece("base");
        color("#8f9396") body_piece("label");
        color("#8f9396") body_piece("dedication");
        color("#8f9396") body_piece("grille");
    }
    translate([0, 2 * explode, 0]) back_install_pose() { color("#f2f2ee") back_piece("base"); color("#8f9396") back_piece("qr"); }
    color("#8f9396") translate([explode, 0, 0]) cover();
    color("#8f9396") translate([0, 0, explode]) bail(bail_angle);
    color("#26282b") translate([0, 0, explode]) screws_bail(true);
    color("#222326") translate([0, 0, -explode / 2]) place_feet();
    color("#26282b") translate([0, 0, -explode]) screws_feet(true);
    translate([2 * explode, 0, 0]) { color("#8f9396") knob_install_pose() knob_piece("base"); color("#ffffff") knob_install_pose() knob_piece("pointer"); }
    color("#3a3d41") translate([explode, 0, 0]) pot_env();
    color("#2e6b3f") translate([explode, 0, 0]) pwm_board_env();
    color("#8f9396") translate([0, explode, 0]) chg_holder();
    color("#c9c9c9") translate([0, explode, 0]) chg_module_env();
    color("#b8bcc2") translate([0, explode, 0]) chg_rear_sink_env();
    color("#4b2a7a") translate([0, 2 * explode, 0]) usbc_env();
    color("#1b1b1b") translate([0, 2.5 * explode, 0]) sw_env();
    color("#303236") translate([0, explode, 0]) fan_visual();
    color("#3f7fbf") translate([0, explode / 2, 0]) battery_env();
}

// ---------- fit tests: slices of the real parts, printed before the full build ----------
module slice_box(lo, hi) intersection() { children(); translate(lo) cube(hi - lo); }
// body and back cover slices keep the print orientation of their part (same hole shapes and layer direction), moved to the origin
module test_body_slice(lo, hi) translate([-lo[0], hi[2], 0]) body_print_pose() slice_box(lo, hi) body();
module test_back_slice(lo, hi) translate([-lo[0], -lo[2], 0]) back_print_pose() slice_box(lo, hi) back();
// upper right section of the housing, from the electronics shelf up (partition to right wall: shelf with the PWM supports, potentiometer
// pocket, upper service cover groove, LED boss, right bail pivot) and the matching part of the back cover (hold-down plate, switch well);
// battery holder and USB-C socket below were already confirmed in print; light slicer settings keep it cheap
module test_right() test_body_slice([part_x, -1, shelf_z], [body_w + 1, body_d + 1, body_h + 1]);
module test_right_back() test_back_slice([part_x, -1, shelf_z], [body_w + 1, body_d + 1, body_h + 1]);

// ---------- branches: the tools check that print_project.py PARTS matches them ----------
if      (part == "assembly") assembly();
else if (part == "exploded") assembly(40);
else if (part == "metrics") echo("PROJECT_METRICS", [
    ["wall", wall], ["front_t", front_t], ["back_t", back_t], ["corner_r", corner_r], ["body_mm", [body_w, body_d, body_h]],
    ["fan_size", fan_size], ["fan_pad", fan_pad], ["fan_t", fan_t], ["fan_pitch", fan_pitch], ["fan_hole_d", fan_hole_d],
    ["fan_blade_d", fan_blade_d], ["pot_shaft_len", pot_shaft_tip], ["pot_shaft_d", pot_shaft_d], ["pot_shaft_free", pot_shaft_free], ["pot_bush", pot_bush], ["pot_mount_t", pot_mount_t], ["pwm_total_h", pwm_total_h], ["pwm_total_len", pwm_total_len], ["pwm_pcb", pwm_pcb], ["pot_axis_h", pot_axis_h], ["pwm_lift", pwm_pins + pwm_pin_cl + 0.5], ["knob_shaft_engagement", pot_shaft_tip - knob_gap - knob_sleeve_z], ["knob_top_skin", knob_len - knob_bore_top], ["knob_protrusion", knob_gap + knob_len - cover_out], ["bail_clearance", bail_room()], ["bail_carry", bail_carry], ["bail_grip", body_w - 2 * (bail_cl + bail_arm[0])], ["bail_insert", m4_insert], ["foot_clearance", foot_cl], ["dedication_lines", len(dedication)], ["foot_lift", foot_lift], ["fan_axis", [fan_cx, fan_cz]], ["fan_y", fan_y], ["shroud_r", [open_r, open_r + shroud_t]], ["shroud_gap", shroud_gap], ["open_d", 2 * open_r], ["grille_gap", grille_gap],
    ["bat_mm", [bat_d, bat_l]], ["bat_bms", bat_bms], ["bat_clear", bat_clear], ["saddle_gap", saddle_gap], ["cradle_rings", len(cradle_z)], ["shelf_gap", shelf_gap],
    ["lip_clearance", lip_cl],
    ["usbc_board_mm", usbc_board], ["usbc_protrusion", usbc_protrusion], ["usbc_total_mm", usbc], ["usbc_plate", usbc_plate], ["usbc_clearance", usbc_cl],
    ["usbc_shell_mm", usbc_shell], ["usbc_shell_bottom_approx", usbc_shell_bottom],
    ["chg_pcb_mm", chg_pcb], ["chg_total_h", chg_total_h], ["fan_side_shift", fan_side_shift],
    ["insert_hole_d", insert_hole_d], ["insert_w_min", insert_w_min], ["mount_insert", mount_insert], ["mount_floor", mount_floor], ["insert_len", insert_len], ["insert_depth", insert_depth],
    ["screws", screw_table],
    // insert pockets: [assembly body, opening point, direction into the material, depth]
    ["inserts", concat(
        [for (p = fan_holes()) ["body", [p[0], fan_y - fan_pad, p[1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (b = back_bosses()) ["body", [b[0][0], body_d - back_t, b[0][1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (s = [0, 1]) ["body", [s ? body_w - bail_band : bail_band, bail_y, bail_z], [s ? -1 : 1, 0, 0], m4_insert[1] + 1, m4_insert[0], m4_insert[2]]],
        [for (p = foot_screws()) ["body", [p[0], p[1], foot_key], [0, 0, 1], insert_depth, insert_hole_d, insert_w_min]],
        [["body", [mount_xy[0], mount_xy[1], 0], [0, 0, 1], mount_insert[1] + 1, mount_insert[0], mount_insert[2]]])]]);
else if (part == "none") {}
else if (part == "body") body_print_pose() body();
else if (part == "body_base") body_piece("base");
else if (part == "body_label") body_piece("label");
else if (part == "body_dedication") body_piece("dedication");
else if (part == "body_grille") body_piece("grille");
else if (part == "back") back_print_pose() back();
else if (part == "back_base") back_piece("base");
else if (part == "back_qr") back_piece("qr");
else if (part == "cover") cover_print_pose() cover();
else if (part == "bail") bail_print_pose() bail();
else if (part == "knob") knob_print_pose() knob_local();
else if (part == "knob_base") knob_piece("base");
else if (part == "knob_pointer") knob_piece("pointer");
else if (part == "foot") foot_print_pose() foot();
else if (part == "chg_holder") chg_holder_print_pose() chg_holder();
else if (part == "test_right") test_right();
else if (part == "test_right_back") test_right_back();
