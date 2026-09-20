// LEO-AC1: battery fan styled like the outdoor unit of an air conditioner, 120 mm PC fan,
// 3.2 V 6000 mAh LiFePO4 pack. Skill openscad-print-project. Units mm, Z up.
// Installed frame: x = width (left to right seen from the front), y = depth (front face at y = 0,
// back face at y = body_d), z = height (underside of the body at z = 0).
// Modules build every part in its INSTALLED position; the part branches at the end put each print
// part into PRINT orientation (largest flat face on the bed at z = 0). The tools set `part`.

part = "assembly";   // print part, "body_base" / "body_label" / "body_dedication", "assembly", "exploded", "metrics", "none"
$fa = 2;
$fs = 0.6;
eps = 0.01;

/* [Body] */
body_w = 225;        // outer width (x); proportions of an 800 x 550 x 285 mm outdoor unit
body_h = 155;        // outer height (z)
body_d = 80;         // outer depth (y) without grille and service cover
wall = 3.2;          // side, top and bottom walls, eight 0.4 mm lines (drop resistance)
front_t = 3.2;       // front plate
corner_r = 6;        // corner radius seen from the front, spreads the load of a drop on a corner
edge_c = 1.5;        // 45 degree chamfer on the bed edges (front of the body, back of the cover)
part_x = 150;        // left face of the partition between fan section and electronics bay
part_t = 2.4;
inner_c = 4;         // 45 degree fillet between front plate and walls (stiffness, printable)

/* [Fan: Noctua NF-F12 industrialPPC-2000 PWM, 120 x 25 mm, 12 V, max. 1.2 W] */
fan_size = 120;
fan_t = 25;
fan_pitch = 105;     // mounting hole spacing
fan_hole_d = 4.3;
fan_blade_d = 116;   // swept blade diameter (typical)
fan_cx = 84;         // fan axis x
fan_cz = body_h / 2; // fan axis z
fan_standoff = 8;    // bosses between front plate and fan frame
fan_boss_d = 9;
fan_pad = 1;         // silicone corner pads, proud of both frame faces (Noctua CAD NF-F12 industrialPPC)
fan_pad_leg = 35.2;  // pads cover the corner triangle (fan_size/2, leg) - (fan_size/2, fan_size/2) - (leg, fan_size/2) (CAD)
shroud_t = 3.2;      // round duct front plate -> fan frame, bore = grille opening: air leaves only through the grille
shroud_gap = 0.2;    // duct end to the fan frame face

/* [Grille] */
open_r = 59;         // opening in the front plate
grille_r = 68;       // outer radius of the grille ring
grille_t = 4;        // ring in front of the front plate, first contact in a drop on the front
grille_depth = 3;    // bars reach this far behind the front face
spigot_t = 2;        // locating collar inside the opening
spigot_w = 2.2;
spigot_cl = 0.3;     // radial clearance of the collar
grille_bar = 2.4;    // ring and spoke width
grille_hub_r = 8;
grille_rings = 6;
grille_spokes = 8;
grille_screw_r = 63.5;
grille_screw_a0 = 22.5;  // screw angles between the spokes
grille_boss_d = 8.4;
grille_boss_h = 7.2; // behind the front plate, stays below fan_standoff

/* [Back cover] */
back_t = 4;          // screw heads recessed 1.9 mm, 2.1 mm below
lip_h = 4;           // lip reaching into the body
lip_t = 3;
lip_cl = 0.25;       // clearance per side between lip and body wall
back_boss_d = 10;    // back cover bosses: 3 mm of material around the Ruthex hole (datasheet 1.6)
boss_inset = 6.5;    // back bosses: axis distance from the outer edges
back_boss_len = 16;  // solid column behind the insert
gusset = 20;         // cone below the back bosses into the wall corner (print orientation), flatter than 45 degrees
slot_w = 1.6;        // intake slots, back and left side
slot_pitch = 3.2;
back_bar_x = 80;     // extra vertical bar through the back intake slots

/* [Battery, 3.2 V 6000 mAh LiFePO4 pack] */
bat_d = 32.5;        // measured cell body, excluding the separate protection board, 2026-09-15
bat_bms = [20, 4];   // BMS board on one side, facing the partition (-x): width approx. 20 over the full length (y) and thickness (x) measured
bat_bms_cut = [2, 1];         // extra room around the BMS board in the cradle rings and saddles: per side across (y), in depth (x)
bat_l = 71.6;        // measured cell-body length; cable end up, through the shelf slot
cable_slot_w = 10;   // slot in the shelf above the battery, open towards the back
bat_cx = 180;
bat_clear = 0.5;     // radial clearance in the cradle
bat_front_gap = 4.5; // front plate to battery, clears the inner fillet
// three closed rings around the battery for drops: front half as ribs in the body, back half as saddles on the back cover
cradle_z = [14, 28, 56];  // lower faces of the rings, clear of the corner bosses (z <= 10.5) and the cover bosses (z 34-42)
cradle_t = 4;
saddle_gap = 0.3;    // rib end to saddle along y
saddle_gusset = 6;            // 45 degree fillets between the back cover and the battery saddles (not below the lowest: back bosses)
saddle_rib = [3, 180];         // rib across the three saddles behind the battery: thickness, x position
saddle_rib_slot = [12, 12];    // wire passage through the rib at the lower cable notch: height, depth from the back cover (pointed end)
shelf_gap = 3;       // battery top to electronics shelf (cable, protection board)
shelf_t = 4;         // stops the battery when the unit falls on its top
shelf_fillet = 3;    // 45 degree fillets along its joints with partition and right wall, above and below
shelf_hold = [5, 3, 0.2];  // hold-down plate on the back cover over the free shelf edge: overlap (y), thickness, gap
shelf_d = 60;        // shelf depth from the front plate, carries the PWM board

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
pot_housing = 13;          // potentiometer housing on the PCB edge: square envelope (12 mm pot assumed)
pot_recess_r = 10;         // round pocket from inside around the axis: the housing reaches into the wall, shoulder on the pocket floor
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
chg_pcb = [32.2, 11, 1.6];     // measured length/width 2026-09-15; PCB thickness remains assumed (board stands with its long axis along z)
chg_total_h = 3.7;             // measured total board height including components; back confirmed clear
chg_comp_h = chg_total_h - chg_pcb[2]; // height above the assumed PCB thickness
chg_sink = [8.8, 8.8, 5, 6];   // planned clearance envelopes only: no heatsinks bought/measured yet; y, z, height, gap
cable_notch = [15, 12];        // cable notches at the back edge of the partition: length (y), height
cable_notch_z = [44, 126];     // centres: low (USB-C wires, between two battery saddles) and high (fan cable)
chg_gap = 4.5;                 // board back to partition: pads plus tape; board and heatsinks further in the intake air, but the ledge under
                               // the board must stay beside the fan frame, otherwise the fan cannot be pulled out towards the back
chg_tape = 1.1;                // double-sided tape between board and pads (3M VHB 1.1 mm); thinner tape moves the board further onto the ledge
chg_fan_gap = 5;               // free space from the fan's back pads to the front edge of the upright board (intake air)
// solder pads (IN, B, O) and parts reach the long edges: no grooves. The board back sits on two pads with heat-resistant
// double-sided tape, its lower edge on a ledge that stays behind the part side.
chg_pads = [[4, 7], [chg_pcb[0] - 4 - 7, 7]]; // supports from the board's lower end: start, height; keep 4 mm free at both ends
chg_ledge = [2, 0.3];          // ledge under the lower board edge: height, set back from the part side

/* [Folding bail on top: concept of the leoino case, a flat U bail in a step of the top edge, pivots at mid-depth] */
bail_bar = [13, 9];         // grip bar when folded: width along y, height (z); as high as the arms
bail_arm = [8.8, 9];        // arms: width (x), height (z)
bail_eye = 12;              // eye around the pivot: diameter (top flush with the top face)
bail_rim = corner_r;        // side-wall rim outside the arm pockets: keeps the rounded top edges
bail_cl = 0.5;              // clearance of the bail in its pockets
bail_front = 1;             // folded bar: gap to the front face
bail_y = body_d / 2;        // pivot axis at mid-depth: the fan hangs level (user; costs finger room, about 20 mm)
bail_sleeve = [7, 4.2];     // pivot sleeve as on the leoino bail (bought tube): outside diameter, minimum bore; the eye turns on it
bail_eye_cl = 0.15;         // radial clearance of the eye on the sleeve
bail_cb = [9, 2.5];         // counterbore for the M4 head in the outer arm face: diameter, depth
bail_c = 1;                 // 45 degree chamfers on the bar and arm edges
bail_access_d = 9.5;        // hole through the rim for the screw head and the insert tool
m4_insert = [5.6, 8.1, 2.2];   // Ruthex RX-M4x8.1: hole (as in the leoino case), length, minimum wall (check against the datasheet)
m4_head = [7.6, 2.2];       // ISO 7380 M4 button head: diameter, height

/* [USB-C charging socket: PD trigger module (Type A, pads 1-4 open = 5 V) in the back cover] */
usbc_board = [12.88, 10.35, 4.30]; // measured 2026-09-15: length without the projecting receptacle (y), width (x), height incl. components (z)
usbc_protrusion = 1.5;       // measured receptacle projection beyond the front PCB edge
usbc = [usbc_board[0] + usbc_protrusion, usbc_board[1], usbc_board[2]]; // total module envelope: 14.38 x 10.35 x 4.30
usbc_shell = [8.9, 3.22];    // measured receptacle shell width and height, 2026-09-15
usbc_shell_bottom = 1.1;     // approximately measured from module underside to shell underside; 1.1 + 3.22 ~= 4.30 overall
usbc_plate = usbc_protrusion; // local cover thickness: PCB edge rests inside, receptacle face flush outside
usbc_xz = [205, 44];         // module envelope centre: low right between two battery saddles; shell axis is offset upwards by its measured height
usbc_cl = 0.2;               // clearance in channel, plate opening and to the stop
usbc_wall = 2;               // channel on the inside of the back cover: side walls and floor, open at the top for the wires
usbc_stop = [4, 6];          // stop on the right wall behind the module end (takes the plug force with the back cover on): thickness, height
                             // (reaches below the module, the wires leave its end at the top)

/* [Power switch: measured 14.7 x 20.9 mm rocker, snap-in, in a well of the back cover] */
sw_xz = [201, 124];          // above the PWM module, below the top wall with the 8 mm well
sw_cut = [19.2, 12.2];       // measured required panel hole; long side horizontal
sw_bezel = [20.9, 14.7, 2];  // measured outside width/height and bezel thickness
sw_rocker = 5;               // measured rocker rise above the bezel
sw_body = [sw_cut[0] - 0.2, sw_cut[1] - 0.2, 11]; // conservative body below the hole; depth still assumed
sw_total_depth = 23;         // measured overall depth including contacts
sw_pins = sw_total_depth - sw_bezel[2] - sw_rocker - sw_body[2]; // inferred from the provisional front/body depth split
sw_panel = 1.5;              // user-confirmed approximate panel thickness for the snap clips
sw_well = [8, 0.2, 2.2];     // well: panel below the back face (frame and rocker stay inside when the fan lies on its back), floor margin around the frame (small: short overhang, no support),
                             // wall measured horizontally (2.2 = 1.56 mm across the 45 degree flank)

/* [Feet: TPU strips, each screwed with two M3 x 8 from below into Ruthex inserts] */
foot_w = 16;          // width (x)
foot_len = 62;        // length (y), ends before the back lip
foot_y0 = 8;          // front end of the feet
foot_lift = 4.5;      // housing above the ground
foot_key = 1;         // the foot top sits this deep in a pocket of the bottom wall and takes the shear
foot_c = 1;           // 45 degree chamfers: ground edges all around, top ends (match the pocket ends)
foot_cl = 0.2;        // clearance of the TPU in the pocket, per side
foot_inset = 17;      // foot axis from the side faces
foot_screw_dy = 22;   // screw axes from the foot centre along y
foot_head_recess = 1.2;   // screw heads below the ground face
foot_boss_d = 9;      // bosses inside the bottom wall for the inserts, pressed in from outside

/* [Mount insert in the underside, like a camera thread] */
mount_xy = [121, 36];      // near the centre of mass (fan left, battery right)
// Ruthex RX-M5x9.5 (datasheet RX series 08/2022): outer 7.1 / 6.3, length 9.5, hole 6.4, min. wall 2.6, blind hole >= L + 1
mount_insert = [6.4, 9.5, 2.6];   // hole diameter, insert length, minimum wall around the hole
mount_floor = 2.5;         // above the blind hole: the weight on a mount pushes the insert against it
mount_boss_d = 15;         // 4.3 mm wall: solid with 6 wall loops (2.4 mm from each side) instead of infill
mount_rib = [2.4, 20];     // rib from the boss towards the back (a vertical wall in print): thickness, length
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
head_pocket = [6.4, 1.9];  // head recess in the grille ring: diameter, depth
len_grille = 12;     // M3 x 12, from the front, head recessed in the grille ring
len_fan = 30;        // M3 x 30, from behind the fan (not in the nas-case set)
len_back = 8;        // M3 x 8, from the back, head on the surface
len_bail = 12;       // M4 x 12, bail pivots: through the sleeve into the insert (user's set)
len_foot = 8;        // M3 x 8, from below through the TPU feet

/* [Decor] */
inlay_t = 0.6;       // multicolour inlay depth: the first three 0.2 mm layers
brand = "LEO";             // big stencil letters, as wide as the second line
brand_sub = "INDUSTRIES";  // second line, sets the block width
brand_model = "AC-1";      // third line
logo_cx = 189.5;           // centre of the left-aligned block, front view x (right of the grille)
logo_top = 144;            // top of the big letters, front view z
line_gap = 3;
big_size = [13, 18];       // letter box
big_stroke = 3;
sub_size = [4, 6];
sub_stroke = 1.2;          // >= 3 lines, also the gaps inside A, E and S
sub_gap = 1.5;
stencil_gap = 1.2;         // bridges in the big letters
groove_count = 14;         // decorative grooves right of the grille, as on Mitsubishi outdoor units
groove_pitch = 6;
groove_w = 1.2;
groove_depth = 0.8;        // open to the bed in print
groove_z0 = 19;            // axis of the lowest groove
groove_x = [160, 219];
led_d = 3;                 // 3 mm breathing LED as charge indicator, glued in from inside; shines through the white PETG in the counter of the O
led_skin = 0.8;            // white PETG left in front of the LED (four layers)
led_boss = [7, 5.8];       // boss around the LED pocket: diameter, height from the front face; the LED flange rests on it
dedication = ["Für Leo", "von Papa", "14.09.2026"];   // raised on the inside of the front plate, readable from behind with the back cover off
dedication_font = "Liberation Sans:style=Bold";   // bundled with OpenSCAD
dedication_size = [6, 6, 4];     // per line, the date smaller; fits between the PWM module (with plugged connector) and the bail recess
dedication_w = [30, 38, 28];     // measured line widths (incl. bold) for the LED boss and bay checks
dedication_x = 182;              // centre of the lines, left of the LED boss
dedication_bold = 0.15;    // extra stroke per side: thin joints of the font reach two lines (0.8 mm) in grey
dedication_h = 0.8;        // raised height (four layers)
dedication_z = [131.7, 124.2, 116.8];   // baselines above the PWM module; glyphs measured per line, line gaps checked on the grey inlay

// ---------- derived values ----------
pot_nose_len = pwm_total_len - pwm_pcb[0] - pot_shaft_free - pot_bush[1]; // housing shoulder ahead of the PCB edge
pwm_wall_gap = pot_mount_t + pot_nose_len - wall; // PCB edge to the inner wall face; negative: the edge reaches into the wall slot
pot_recess = wall - pot_mount_t;                  // depth of the round housing pocket from inside
pwm_pcb_slot = max(0, -pwm_wall_gap) + pot_pcb_cl;  // depth of the shallow slot for the PCB edge
pot_shaft_tip = pot_shaft_free + pot_bush[1] - pot_mount_t; // shaft tip relative to the outer wall
function pwm_rib_x() = let (x1 = body_w - wall - pwm_wall_gap) [x1 - pwm_pcb[0] + 0.3, x1 - 1 - pwm_rib];   // under both board ends
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
bat_cy = front_t + bat_front_gap + bat_d / 2;         // battery axis y
shelf_z = wall + bat_l + shelf_gap;
bay_x0 = part_x + part_t;
bay_x1 = body_w - wall;
lip_y0 = body_d - back_t - lip_h;
part_y1 = lip_y0 - lip_cl;
ring_in = open_r - spigot_cl - spigot_w;              // inner radius of ring and collar
grille_gap = (ring_in - grille_hub_r - grille_rings * grille_bar) / (grille_rings + 1);
function grille_screws() = [for (i = [0:3]) let (a = grille_screw_a0 + 90 * i)
    [fan_cx + grille_screw_r * cos(a), fan_cz + grille_screw_r * sin(a)]];
function fan_holes() = [for (sx = [-1, 1], sz = [-1, 1]) [fan_cx + sx * fan_pitch / 2, fan_cz + sz * fan_pitch / 2]];
// back bosses: [axis (x, z), footprint rectangle corner a, corner b, gusset tip corner a, corner b]
function back_bosses() = concat(
    [for (sx = [0, 1], sz = [0, 1]) let (
        c = [sx ? body_w - boss_inset : boss_inset, sz ? body_h - boss_inset : boss_inset],
        w = [sx ? body_w - wall + 1 : wall - 1, sz ? body_h - wall + 1 : wall - 1],
        t = [sx ? body_w - wall : wall, sz ? body_h - wall : wall])
     [c, w, c, w, t]],
    [for (sz = [0, 1]) let (
        c = [part_x + part_t / 2, sz ? body_h - boss_inset : boss_inset],
        w = [part_x, sz ? body_h - wall + 1 : wall - 1],
        t = [part_x + part_t, sz ? body_h - wall : wall])
     [c, w, [part_x + part_t, c[1]], w, t]]);
bail_z = body_h - bail_eye / 2;                        // pivot axis height
bail_floor = body_h - bail_arm[1];                     // floor of the bar recess and the arm pockets
bail_x = [bail_rim + bail_cl, bail_rim + bail_cl + bail_arm[0]];   // left arm: outer and inner face (right arm mirrored)
bail_pocket_x = [bail_rim, bail_rim + bail_arm[0] + 2 * bail_cl];  // left arm pocket; its inner face carries the M4 insert
bail_bar_y = [bail_front, bail_front + bail_bar[0]];   // folded bar along y
function bail_sleeve_len() = bail_pocket_x[1] - (bail_x[0] + bail_cb[1]) + 0.1;   // insert face to the screw head, which stays 0.1 mm off the counterbore floor
usbc_y0 = body_d - usbc[0];                             // inner end of the module, in the bay
function foot_x() = [foot_inset, body_w - foot_inset];
function foot_screws() = [for (fx = foot_x(), dy = [-1, 1]) [fx, foot_y0 + foot_len / 2 + dy * foot_screw_dy]];
foot_doubler_hw = foot_w / 2 + foot_cl + 1.2;        // half width of the floor doubler over a foot pocket
foot_boss_top = foot_key + insert_depth + 1.5;       // closed boss top above the insert pocket
foot_screw_skin = foot_key + foot_lift - foot_head_recess - screw_head_h;   // TPU under the head: head face to insert mouth
// thread engagement in the insert and margin of the screw tip to the pocket end
screw_table = [
    // name, length, engagement, tip margin
    ["grille", len_grille, (-grille_t + head_pocket[1] + len_grille) - (front_t + grille_boss_h - insert_len),
     (front_t + grille_boss_h) - (-grille_t + head_pocket[1] + len_grille)],
    ["fan", len_fan, (fan_y - fan_pad) - max(fan_y + fan_t + fan_pad - len_fan, fan_y - fan_pad - insert_len),
     (fan_y + fan_t + fan_pad - len_fan) - (fan_y - fan_pad - insert_depth)],
    ["back", len_back, (body_d - back_t) - max(body_d - head_pocket[1] - len_back, body_d - back_t - insert_len),
     (body_d - head_pocket[1] - len_back) - (body_d - back_t - insert_depth)],
    ["bail", len_bail, min(len_bail - bail_sleeve_len(), m4_insert[1]), m4_insert[1] + 1 - (len_bail - bail_sleeve_len())],
    ["feet", len_foot, min(len_foot - foot_screw_skin, insert_len), insert_depth - (len_foot - foot_screw_skin)]];

assert(wall >= 3.2 && front_t >= 3.2 && back_t >= 3 && corner_r >= 5, "Drop resistance: walls >= 3.2 mm (back 3 mm), corner radius >= 5 mm");
// heat-set inserts need material between pocket and visible face, otherwise the face deforms when pressing
assert(front_t + grille_boss_h - insert_depth >= 3, "Grille insert pocket too close to the front face");
assert(fan_y - fan_pad - insert_depth >= 3, "Fan insert pocket too close to the front face");
assert(front_t + grille_boss_h <= fan_y - 0.3, "Grille bosses touch the fan");
assert(grille_depth <= fan_y - 2, "Grille bars too close to the fan");
assert(grille_gap <= 6, "Grille openings wider than 6 mm (finger safety)");
assert(ring_in - spigot_w > grille_hub_r + grille_rings * grille_bar, "Grille collar hits the rings");
assert(grille_screw_r - grille_boss_d / 2 > open_r, "Grille bosses reach into the opening");
assert(grille_r - (grille_screw_r + head_pocket[0] / 2) >= 1.2 && grille_t - head_pocket[1] >= 2, "Grille ring too narrow or too thin at the screw heads");
assert(fan_blade_d / 2 < open_r, "Front opening smaller than the fan blades");
assert(open_r < fan_size / 2 - 0.5, "Air duct does not sit on the fan frame face");
assert(fan_cx - open_r - shroud_t > wall + inner_c && fan_cx + open_r + shroud_t < part_x
       && fan_cz - open_r - shroud_t > wall + inner_c && fan_cz + open_r + shroud_t < body_h - wall - inner_c,
       "Air duct hits the walls or the partition");
assert(shelf_z + shelf_t < body_h - wall, "Shelf above the top wall");
assert(front_t + shelf_d - shelf_hold[0] > pot_yz[0] + pwm_pcb[1] / 2 + 0.5, "Shelf hold-down plate reaches the PWM board");
assert(chg_fan_gap >= 5 && chg_gap - chg_tape >= 3
       && max(chg_y0 - 1 - (chg_gap + chg_pcb[2] - chg_ledge[1]), fan_y + fan_t + fan_pad + 0.5) + (chg_gap + chg_pcb[2] - chg_ledge[1]) < chg_y0 + chg_pcb[1] - 4
       && chg_pads[len(chg_pads) - 1][0] + chg_pads[len(chg_pads) - 1][1] <= chg_pcb[0] - 4 && chg_pads[0][0] >= 4
       && chg_y0 + chg_pcb[1] < body_d - back_t - 1 && chg_z + chg_pcb[0] / 2 < cable_notch_z[1] - cable_notch[1] / 2 - 2
       && chg_z - chg_pcb[0] / 2 - chg_ledge[0] > cable_notch_z[0] + cable_notch[1] / 2 + 2
       && cable_notch_z[0] - cable_notch[1] / 2 > cradle_z[1] + cradle_t + 1 && cable_notch_z[0] + cable_notch[1] / 2 < cradle_z[2] - 1,
       "Charge module reaches the fan frame, the back or the cable notch");
assert(chg_gap - chg_tape >= 0.5 && (part_x - chg_gap) - max(part_x - chg_gap - chg_pcb[2] + chg_ledge[1], fan_cx + fan_size / 2 + 0.3) >= 1,
       "Charge module: pads too thin for the tape, or less than 1 mm of board on the ledge beside the fan frame");
assert(bat_cx - bat_d / 2 - bat_bms[1] - bat_clear - bat_bms_cut[1] > bay_x0 + 1, "BMS board of the battery or its cut-out hits the partition");
assert(cable_notch_z[0] - saddle_rib_slot[0] / 2 > cradle_z[1] + cradle_t + saddle_gusset - 0.5 && cable_notch_z[0] + saddle_rib_slot[0] / 2 < cradle_z[2] - saddle_gusset + 0.5
       && body_d - back_t - saddle_rib_slot[1] - saddle_rib_slot[0] / 2 > bat_cy + bat_d / 2 + bat_clear + 5,
       "Saddle stiffening: wire passage in the rib hits a fillet or reaches the battery end of the rib");
assert(mount_top < fan_cz - fan_size / 2 - 2 && (mount_boss_d - mount_insert[0]) / 2 >= mount_insert[2] + 1.5 && mount_floor >= 2,
       "Mount boss hits the fan, is thinner than the datasheet wall + 1.5 mm, or its floor is too thin");
assert(mount_xy[0] + mount_doubler[0] / 2 >= part_x - 1, "Mount doubler does not reach the partition");
assert(back_t - head_pocket[1] >= 2, "Back cover too thin under the recessed screw heads");
assert(usbc_xz[0] - usbc[1] / 2 - usbc_cl > bat_cx + bat_d / 2 + 2,   // the wall stop stays out of the battery removal path
       "USB-C module: its stop on the right wall reaches the battery path");
assert(sw_bezel[2] + sw_rocker <= sw_well[0] - 1 && sw_body[0] < sw_cut[0] && sw_body[1] < sw_cut[1] && sw_bezel[0] > sw_cut[0] + 1 && sw_bezel[1] > sw_cut[1] + 1
       && sw_xz[1] - (sw_bezel[1] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t) > shelf_z + shelf_t + shelf_hold[2] + shelf_hold[1] + 1
       && sw_xz[1] + (sw_bezel[1] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t) < body_h - wall - 1
       && sw_xz[1] - sw_body[1] / 2 > shelf_z + shelf_t + pwm_standoff + pwm_total_h + 1
       && sw_xz[0] + (sw_bezel[0] / 2 + sw_well[1] + sw_well[2] + sw_well[0] - back_t) < bay_x1 - lip_cl - lip_t,
       "Power switch: upper well hits the shelf, top wall or back lip, housing reaches PWM, or hole and frame do not match");
assert(usbc_stop[0] >= 4 && usbc_stop[1] >= usbc[2] && usbc_wall >= 2 && usbc_plate >= 1.2 && back_t - usbc_plate >= 1 && usbc_board[0] >= 8, "USB-C module: cover skin too thin, recess too shallow or board too short for the channel");
assert(usbc_xz[0] + usbc[1] / 2 + usbc_cl < bay_x1 - lip_cl - lip_t && usbc_xz[0] - usbc[1] / 2 - usbc_cl - usbc_wall > bay_x0 + 5
       && usbc_xz[1] + usbc[2] / 2 + usbc_cl < body_h - wall - 1
       && usbc_xz[1] - usbc[2] / 2 - usbc_cl - usbc_wall > cradle_z[1] + cradle_t + 1 && usbc_xz[1] + usbc[2] / 2 + usbc_cl < cradle_z[2] - 1,   // between two saddles
       "USB-C module hits the back lip, the top wall or a battery saddle");
assert(foot_key <= wall - 2 && foot_screw_skin >= 2.5 && (foot_boss_d - insert_hole_d) / 2 >= insert_w_min + 0.5,
       "Feet: pocket too deep, too little TPU under the screw heads, or boss wall below the Ruthex minimum");
assert(body_w - foot_inset - max(foot_doubler_hw, foot_boss_d / 2) > bat_cx + bat_d / 2 + 1 && foot_inset - foot_w / 2 > corner_r
       && foot_y0 > edge_c + 3 && foot_y0 + foot_len < part_y1 && foot_boss_top < min(fan_cz - fan_size / 2 - 2, cradle_z[0] - 1),
       "Feet: doubler or boss reaches the battery, the fan or the cradle, or foot in the corner radius or beyond the body");
assert((back_boss_d - insert_hole_d) / 2 >= 3 && back_boss_len >= insert_depth + 6 && boss_inset + back_boss_d / 2 + 1 < 14,
       "Back bosses: wall around the insert, column length, or reaching the back cover slots");
// hand under the raised bail: the pivots at mid-depth limit the arms (user chose level carrying over more finger room)
assert(bail_y - bail_bar_y[1] - (body_h - bail_z) >= 18 && body_w - 2 * bail_x[1] >= 90, "Bail: too little room for the fingers or the hand");
assert(cover_w / 2 - cover_notch_r >= 6 && wall - cover_glue[0] - cover_glue[2] >= 1.8 && cover_glue[1] + cover_glue[2] < cover_t
       && cover_t - cover_glue[1] - cover_glue[2] >= cover_glue[0] + cover_glue[2] && cover_notch_c < 2 * cover_t,
       "Service cover: corners beside the notch too narrow, or the glue groove too deep for the wall or too wide for the cover rim");
assert(pot_yz[0] - pwm_pcb[1] / 2 > front_t + inner_c && pot_yz[0] + pwm_pcb[1] / 2 < front_t + shelf_d
       && body_w - wall - pwm_wall_gap - pwm_pcb[0] - (pot_shaft_tip + wall + 1) > bay_x0 + 0.5
       && pot_yz[1] + pwm_comp_h + 2 < body_h - wall - 10
       && (usbc_xz[1] + usbc[2] / 2 < shelf_z || pot_yz[1] - pot_axis_h + pwm_comp_h < usbc_xz[1] + usbc[2] / 2 - usbc_stop[1] - 1),
       "PWM board: beyond the shelf, no room to pull it off the wall, too high, or its parts reach the USB-C stop");
assert(pot_mount_t >= 1.6 && pot_thread_reserve >= 0.1 && pot_nose_len > 0 && pwm_pcb_slot < pot_recess - 0.2
       && pot_recess_r >= pot_housing / 2 * sqrt(2) + 0.5 && pot_nut[0] < knob_cavity_d - 1
       && cover_groove_gap(pot_recess_r, pot_mount_t) >= 1.2
       && cover_groove_gap(norm([pwm_pcb[1] / 2 + pot_pcb_cl, pot_axis_h + pwm_pcb[2] + pot_pcb_cl]), wall - pwm_pcb_slot) >= 1.2,
       "Potentiometer: wall under the nut too thin, no thread reserve, housing pocket too small or too shallow for the PCB slot, knob recess misses the nut, or a pocket comes within 1.2 mm of the cover glue groove");
assert(pwm_pad < pwm_edge_free && pwm_standoff > pwm_pins + pwm_pin_cl + 3 && pwm_rib >= 2.4
       && pwm_rib_x()[0] + pwm_rib <= bat_cx + 10 - cable_slot_w / 2 - 0.2 && pwm_rib_x()[1] + pwm_rib < body_w - wall - 0.2,
       "PWM supports: pads wider than the pin-free edges, no rib left under the pin clearance, rib too thin, left rib over the battery cable slot, or right rib in the wall");
assert(pot_shaft_tip - knob_gap - knob_sleeve_z >= 8 && knob_skin >= 2 && knob_cavity_d > pot_nut[0] + 1 && knob_gap + knob_sleeve_z > pot_washer[1] + pot_nut[1] + 0.3   // recess over washer and nut on the outer face
       && knob_sleeve_z + knob_slit[1] < knob_len - knob_skin - 2 && knob_gap + knob_len - cover_out <= 8,
       "Knob: shaft engagement, top skin, nut recess, slit length or protrusion");
assert(bail_bar[1] == bail_arm[1] && (bail_eye - bail_sleeve[0] - 2 * bail_eye_cl) / 2 >= 2.2 && bail_eye > bail_arm[1]
       && bail_cb[0] >= m4_head[0] + 1 && bail_cb[1] <= bail_arm[0] / 3 && len_bail - bail_sleeve_len() >= 4
       && len_bail - bail_sleeve_len() <= m4_insert[1] && bail_eye / 2 - m4_insert[0] / 2 >= m4_insert[2]
       && bail_access_d >= m4_head[0] + 1.5 && bail_access_d / 2 < body_h - bail_z && bail_rim >= wall + 2,
       "Bail: eye wall, counterbore, screw engagement in the M4 insert, insert boss wall, access hole or rim");
assert(bail_floor - wall > fan_cz + open_r + shroud_t + 0.5 && bail_floor - wall > grille_screws()[0][1] + grille_boss_d / 2 + 0.5
       && bail_z - bail_eye / 2 - bail_cl - wall > led_xz[1] + led_boss[0] / 2 + 0.3 && logo_top < bail_floor - 1.5,
       "Bail recess shells reach the air duct, a grille boss or the LED boss, or the bar recess cuts into the logo");
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
        along_y(y1 - back_boss_len, y1 - back_boss_len + eps) boss_footprint(b);
        along_y(y1 - back_boss_len - gusset, y1 - back_boss_len - gusset + eps) rect(b[3], b[4]);
    }
}

module intake_slots_back() {
    bars = [[14, 44], [47, 76], [79, 108], [111, 141]];
    for (x = [14.8:slot_pitch:146], z = bars) if (abs(x - back_bar_x) > slot_w / 2 + 1.5) slot2d([x, z[0] + slot_w / 2], [x, z[1] - slot_w / 2], slot_w);
}

module intake_slots_side() {
    for (z = [18:slot_pitch:137], y = [[12, 37.5], [40.5, 66]]) slot2d([y[0] + slot_w / 2, z], [y[1] - slot_w / 2, z], slot_w);
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
        for (p = grille_screws()) cyl_y(p, front_t - eps, front_t + grille_boss_h, grille_boss_d / 2);
        for (b = back_bosses()) back_boss(b);
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
                translate([mount_xy[0] - mount_boss_d / 2, mount_xy[1] - mount_boss_d / 2 - (mount_top - zd), zd - 1]) cube([mount_boss_d, eps, 1]);
            }
            translate([mount_xy[0] - mount_rib[0] / 2, mount_xy[1], wall - eps]) cube([mount_rib[0], mount_boss_d / 2 + mount_rib[1], mount_top - wall + eps]);
            // floor doubler from the front plate to the partition: spreads lever loads of the mount
            translate([mount_xy[0] - mount_doubler[0] / 2, front_t - eps, wall - eps])
                cube([part_x + eps - (mount_xy[0] - mount_doubler[0] / 2), mount_doubler[1] - front_t + eps, mount_doubler[2] + eps]);
        }
        // folding bail: shells around the bar recess and the arm/eye pockets, from the front plate (printable), and bosses for the
        // M4 pivot inserts with a 45 degree underside towards the front
        along_x(bail_rim, body_w - bail_rim) polygon([[front_t - eps, bail_floor - wall], [bail_bar_y[1] + bail_cl + wall * sqrt(2), bail_floor - wall],
            [bail_bar_y[1] + bail_cl + wall * sqrt(2) + body_h - bail_floor + wall, body_h - eps], [front_t - eps, body_h - eps]]);
        bail_sides() {
            let (z0 = bail_z - bail_eye / 2 - bail_cl - wall)
                translate([wall - eps, front_t - eps, z0]) cube([bail_pocket_x[1] + eps, bail_y + (bail_eye / 2 + bail_cl) * sqrt(2) + wall - front_t + eps, body_h - eps - z0]);
            along_x(bail_pocket_x[1] - eps, bail_pocket_x[1] + m4_insert[1] + 2.5) hull() {
                translate([bail_y, bail_z]) circle(d = bail_eye);
                translate([bail_y - bail_eye / 2 / sqrt(2) - (body_h - wall - bail_z + bail_eye / 2 / sqrt(2)), body_h - wall]) square([0.01, wall - eps]);
            }
        }
        // two ribs on the shelf carry the PWM board on pads under its pin-free long edges, the solder pins in between stay
        // free; the ribs start at the front plate (printable), the back pad overhangs only the pin clearance
        // (the ribs run on behind the board edge up to the hold-down plate, so the back pads are not thin blades)
        for (x = pwm_rib_x()) difference() {
            translate([x, front_t - eps, shelf_z + shelf_t - eps]) cube([pwm_rib, front_t + shelf_d - shelf_hold[0] - 0.3 - front_t, pwm_standoff + eps]);
            translate([x - 1, pot_yz[0] - pwm_pcb[1] / 2 + pwm_pad, shelf_z + shelf_t + pwm_standoff - pwm_pins - pwm_pin_cl])
                cube([pwm_rib + 2, pwm_pcb[1] - 2 * pwm_pad, pwm_pins + pwm_pin_cl + 1]);
        }
        // charge/boost module standing upright: board back on two pads (tape), lower short edge on a ledge behind the
        // part side; 45 degree cones towards the front (printable)
        let (xb = part_x - chg_gap - chg_pcb[2], zb = chg_z - chg_pcb[0] / 2) {
            for (pd = chg_pads) hull() {
                translate([xb + chg_pcb[2] + chg_tape, chg_y0 + 1, zb + pd[0]]) cube([chg_gap - chg_tape + eps, chg_pcb[1] - 2, pd[1]]);
                translate([part_x, chg_y0 + 1 - (chg_gap - chg_tape), zb + pd[0]]) cube([1, eps, pd[1]]);
            }
            // ledge: its 45 degree cone starts behind the fan frame and reaches full width towards the back
            let (x0 = max(xb + chg_ledge[1], fan_cx + fan_size / 2 + 0.3), reach = part_x - x0, ya = max(chg_y0 - 1 - reach, fan_y + fan_t + fan_pad + 0.5), yf = ya + reach) hull() {
                translate([x0, yf, zb - chg_ledge[0]]) cube([reach + eps, chg_y0 + chg_pcb[1] + 1 - yf, chg_ledge[0]]);
                translate([part_x, ya, zb - chg_ledge[0]]) cube([1, eps, chg_ledge[0]]);
            }
        }
        // floor doublers over the foot pockets keep the bottom wall at 3.2 mm; bosses for the foot inserts with 45 degree
        // cones towards the front; all start at the front plate or on the floor (printable)
        for (fx = foot_x()) translate([fx - foot_doubler_hw, front_t - eps, wall - eps])
            cube([2 * foot_doubler_hw, part_y1 - front_t + eps, foot_key + eps]);
        for (p = foot_screws()) let (zf = wall + foot_key) hull() {
            translate([p[0], p[1], wall - eps]) cylinder(d = foot_boss_d, h = foot_boss_top - wall + eps);
            translate([p[0] - foot_boss_d / 2, p[1] - foot_boss_d / 2 - (foot_boss_top - zf), zf - 1]) cube([foot_boss_d, eps, 1]);
        }
        // stop on the right wall behind the USB-C module in the back cover, 45 degree wedge towards the front (printable)
        let (x0 = usbc_xz[0] - usbc[1] / 2, ys = usbc_y0 - usbc_cl, z0 = usbc_xz[1] + usbc[2] / 2 - usbc_stop[1]) hull() {
            translate([x0, ys - usbc_stop[0], z0]) cube([bay_x1 - x0 + eps, usbc_stop[0], usbc_stop[1]]);
            translate([bay_x1, ys - usbc_stop[0] - (bay_x1 - x0), z0]) cube([eps, eps, usbc_stop[1]]);
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
    cyl_y([fan_cx, fan_cz], -1, front_t + 1, open_r);
    // pockets for the tops of the TPU feet, 45 degree ends; inserts pressed in from below
    for (fx = foot_x()) translate([fx, foot_y0, 0]) hull() {
        translate([-foot_w / 2 - foot_cl, -foot_cl - 1, -1]) cube([foot_w + 2 * foot_cl, foot_len + 2 * foot_cl + 2, eps]);
        translate([-foot_w / 2 - foot_cl, foot_key - foot_cl, foot_key - eps]) cube([foot_w + 2 * foot_cl, foot_len + 2 * foot_cl - 2 * foot_key, eps]);
    }
    for (p = foot_screws()) translate([p[0], p[1], foot_key - eps]) cylinder(d = insert_hole_d, h = insert_depth + eps);
    cyl_y(led_xz, led_skin, led_boss[1] + 1, (led_d + 0.2) / 2);   // LED pocket, blind towards the front
    for (i = [0:groove_count - 1]) let (z = groove_z0 + i * groove_pitch)
        along_y(-1, groove_depth) slot2d([groove_x[0] + groove_w, z], [groove_x[1] - groove_w, z], groove_w);
    for (p = grille_screws()) {
        cyl_y(p, -1, front_t + grille_boss_h, screw_clear_d / 2);
        cyl_y(p, front_t + grille_boss_h - insert_depth, front_t + grille_boss_h + 1, insert_hole_d / 2);
    }
    for (p = fan_holes()) cyl_y(p, fan_y - fan_pad - insert_depth, fan_y + 1, insert_hole_d / 2);
    for (b = back_bosses()) cyl_y(b[0], body_d - back_t - insert_depth, body_d + 1, insert_hole_d / 2);
    // cable notches at the back edge of the partition: low for the USB-C wires, high for the fan cable
    for (z = cable_notch_z) translate([part_x - 1, part_y1 - cable_notch[0] + 1, z - cable_notch[1] / 2]) cube([part_t + 2, cable_notch[0], cable_notch[1]]);
    // battery cable slot through the shelf; the shelf rim still stops the battery upwards
    translate([bat_cx + 10 - cable_slot_w / 2, bat_cy - 6, shelf_z - 1]) cube([cable_slot_w, shelf_d + front_t - bat_cy + 7, shelf_t + 2]);
    along_x(-1, wall + 1) intake_slots_side();
    cyl_x(pot_yz, body_w - wall - 1, body_w + 1, (pot_bush[0] + 0.4) / 2);   // potentiometer bushing, nutted to the wall
    // from inside: round pocket for the potentiometer housing (shoulder on its floor) and a shallow slot for the PCB edge;
    // washer and nut sit on the flat outer face under the knob
    cyl_x(pot_yz, body_w - wall - 1, body_w - pot_mount_t, pot_recess_r);
    translate([body_w - wall - 1, pot_yz[0] - pwm_pcb[1] / 2 - pot_pcb_cl, pot_yz[1] - pot_axis_h - pwm_pcb[2] - pot_pcb_cl])
        cube([1 + pwm_pcb_slot, pwm_pcb[1] + 2 * pot_pcb_cl, pwm_pcb[2] + 2 * pot_pcb_cl]);
    // folding bail: bar recess along the front top edge with a 45 degree back face (printable, a finger groove behind the bar),
    // arm pockets beside the rims, eye pockets as teardrops pointing backwards and open to the top, screw access through the rims,
    // M4 insert holes in the inner pocket walls
    along_x(bail_rim, body_w - bail_rim) polygon([[-1, bail_floor], [bail_bar_y[1] + bail_cl, bail_floor],
        [bail_bar_y[1] + bail_cl + body_h + 1 - bail_floor, body_h + 1], [-1, body_h + 1]]);
    bail_sides() {
        translate([bail_pocket_x[0], -1, bail_floor]) cube([bail_pocket_x[1] - bail_pocket_x[0], bail_y + 1, body_h + 1 - bail_floor]);
        along_x(bail_pocket_x[0], bail_pocket_x[1]) let (r = bail_eye / 2 + bail_cl) {
            hull() { translate([bail_y, bail_z]) circle(r = r); translate([bail_y + r * sqrt(2), bail_z]) square(0.01, center = true); }
            translate([bail_y - r, bail_z]) square([2 * r, body_h + 1 - bail_z]);
        }
        cyl_x([bail_y, bail_z], -1, bail_pocket_x[0] + eps, bail_access_d / 2);
        cyl_x([bail_y, bail_z], bail_pocket_x[1] - eps, bail_pocket_x[1] + m4_insert[1] + 1, m4_insert[0] / 2);
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
module body_piece(piece)
    if (piece == "base") difference() {
        body_print_pose() body();
        inlay_zone() body_label_print_2d();
        inlay_zone(dedication_h + eps, front_t) body_dedication_print_2d();
    }
    else intersection() {
        body_print_pose() body();
        if (piece == "label") inlay_zone() body_label_print_2d();
        else inlay_zone(dedication_h + eps, front_t) body_dedication_print_2d();
    }

// ---------- grille ----------
module grille_bars_2d() {
    circle(r = grille_hub_r);
    for (k = [1:grille_rings]) let (r0 = grille_hub_r + k * grille_gap + (k - 1) * grille_bar)
        difference() { circle(r = r0 + grille_bar); circle(r = r0); }
    for (i = [0:grille_spokes - 1]) rotate(i * 360 / grille_spokes) translate([0, -grille_bar / 2]) square([ring_in + 1, grille_bar]);
}

module grille() {
    c = [fan_cx, fan_cz];
    difference() {
        union() {
            difference() {
                union() {
                    cyl_y(c, -grille_t, -grille_t + 0.6, grille_r - 0.6, grille_r);   // chamfer on the bed edge
                    cyl_y(c, -grille_t + 0.6 - eps, 0, grille_r);
                }
                cyl_y(c, -grille_t - 1, 1, ring_in);
            }
            along_y(-grille_t, grille_depth) translate(c) intersection() { grille_bars_2d(); circle(r = ring_in + 0.5); }
            difference() {
                cyl_y(c, -eps, spigot_t, open_r - spigot_cl);
                cyl_y(c, -1, spigot_t + 1, ring_in);
            }
        }
        for (p = grille_screws()) {
            cyl_y(p, -grille_t - 1, -grille_t + head_pocket[1], head_pocket[0] / 2);
            cyl_y(p, -grille_t - 1, spigot_t + 1, screw_clear_d / 2);
        }
    }
}
module grille_print_pose() translate([0, 0, grille_t]) rotate([90, 0, 0]) children();

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
        }
        // hold-down plate over the free back edge of the battery shelf
        translate([bay_x0 + shelf_fillet + 0.5, front_t + shelf_d - shelf_hold[0], shelf_z + shelf_t + shelf_hold[2]])
            cube([bay_x1 - bay_x0 - 2 * shelf_fillet - 1, y1 - (front_t + shelf_d - shelf_hold[0]) + eps, shelf_hold[1]]);
        // saddles closing the cradle rings around the battery, across the whole bay, with the BMS cut-out
        for (z = cradle_z) difference() {
            translate([bay_x0 + 0.5, bat_cy + saddle_gap, z]) cube([bay_x1 - bay_x0 - 1, y1 - bat_cy - saddle_gap + eps, cradle_t]);
            translate([bat_cx, bat_cy, z - 1]) cylinder(r = bat_d / 2 + bat_clear, h = cradle_t + 2);
            translate([bat_cx - bat_d / 2 - bat_bms[1] - bat_clear - bat_bms_cut[1], bat_cy - 1, z - 1])
                cube([bat_bms[1] + bat_clear + bat_bms_cut[1] + bat_d / 2, bat_bms[0] / 2 + bat_clear + bat_bms_cut[0] + 1, cradle_t + 2]);
        }
        // stiffening against drops: 45 degree fillets at the saddle roots, rib tying the saddles together behind the battery
        for (i = [0:len(cradle_z) - 1], s = [-1, 1]) if (i > 0 || s > 0) let (z = s > 0 ? cradle_z[i] + cradle_t : cradle_z[i])
            along_x(bay_x0 + 0.5, bay_x1 - 0.5) polygon([[y1 + eps, z - s * eps], [y1 - saddle_gusset, z - s * eps], [y1 + eps, z + s * saddle_gusset]]);
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
    }
    along_y(y1 - 1, body_d + 1) intake_slots_back();
    // power switch: well from outside with 45 degree walls (printable on the back face), hole in its thin floor
    sw_funnel(body_d - sw_well[0], body_d + 1, 0);
    translate([sw_xz[0] - sw_cut[0] / 2, body_d - sw_well[0] - sw_panel - 1, sw_xz[1] - sw_cut[1] / 2]) cube([sw_cut[0], sw_panel + 2, sw_cut[1]]);
    // USB-C module: recess from the inside leaves usbc_plate in front of the board, opening for the receptacle
    translate([usbc_xz[0] - usbc[1] / 2 - usbc_cl, y1 - 1, usbc_xz[1] - usbc[2] / 2 - usbc_cl]) cube([usbc[1] + 2 * usbc_cl, 1 + back_t - usbc_plate, usbc[2] + 2 * usbc_cl]);
    usbc_stadium(body_d - usbc_plate - 1, body_d + 1, usbc_cl);
    for (b = back_bosses()) {
        cyl_y(b[0], body_d - head_pocket[1], body_d + 1, head_pocket[0] / 2);   // recessed heads
        cyl_y(b[0], y1 - 1, body_d + 1, screw_clear_d / 2);
    }
}
module back_print_pose() translate([0, 0, body_d]) rotate([-90, 0, 0]) children();   // back face on the bed

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
module chg_module_env() {            // board upright on the partition, parts and heatsinks towards the fan section
    x0 = part_x - chg_gap - chg_pcb[2];
    z0 = chg_z - chg_pcb[0] / 2;
    translate([x0, chg_y0, z0]) cube([chg_pcb[2], chg_pcb[1], chg_pcb[0]]);
    for (pd = chg_pads) translate([x0 + chg_pcb[2] - eps, chg_y0 + 1, z0 + pd[0]]) cube([chg_tape + eps, chg_pcb[1] - 2, pd[1]]);   // tape on the pads
    translate([x0 - chg_comp_h, chg_y0, z0]) cube([chg_comp_h + eps, chg_pcb[1], chg_pcb[0]]);   // parts up to the edges
    for (i = [0, 1]) translate([x0 - chg_comp_h - chg_sink[2], chg_y0 + (chg_pcb[1] - chg_sink[1]) / 2,
                                z0 + (chg_pcb[0] - 2 * chg_sink[0] - chg_sink[3]) / 2 + i * (chg_sink[0] + chg_sink[3])])
        cube([chg_sink[2] + eps, chg_sink[1], chg_sink[0]]);
}
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
// Flat U bail: folded it lies flush in the step along the front top edge and beside both rims, raised it hangs from the pivots
// at mid-depth. Built folded (angle 0) and turned about the pivot axis; 90 = raised.
module bail_sides() { children(); translate([body_w, 0, 0]) mirror([1, 0, 0]) children(); }
module chamfered_rect_2d(size, c) polygon([[c, 0], [size[0] - c, 0], [size[0], c], [size[0], size[1] - c], [size[0] - c, size[1]], [c, size[1]], [0, size[1] - c], [0, c]]);
module bail(angle = 0) translate([0, bail_y, bail_z]) rotate([-angle, 0, 0]) translate([0, -bail_y, -bail_z]) difference() {
    union() {
        along_x(bail_x[0], body_w - bail_x[0]) translate([bail_bar_y[0], bail_floor]) chamfered_rect_2d(bail_bar, bail_c);   // bar
        bail_sides() {
            along_y(bail_bar_y[0], bail_y) translate([bail_x[0], bail_floor]) chamfered_rect_2d(bail_arm, bail_c);   // arm
            cyl_x([bail_y, bail_z], bail_x[0], bail_x[1], bail_eye / 2);                                         // eye
        }
    }
    bail_sides() {
        cyl_x([bail_y, bail_z], bail_x[0] - 1, bail_x[1] + 1, bail_sleeve[0] / 2 + bail_eye_cl);   // turns on the sleeve
        cyl_x([bail_y, bail_z], bail_x[0] - 1, bail_x[0] + bail_cb[1], bail_cb[0] / 2);           // screw head, outer face
    }
}
module bail_print_pose() translate([body_w, 0, body_h]) rotate([0, 180, 0]) children();   // top face on the bed

// ---------- bought parts: envelopes for the checks ----------
module fan_env() {                  // frame block plus the silicone corner pads on both faces
    translate([fan_cx - fan_size / 2, fan_y, fan_cz - fan_size / 2]) cube([fan_size, fan_t, fan_size]);
    for (sx = [-1, 1], sz = [-1, 1], y = [fan_y - fan_pad, fan_y + fan_t - eps]) translate([fan_cx, 0, fan_cz]) scale([sx, 1, sz])
        along_y(y, y + fan_pad + eps) polygon([[fan_size / 2, fan_pad_leg], [fan_size / 2, fan_size / 2], [fan_pad_leg, fan_size / 2]]);
}
module fan_visual() translate([fan_cx, fan_y, fan_cz]) rotate([-90, 0, 0]) {   // local z along +y
    difference() {
        translate([-fan_size / 2, -fan_size / 2, 0]) cube([fan_size, fan_size, fan_t]);
        translate([0, 0, -1]) cylinder(d = fan_blade_d + 2, h = fan_t + 2);
        for (sx = [-1, 1], sy = [-1, 1]) translate([sx * fan_pitch / 2, sy * fan_pitch / 2, -1]) cylinder(d = fan_hole_d, h = fan_t + 2);
    }
    cylinder(r = 20, h = fan_t - 3);
    for (i = [0:6]) rotate(i * 360 / 7) translate([19, 0, 11]) rotate([40, 0, 0]) translate([0, -9, -0.75]) cube([37, 18, 1.5]);
    for (i = [0:3]) rotate(45 + i * 90) translate([18, -1.5, fan_t - 3]) cube([62, 3, 3]);
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
module screws_grille(socket = false) for (p = grille_screws()) translate([p[0], -grille_t + head_pocket[1], p[1]]) orient([0, 1, 0]) screw(len_grille, socket);
module screws_fan(socket = false) for (p = fan_holes()) translate([p[0], fan_y + fan_t + fan_pad, p[1]]) orient([0, -1, 0]) screw(len_fan, socket);
module screws_back(socket = false) for (b = back_bosses()) translate([b[0][0], body_d - head_pocket[1], b[0][1]]) orient([0, -1, 0]) screw(len_back, socket);
module screws_feet(socket = false) for (p = foot_screws()) translate([p[0], p[1], -foot_lift + foot_head_recess + screw_head_h]) orient([0, 0, 1]) screw(len_foot, socket);
module screw_m4(len, socket = false) difference() {   // ISO 7380 M4 button head, head above z = 0
    union() {
        translate([0, 0, -m4_head[1]]) cylinder(d = m4_head[0], h = m4_head[1]);
        translate([0, 0, -m4_head[1]]) cylinder(r = 2, h = len + m4_head[1]);
    }
    if (socket) translate([0, 0, -m4_head[1] - eps]) cylinder(d = 3.5 / cos(30), h = 1.2, $fn = 6);   // drive recess, viewer only
}
module screws_bail(socket = false) bail_sides() {   // M4 x 12 from the side through the sleeve (part of this envelope) into the insert
    translate([bail_pocket_x[1] - bail_sleeve_len(), bail_y, bail_z]) orient([1, 0, 0]) screw_m4(len_bail, socket);
    cyl_x([bail_y, bail_z], bail_pocket_x[1] - bail_sleeve_len(), bail_pocket_x[1], bail_sleeve[0] / 2);
}

module assembly(explode = 0, bail_angle = 0) {
    body_install_pose() {
        color("#f2f2ee") body_piece("base");
        color("#8f9396") body_piece("label");
        color("#8f9396") body_piece("dedication");
    }
    color("#8f9396") translate([0, -explode, 0]) grille();
    color("#f2f2ee") translate([0, 2 * explode, 0]) back();
    color("#8f9396") translate([explode, 0, 0]) cover();
    color("#8f9396") translate([0, 0, explode]) bail(bail_angle);
    color("#26282b") translate([0, 0, explode]) screws_bail(true);
    color("#222326") translate([0, 0, -explode / 2]) place_feet();
    color("#26282b") translate([0, 0, -explode]) screws_feet(true);
    translate([2 * explode, 0, 0]) { color("#8f9396") knob_install_pose() knob_piece("base"); color("#ffffff") knob_install_pose() knob_piece("pointer"); }
    color("#3a3d41") translate([explode, 0, 0]) pot_env();
    color("#2e6b3f") translate([explode, 0, 0]) pwm_board_env();
    color("#c9c9c9") translate([0, explode, 0]) chg_module_env();
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
    ["fan_blade_d", fan_blade_d], ["pot_shaft_len", pot_shaft_tip], ["pot_shaft_d", pot_shaft_d], ["pot_shaft_free", pot_shaft_free], ["pot_bush", pot_bush], ["pot_mount_t", pot_mount_t], ["pwm_total_h", pwm_total_h], ["pwm_total_len", pwm_total_len], ["pwm_pcb", pwm_pcb], ["pot_axis_h", pot_axis_h], ["pwm_lift", pwm_pins + pwm_pin_cl + 0.5], ["knob_shaft_engagement", pot_shaft_tip - knob_gap - knob_sleeve_z], ["knob_top_skin", knob_len - knob_bore_top], ["knob_protrusion", knob_gap + knob_len - cover_out], ["bail_clearance", bail_y - bail_bar_y[1] - (body_h - bail_z)], ["bail_grip", body_w - 2 * bail_x[1]], ["bail_insert", m4_insert], ["foot_clearance", foot_cl], ["dedication_lines", len(dedication)], ["foot_lift", foot_lift], ["fan_axis", [fan_cx, fan_cz]], ["fan_y", fan_y], ["shroud_r", [open_r, open_r + shroud_t]], ["shroud_gap", shroud_gap], ["open_d", 2 * open_r], ["grille_gap", grille_gap],
    ["bat_mm", [bat_d, bat_l]], ["bat_bms", bat_bms], ["bat_clear", bat_clear], ["saddle_gap", saddle_gap], ["cradle_rings", len(cradle_z)], ["shelf_gap", shelf_gap],
    ["lip_clearance", lip_cl], ["spigot_clearance", spigot_cl],
    ["usbc_board_mm", usbc_board], ["usbc_protrusion", usbc_protrusion], ["usbc_total_mm", usbc], ["usbc_plate", usbc_plate], ["usbc_clearance", usbc_cl],
    ["usbc_shell_mm", usbc_shell], ["usbc_shell_bottom_approx", usbc_shell_bottom],
    ["chg_pcb_mm", chg_pcb], ["chg_total_h", chg_total_h],
    ["insert_hole_d", insert_hole_d], ["insert_w_min", insert_w_min], ["mount_insert", mount_insert], ["mount_floor", mount_floor], ["insert_len", insert_len], ["insert_depth", insert_depth],
    ["screws", screw_table],
    // insert pockets: [assembly body, opening point, direction into the material, depth]
    ["inserts", concat(
        [for (p = grille_screws()) ["body", [p[0], front_t + grille_boss_h, p[1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (p = fan_holes()) ["body", [p[0], fan_y - fan_pad, p[1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (b = back_bosses()) ["body", [b[0][0], body_d - back_t, b[0][1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (s = [0, 1]) ["body", [s ? body_w - bail_pocket_x[1] : bail_pocket_x[1], bail_y, bail_z], [s ? -1 : 1, 0, 0], m4_insert[1] + 1, m4_insert[0], m4_insert[2]]],
        [for (p = foot_screws()) ["body", [p[0], p[1], foot_key], [0, 0, 1], insert_depth, insert_hole_d, insert_w_min]],
        [["body", [mount_xy[0], mount_xy[1], 0], [0, 0, 1], mount_insert[1] + 1, mount_insert[0], mount_insert[2]]])]]);
else if (part == "none") {}
else if (part == "body") body_print_pose() body();
else if (part == "body_base") body_piece("base");
else if (part == "body_label") body_piece("label");
else if (part == "body_dedication") body_piece("dedication");
else if (part == "back") back_print_pose() back();
else if (part == "grille") grille_print_pose() grille();
else if (part == "cover") cover_print_pose() cover();
else if (part == "bail") bail_print_pose() bail();
else if (part == "knob") knob_print_pose() knob_local();
else if (part == "knob_base") knob_piece("base");
else if (part == "knob_pointer") knob_piece("pointer");
else if (part == "foot") foot_print_pose() foot();
else if (part == "test_right") test_right();
else if (part == "test_right_back") test_right_back();
