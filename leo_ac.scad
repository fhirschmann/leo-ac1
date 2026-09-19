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
boss_d = 8;          // screw bosses for inserts (service cover)
back_boss_d = 10;    // back cover bosses: 3 mm of material around the Ruthex hole (datasheet 1.6)
boss_inset = 6.5;    // back bosses: axis distance from the outer edges
back_boss_len = 16;  // solid column behind the insert
gusset = 20;         // cone below the back bosses into the wall corner (print orientation), flatter than 45 degrees
slot_w = 1.6;        // intake slots, back and left side
slot_pitch = 3.2;
back_bar_x = 80;     // extra vertical bar through the back intake slots

/* [Battery, 3.2 V 6000 mAh LiFePO4 pack] */
bat_d = 33.5;        // 32700 cell with shrink sleeve (label "3,4 x 7 cm" incl. BMS)
bat_bms = [16, 4];   // BMS board on one side, facing the partition (-x): width (y), thickness (x); full length assumed, to be measured
bat_l = 72;          // the cable leaves at one end: that end up, through the shelf slot
cable_slot_w = 10;   // slot in the shelf above the battery, open towards the back
bat_cx = 180;
bat_clear = 0.5;     // radial clearance in the cradle
bat_front_gap = 4.5; // front plate to battery, clears the inner fillet
// three closed rings around the battery for drops: front half as ribs in the body, back half as saddles on the back cover
cradle_z = [14, 28, 56];  // lower faces of the rings, clear of the corner bosses (z <= 10.5) and the cover bosses (z 34-42)
cradle_t = 4;
saddle_gap = 0.3;    // rib end to saddle along y
shelf_gap = 3;       // battery top to electronics shelf (cable, protection board)
shelf_t = 4;         // stops the battery when the unit falls on its top
shelf_fillet = 3;    // 45 degree fillets along its joints with partition and right wall, above and below
shelf_hold = [5, 3, 0.2];  // hold-down plate on the back cover over the free shelf edge: overlap (y), thickness, gap
shelf_d = 60;        // shelf depth from the front plate, carries the PWM board

/* [Service cover, right side] */
cover_y = body_d / 2; // centre, in the middle of the side depth
cover_z = 88;
cover_w = 34;        // along y
cover_hgt = 116;     // along z, reaches up to the speed knob above the battery
cover_out = 11;      // protrusion
cover_t = 2.4;
cover_r = 4;
cover_screw_dz = 50;
cover_boss_d = 9;    // screw columns inside the cover, screws from outside
cover_ins_depth = 7.5;  // insert pocket from the outer wall face, into an inner boss (M3 x 16)

/* [Speed knob, potentiometer of the PWM fan controller] */
pot_shaft = [6, 4.5, 15]; // D shaft: diameter, across the flat, length from the outer wall face (WH148 type, to be measured)
pot_bush = [7, 7];        // threaded bushing M7: diameter, length from the inner wall face
pot_nut = [11, 2];        // nut as cylinder: diameter across corners, thickness
pot_body = [16.5, 18];    // housing incl. switch: diameter, depth behind the wall
// PWM board CNY-FA5-PRO: right-angle potentiometer on its edge, shaft parallel to the board. The board lies on two ribs
// above the shelf, potentiometer edge at the right wall, held there by the potentiometer nut. Estimated from a photo.
pwm_pcb = [48, 34, 1.6];  // length (x, from the wall inwards), width (y), thickness — to be measured
pwm_comp_h = 13;          // screw terminals and fan header above the board
pwm_standoff = 4;         // board underside above the shelf (solder joints)
pwm_wall_gap = 0.5;       // board edge to the inner wall face
pot_axis_h = 8.5;         // potentiometer axis above the board top — to be measured
knob_d = 28;              // flat cap in front of the cover
knob_h = 6.5;
knob_gap = 0.5;           // cap to the cover face
knob_stem_d = 10;         // stem through the cover, ends just above the bushing
knob_stem_cl = 0.5;       // stem end to the bushing end, and radial clearance in the cover hole
knob_bore_cl = 0.1;       // D bore clearance per side, press fit
knob_flutes = 30;
knob_c = 1.2;

/* [Charge/boost module in the air stream] */
chg_pcb = [35.4, 11, 1.6];     // 2-in-1 LiFePO4 charge + 12 V boost module: length (y), width (z), thickness
chg_comp_h = 2;                // parts on the top side
chg_sink = [8.8, 8.8, 5, 6];   // two stick-on aluminium heatsinks: y, z, height, gap between them
chg_z = 95;                    // centre height on the partition, board upright (long axis along z), at the fan rim
chg_gap = 2;                   // air gap between board and partition; parts stay clear of the fan frame
chg_fan_gap = 5;               // free space from the fan's back pads to the front edge of the upright board (intake air)
// solder pads (IN, B, O) and parts reach the long edges: no grooves. The board back sits on two pads with heat-resistant
// double-sided tape, its lower edge on a ledge that stays behind the part side.
chg_pads = [[5.5, 4], [21.5, 6]];  // pads behind the board, clear of the through-hole solder pads: start from the lower end, length
chg_ledge = [2, 0.3];          // ledge under the lower board edge: height, set back from the part side

/* [Handle, top] */
handle_len = 170;      // along x
handle_h = 42;         // above the top wall
handle_d = 24;         // along y
handle_cx = body_w / 2;
handle_cy = body_d / 2;
handle_bar = 12;       // grip thickness (z)
handle_open = [110, 90, 14];  // opening: width at the bottom, width at the top (hand breadth), height of its vertical sides
handle_end = [15, 8];  // outer ends: slant inset at the top, height of the vertical foot face
handle_c = 2.5;        // 45 degree bevels on all edges
handle_screw_dx = [62, 77];  // screw axes from the handle centre, both sides
handle_pad = [3.2, 7];       // doubler under the top wall at each foot (6.4 mm together): thickness, driver room from a screw axis to the next rib
handle_rib = [3.2, 12];      // three ribs per foot from the front plate to the back lip: thickness, height below the top wall
handle_key = [1.2, 0.2];     // key under each foot in a recess of the top wall, takes shear off the screws: height, clearance
handle_ins_depth = 8.5;      // insert pockets in the feet, from the key face (Ruthex: >= L + 1)

/* [USB-C charging socket: PD trigger module (Type A, pads 1-4 open = 5 V) in the back cover] */
usbc = [13, 10, 4];          // module incl. receptacle: length (y), width (x), height (z) — listing, to be measured
usbc_shell = [8.94, 3.26];   // USB-C receptacle shell: width, height (USB-C spec), protrudes beyond the board by >= usbc_plate
usbc_plate = 2.4;            // back cover thinned to this around the module: receptacle flush with the face, board edge rests on it
usbc_xz = [213, 118];        // receptacle axis: top right in the electronics bay, clear of the back lip and the handle ribs
usbc_cl = 0.2;               // clearance in channel, plate opening and to the stop
usbc_wall = 1.2;             // channel on the inside of the back cover: side walls and floor, open at the top for the wires
usbc_stop = 2;               // stop on the right wall behind the module end, takes the plug force with the back cover on

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
len_cover = 16;      // M3 x 16, from outside through the service cover, head recessed
len_handle = 12;     // M3 x 12, from inside the body through top wall and doubler
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
dedication_size = [8, 8, 5.5];   // per line, the date smaller
dedication_bold = 0.15;    // extra stroke per side: thin joints of the font reach two lines (0.8 mm) in grey
dedication_h = 0.8;        // raised height (four layers)
dedication_z = [121, 111, 103.5];   // baselines, between the PWM board and the LED boss

// ---------- derived values ----------
pot_yz = [cover_y, wall + bat_l + shelf_gap + shelf_t + pwm_standoff + pwm_pcb[2] + pot_axis_h];   // knob axis above the battery, centred in the depth
mount_top = mount_insert[1] + 1 + mount_floor;        // boss top inside; blind hole L + 1 from the underside
knob_stem_z = -wall + pot_bush[1] + knob_stem_cl;     // stem end, from the outer face of the right wall
knob_cap_z = cover_out + knob_gap;                    // cap underside, same reference
knob_len = knob_cap_z + knob_h - knob_stem_z;
knob_bore_top = pot_shaft[2] + 1 - knob_stem_z;       // knob coordinates, 1 mm beyond the shaft end
logo_w = text_w(brand_sub, sub_size, sub_stroke, sub_gap);
big_gap = (logo_w - text_w(brand, big_size, big_stroke, 0)) / (len(brand) - 1);
logo_x0 = logo_cx - logo_w / 2;
logo_bottom = logo_top - big_size[1] - 2 * (line_gap + sub_size[1]);
led_xz = [logo_x0 + text_x(brand, big_size, big_stroke, big_gap, 2) + big_size[0] / 2, logo_top - big_size[1] / 2];   // centre of the O
fan_y = front_t + fan_standoff;                       // front face of the fan frame
chg_y0 = fan_y + fan_t + fan_pad + chg_fan_gap;       // front edge of the upright charge module
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
function cover_screws() = [for (s = [-1, 1]) [cover_y, cover_z + s * cover_screw_dz]];
function handle_screws() = [for (sx = [-1, 1], dx = handle_screw_dx) [handle_cx + sx * dx, handle_cy]];
function handle_pad_u() = [handle_screw_dx[0] - handle_pad[1] - handle_rib[0], handle_screw_dx[1] + handle_pad[1] + handle_rib[0]];   // doubler span from the handle centre
function handle_key_u() = [handle_open[0] / 2 + 3, handle_len / 2 - 3];   // key span from the handle centre
handle_key_w = handle_d - 2 * handle_c - 1;           // key width along y, inside the flat foot face
handle_screw_skin = wall + handle_pad[0] - handle_key[0];   // head face to insert mouth
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
    ["cover", len_cover, body_w - max(body_w + cover_out - head_pocket[1] - len_cover, body_w - insert_len),
     (body_w + cover_out - head_pocket[1] - len_cover) - (body_w - cover_ins_depth)],
    ["handle", len_handle, min(len_handle - handle_screw_skin, insert_len), handle_ins_depth - (len_handle - handle_screw_skin)],
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
assert(part_x - chg_gap - chg_pcb[2] - chg_comp_h > fan_cx + fan_size / 2 + 0.3
       && chg_fan_gap >= 5
       && chg_y0 + chg_pcb[1] < body_d - back_t - 1 && chg_z + chg_pcb[0] / 2 < 118,
       "Charge module reaches the fan frame, the back or the cable notch");
assert(bat_cx - bat_d / 2 - bat_bms[1] - bat_clear > bay_x0 + 1, "BMS board of the battery hits the partition");
assert(mount_top < fan_cz - fan_size / 2 - 2 && (mount_boss_d - mount_insert[0]) / 2 >= mount_insert[2] + 1.5 && mount_floor >= 2,
       "Mount boss hits the fan, is thinner than the datasheet wall + 1.5 mm, or its floor is too thin");
assert(mount_xy[0] + mount_doubler[0] / 2 >= part_x - 1, "Mount doubler does not reach the partition");
assert(back_t - head_pocket[1] >= 2, "Back cover too thin under the recessed screw heads");
assert(back_t - usbc_plate >= 1 && usbc[0] - usbc_plate >= 8, "USB-C module: back cover recess too shallow or module too short for the channel");
assert(usbc_xz[0] + usbc[1] / 2 + usbc_cl < bay_x1 - lip_cl - lip_t && usbc_xz[0] - usbc[1] / 2 - usbc_cl - usbc_wall > bay_x0 + 5
       && usbc_xz[1] + usbc[2] / 2 + usbc_cl < body_h - wall - handle_rib[1] - 1
       && usbc_xz[1] - usbc[2] / 2 - usbc_cl - usbc_wall > shelf_z + shelf_t + pwm_standoff + pwm_pcb[2] + pwm_comp_h + 3,
       "USB-C module hits the back lip, the handle ribs or the PWM board");
assert(foot_key <= wall - 2 && foot_screw_skin >= 2.5 && (foot_boss_d - insert_hole_d) / 2 >= insert_w_min + 0.5,
       "Feet: pocket too deep, too little TPU under the screw heads, or boss wall below the Ruthex minimum");
assert(body_w - foot_inset - max(foot_doubler_hw, foot_boss_d / 2) > bat_cx + bat_d / 2 + 1 && foot_inset - foot_w / 2 > corner_r
       && foot_y0 > edge_c + 3 && foot_y0 + foot_len < part_y1 && foot_boss_top < min(fan_cz - fan_size / 2 - 2, cradle_z[0] - 1),
       "Feet: doubler or boss reaches the battery, the fan or the cradle, or foot in the corner radius or beyond the body");
assert((back_boss_d - insert_hole_d) / 2 >= 3 && back_boss_len >= insert_depth + 6 && boss_inset + back_boss_d / 2 + 1 < 14,
       "Back bosses: wall around the insert, column length, or reaching the back cover slots");
// hand under the grip: child hand breadth about 55-70 mm, adult 80-90 mm; comfortable finger clearance 30-35 mm
assert(handle_h - handle_bar >= 30 && handle_open[1] >= 90, "Handle opening too small for a hand");
assert(knob_d <= cover_w - 4 && abs(pot_yz[1] - cover_z) + knob_d / 2 < cover_hgt / 2 - 2
       && min([for (s = [-1, 1]) abs(pot_yz[1] - cover_z - s * cover_screw_dz)]) > max(cover_boss_d / 2 + pot_nut[0] / 2, screw_head_d / 2 + knob_d / 2) + 1,
       "Knob or nut does not fit between the cover bosses");
assert(pot_yz[0] - pwm_pcb[1] / 2 > front_t + inner_c && pot_yz[0] + pwm_pcb[1] / 2 < front_t + shelf_d
       && body_w - wall - pwm_wall_gap - pwm_pcb[0] - (pot_shaft[2] + wall + 1) > bay_x0 + 0.5
       && pot_yz[1] + pwm_comp_h + 2 < body_h - wall - 10,
       "PWM board: beyond the shelf, no room to pull it off the wall, or too high");
assert(pot_shaft[2] - knob_stem_z >= 8 && knob_len - knob_bore_top >= 2 && knob_stem_z > pot_nut[1] + 0.5,
       "Knob: shaft engagement, top skin or stem end");
assert(handle_end[1] > handle_ins_depth - handle_key[0] && handle_open[2] > handle_ins_depth - handle_key[0] && handle_ins_depth >= insert_len + 1,
       "Handle insert pockets reach the slants or are shorter than L + 1");
assert(handle_pad[1] - screw_head_d / 2 >= 3 && (handle_screw_dx[1] - handle_screw_dx[0] - handle_rib[0] - screw_head_d) / 2 >= 3,
       "Handle ribs leave no room for the screwdriver");
assert(body_h - wall - handle_rib[1] > fan_cz + fan_size / 2 + 1, "Handle ribs reach the fan");
assert(handle_key_w / 2 < handle_d / 2 - handle_c && handle_key_u()[0] - handle_open[0] / 2 >= 2.5
       && min([for (dx = handle_screw_dx) min(dx - handle_key_u()[0], handle_key_u()[1] - dx) - insert_hole_d / 2]) >= insert_w_min,
       "Handle key outside the flat foot face or too thin around the inserts");
assert(handle_screw_dx[0] - insert_hole_d / 2 - handle_open[0] / 2 >= 2 && handle_len / 2 - handle_screw_dx[1] - insert_hole_d / 2 >= 2,
       "Handle feet too thin around the inserts");
assert(logo_x0 > fan_cx + grille_r + 3 && logo_x0 + logo_w < body_w - corner_r - 2 && logo_top < body_h - corner_r - 2,
       "Logo outside the free front area");
assert(big_gap >= 2, "Big letters too wide for the second line");
assert(sub_stroke >= 1.2 && stencil_gap >= 1.2, "Logo lines or gaps below 1.2 mm");
assert(len(dedication_size) == len(dedication) && len(dedication_z) == len(dedication)
       && dedication_z[len(dedication) - 1] - dedication_size[len(dedication) - 1] / 4 > shelf_z + shelf_t + pwm_standoff + pwm_pcb[2] + pwm_comp_h + 1
       && dedication_z[0] + dedication_size[0] < led_xz[1] - led_boss[0] / 2 - 1
       && min([for (i = [1:len(dedication) - 1]) dedication_z[i - 1] - dedication_size[i - 1] / 4 - (dedication_z[i] + 0.75 * dedication_size[i])]) >= 1, "Dedication hidden behind the PWM board or runs into the LED boss");
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

module body() difference() {
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
        along_y(front_t - eps, front_t + dedication_h) dedication_2d();   // dedication on the inside of the front plate, grey in print
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
            translate([bat_cx - bat_d / 2 - bat_bms[1] - bat_clear, bat_cy - bat_bms[0] / 2 - bat_clear, z - 1])
                cube([bat_bms[1] + bat_clear + bat_d / 2, bat_bms[0] + 2 * bat_clear, cradle_t + 2]);
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
        // inner bosses for the service cover inserts, 45 degree cone to the wall towards the front (printable)
        for (p = cover_screws()) let (xb = body_w - cover_ins_depth - 1.5, rise = body_w - wall - xb) hull() {
            cyl_x(p, xb, body_w - wall + eps, boss_d / 2);
            translate([body_w - wall, p[0] - boss_d / 2 - rise, p[1] - boss_d / 2]) cube([1, eps, boss_d]);
        }
        // doubler and three ribs under each handle foot, from the front plate to the back lip: carry drop and pull loads of
        // the handle into the front plate and the walls; 45 degree ends of the doubler towards the top wall
        for (sx = [-1, 1]) let (u = handle_pad_u(), x0 = handle_cx + (sx > 0 ? u[0] : -u[1]), x1 = handle_cx + (sx > 0 ? u[1] : -u[0]),
                                zt = body_h - wall, tp = handle_pad[0]) {
            along_y(front_t - eps, part_y1) polygon([[x0 - tp, zt + eps], [x1 + tp, zt + eps], [x1, zt - tp], [x0, zt - tp]]);
            for (uc = [u[0] + handle_rib[0] / 2, (handle_screw_dx[0] + handle_screw_dx[1]) / 2, u[1] - handle_rib[0] / 2])
                translate([handle_cx + sx * uc - handle_rib[0] / 2, front_t - eps, zt - handle_rib[1]]) cube([handle_rib[0], part_y1 - front_t + eps, handle_rib[1] + eps]);
        }
        // two ribs on the shelf carry the PWM board; they start at the front plate (printable)
        for (x = [body_w - wall - pwm_wall_gap - pwm_pcb[0] + 1, body_w - wall - pwm_wall_gap - 5])
            translate([x, front_t - eps, shelf_z + shelf_t - eps]) cube([3, pot_yz[0] + pwm_pcb[1] / 2 - front_t, pwm_standoff + eps]);
        // charge/boost module standing upright: board back on two pads (tape), lower short edge on a ledge behind the
        // part side; 45 degree cones towards the front (printable)
        let (xb = part_x - chg_gap - chg_pcb[2], zb = chg_z - chg_pcb[0] / 2) {
            for (pd = chg_pads) hull() {
                translate([xb + chg_pcb[2], chg_y0 + 1, zb + pd[0]]) cube([chg_gap + eps, chg_pcb[1] - 2, pd[1]]);
                translate([part_x, chg_y0 + 1 - chg_gap, zb + pd[0]]) cube([1, eps, pd[1]]);
            }
            let (x0 = xb + chg_ledge[1], reach = part_x - x0) hull() {
                translate([x0, chg_y0 - 1, zb - chg_ledge[0]]) cube([reach + eps, chg_pcb[1] + 2, chg_ledge[0]]);
                translate([part_x, chg_y0 - 1 - reach, zb - chg_ledge[0]]) cube([1, eps, chg_ledge[0]]);
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
        let (x0 = usbc_xz[0] - usbc[1] / 2, ys = usbc_y0 - usbc_cl, z0 = usbc_xz[1] - usbc[2] / 2) hull() {
            translate([x0, ys - usbc_stop, z0]) cube([bay_x1 - x0 + eps, usbc_stop, usbc[2]]);
            translate([bay_x1, ys - usbc_stop - (bay_x1 - x0), z0]) cube([eps, eps, usbc[2]]);
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
    // cable notch at the back edge of the partition
    translate([part_x - 1, part_y1 - 14, 120]) cube([part_t + 2, 15, 12]);
    // battery cable slot through the shelf; the shelf rim still stops the battery upwards
    translate([bat_cx + 10 - cable_slot_w / 2, bat_cy - 6, shelf_z - 1]) cube([cable_slot_w, shelf_d + front_t - bat_cy + 7, shelf_t + 2]);
    along_x(-1, wall + 1) intake_slots_side();
    cyl_x(pot_yz, body_w - wall - 1, body_w + 1, (pot_bush[0] + 0.4) / 2);   // potentiometer bushing, nutted to the wall
    for (p = handle_screws()) translate([p[0], p[1], body_h - wall - handle_pad[0] - 1]) cylinder(d = screw_clear_d, h = wall + handle_pad[0] + 2);
    // recesses for the keys under the handle feet, 45 degree side walls along y
    for (sx = [-1, 1]) let (u = handle_key_u(), x0 = handle_cx + (sx > 0 ? u[0] : -u[1]) - handle_key[1], lx = u[1] - u[0] + 2 * handle_key[1],
                            hw = handle_key_w / 2 + handle_key[1], d = handle_key[0] + handle_key[1]) hull() {
        translate([x0, handle_cy - hw + d, body_h - d]) cube([lx, 2 * (hw - d), eps]);
        translate([x0, handle_cy - hw - 1, body_h + 1]) cube([lx, 2 * (hw + 1), eps]);
    }
    for (p = cover_screws()) cyl_x(p, body_w - cover_ins_depth, body_w + 1, insert_hole_d / 2);   // cover inserts, pressed in from outside
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
    translate([(bay_x0 + bay_x1) / 2, dedication_z[i]]) mirror([1, 0]) offset(delta = dedication_bold)
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
            translate([bat_cx - bat_d / 2 - bat_bms[1] - bat_clear, bat_cy - 1, z - 1])
                cube([bat_bms[1] + bat_clear + bat_d / 2, bat_bms[0] / 2 + bat_clear + 1, cradle_t + 2]);
        }
        // channel for the USB-C module on the inside, open towards the bay and at the top (wires)
        let (x0 = usbc_xz[0] - usbc[1] / 2 - usbc_cl, z0 = usbc_xz[1] - usbc[2] / 2 - usbc_cl) difference() {
            translate([x0 - usbc_wall, usbc_y0 + 2, z0 - usbc_wall]) cube([usbc[1] + 2 * (usbc_cl + usbc_wall), y1 - usbc_y0 - 2 + eps, usbc[2] + 2 * usbc_cl + usbc_wall]);
            translate([x0, usbc_y0 - 1, z0]) cube([usbc[1] + 2 * usbc_cl, y1 - usbc_y0 + 2, usbc[2] + 2 * usbc_cl + 1]);
        }
    }
    along_y(y1 - 1, body_d + 1) intake_slots_back();
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
module cover_2d(inset = 0) translate([cover_y, cover_z]) rrect([cover_w - 2 * inset, cover_hgt - 2 * inset], max(cover_r - inset, 0.5));
module cover() difference() {
    x0 = body_w;
    x1 = body_w + cover_out;
    union() {
        difference() {
            hull() {
                along_x(x0, x1 - edge_c) cover_2d();
                along_x(x1 - eps, x1) cover_2d(edge_c);
            }
            along_x(x0 - 1, x1 - cover_t) cover_2d(cover_t);
        }
        for (p = cover_screws()) cyl_x(p, x0, x1 - cover_t + eps, cover_boss_d / 2);
    }
    for (p = cover_screws()) {   // screws from outside, heads recessed in the outer face
        cyl_x(p, x0 - 1, x1 + 1, screw_clear_d / 2);
        cyl_x(p, x1 - head_pocket[1], x1 + 1, head_pocket[0] / 2);
    }
    cyl_x(pot_yz, x1 - cover_t - 1, x1 + 1, knob_stem_d / 2 + knob_stem_cl);   // knob stem
}
module cover_print_pose() translate([0, 0, body_w + cover_out]) rotate([0, 90, 0]) children();   // outer face on the bed

// ---------- speed knob ----------
module d_profile(d, flat) intersection() { circle(d = d); translate([-d / 2, -d / 2]) square([flat, d]); }   // flat on +x
module knob_local() difference() {   // z = 0 at the stem end, cap top face at knob_len
    s = knob_cap_z - knob_stem_z;
    union() {
        cylinder(d = knob_stem_d, h = s + eps);
        translate([0, 0, s]) {
            cylinder(d = knob_d, h = knob_h - knob_c);
            translate([0, 0, knob_h - knob_c - eps]) cylinder(d1 = knob_d, d2 = knob_d - 2 * knob_c, h = knob_c + eps);
        }
    }
    for (i = [0:knob_flutes - 1]) rotate(i * 360 / knob_flutes)   // fine grip flutes, open at the underside of the cap
        translate([knob_d / 2 - 0.5, -0.5, s - 1]) cube([2, 1, knob_h - knob_c]);
    translate([0, 0, -eps]) linear_extrude(knob_bore_top + eps) offset(delta = knob_bore_cl) d_profile(pot_shaft[0], pot_shaft[1]);
    translate([knob_d / 2 - knob_c - 7, -0.6, knob_len - 0.6]) cube([6, 1.2, 1]);   // short pointer near the edge, towards the flat
}
module knob() translate([body_w + knob_stem_z, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) knob_local();
module knob_print_pose() translate([0, 0, knob_len]) mirror([0, 0, 1]) children();   // top face on the bed
module pot_local(nut = true) {       // z = 0 at the outer face of the right wall
    translate([0, 0, -wall - pot_body[1]]) cylinder(d = pot_body[0], h = pot_body[1]);
    translate([0, 0, -wall - eps]) cylinder(d = pot_bush[0], h = pot_bush[1] + eps);
    if (nut) cylinder(d = pot_nut[0], h = pot_nut[1]);
    translate([0, 0, -wall + pot_bush[1] - 1]) linear_extrude(pot_shaft[2] + wall - pot_bush[1] + 1) d_profile(pot_shaft[0], pot_shaft[1]);
}
module pot_env(nut = true) translate([body_w, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) pot_local(nut);
module pot_nut_env() translate([body_w, pot_yz[0], pot_yz[1]]) orient([1, 0, 0]) difference() {
    cylinder(d = pot_nut[0], h = pot_nut[1]);
    translate([0, 0, -1]) cylinder(d = pot_bush[0] + 0.1, h = pot_nut[1] + 2);
}
module led_env() {                   // 3 mm LED: body in the pocket, flange on the boss
    cyl_y(led_xz, led_skin + 0.3, led_boss[1], led_d / 2);
    cyl_y(led_xz, led_boss[1], led_boss[1] + 1, 1.9);
}
module usbc_stadium(y0, y1, grow) along_y(y0, y1) translate(usbc_xz) hull()
    for (s = [-1, 1]) translate([s * (usbc_shell[0] - usbc_shell[1]) / 2, 0]) circle(d = usbc_shell[1] + 2 * grow);
module usbc_env() {                 // PD trigger: board with parts up to the thinned back cover, receptacle through it
    translate([usbc_xz[0] - usbc[1] / 2, usbc_y0, usbc_xz[1] - usbc[2] / 2]) cube([usbc[1], usbc[0] - usbc_plate, usbc[2]]);
    usbc_stadium(body_d - usbc_plate - eps, body_d, 0);
}
module chg_module_env() {            // board upright on the partition, parts and heatsinks towards the fan section
    x0 = part_x - chg_gap - chg_pcb[2];
    z0 = chg_z - chg_pcb[0] / 2;
    translate([x0, chg_y0, z0]) cube([chg_pcb[2], chg_pcb[1], chg_pcb[0]]);
    translate([x0 - chg_comp_h, chg_y0, z0]) cube([chg_comp_h + eps, chg_pcb[1], chg_pcb[0]]);   // parts up to the edges
    for (i = [0, 1]) translate([x0 - chg_comp_h - chg_sink[2], chg_y0 + (chg_pcb[1] - chg_sink[1]) / 2,
                                z0 + (chg_pcb[0] - 2 * chg_sink[0] - chg_sink[3]) / 2 + i * (chg_sink[0] + chg_sink[3])])
        cube([chg_sink[2] + eps, chg_sink[1], chg_sink[0]]);
}
module pwm_board_env() {             // board on the ribs, parts behind the potentiometer
    x1 = body_w - wall - pwm_wall_gap;
    translate([x1 - pwm_pcb[0], pot_yz[0] - pwm_pcb[1] / 2, shelf_z + shelf_t + pwm_standoff]) {
        cube([pwm_pcb[0], pwm_pcb[1], pwm_pcb[2]]);
        translate([0, 0, pwm_pcb[2] - eps]) cube([pwm_pcb[0] - pot_body[1], pwm_pcb[1], pwm_comp_h + eps]);
    }
}

// ---------- handle ----------
function handle_outer() = let (l = handle_len / 2, e = handle_end)
    [[-l, 0], [l, 0], [l, e[1]], [l - e[0], handle_h], [-l + e[0], handle_h], [-l, e[1]]];
function handle_opening() = let (o = handle_open)
    [[-o[0] / 2, -1], [o[0] / 2, -1], [o[0] / 2, o[2]], [o[1] / 2, handle_h - handle_bar], [-o[1] / 2, handle_h - handle_bar], [-o[0] / 2, o[2]]];
module handle() translate([handle_cx, 0, body_h]) difference() {   // side profile in (x, z), bevelled on both faces
    y0 = handle_cy - handle_d / 2;
    y1 = handle_cy + handle_d / 2;
    c = handle_c;
    union() {
        hull() {
            along_y(y0, y0 + eps) offset(delta = -c) polygon(handle_outer());
            along_y(y0 + c, y1 - c) polygon(handle_outer());
            along_y(y1 - eps, y1) offset(delta = -c) polygon(handle_outer());
        }
        // keys under the feet, 45 degree side faces along y (printable lying on the front face)
        for (sx = [-1, 1]) let (u = handle_key_u(), x0 = sx > 0 ? u[0] : -u[1], lx = u[1] - u[0], hw = handle_key_w / 2, k = handle_key[0]) hull() {
            translate([x0, handle_cy - hw, -eps]) cube([lx, 2 * hw, 2 * eps]);
            translate([x0, handle_cy - hw + k, -k]) cube([lx, 2 * (hw - k), eps]);
        }
    }
    along_y(y0 - 1, y1 + 1) polygon(handle_opening());
    hull() {
        along_y(y0 - eps, y0) offset(delta = c) polygon(handle_opening());
        along_y(y0 + c, y0 + c + eps) polygon(handle_opening());
    }
    hull() {
        along_y(y1 - c - eps, y1 - c) polygon(handle_opening());
        along_y(y1, y1 + eps) offset(delta = c) polygon(handle_opening());
    }
    for (sx = [-1, 1], dx = handle_screw_dx) translate([sx * dx, handle_cy, -handle_key[0] - eps]) cylinder(d = insert_hole_d, h = handle_ins_depth + eps);
}
module handle_print_pose() translate([0, 0, -(handle_cy - handle_d / 2)]) rotate([90, 0, 0]) children();   // front face on the bed

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
module screws_cover(socket = false) for (p = cover_screws()) translate([body_w + cover_out - head_pocket[1], p[0], p[1]]) orient([-1, 0, 0]) screw(len_cover, socket);
module screws_feet(socket = false) for (p = foot_screws()) translate([p[0], p[1], -foot_lift + foot_head_recess + screw_head_h]) orient([0, 0, 1]) screw(len_foot, socket);
module screws_handle(socket = false) for (p = handle_screws()) translate([p[0], p[1], body_h - wall - handle_pad[0]]) orient([0, 0, 1]) screw(len_handle, socket);

module assembly(explode = 0) {
    body_install_pose() {
        color("#f2f2ee") body_piece("base");
        color("#8f9396") body_piece("label");
        color("#8f9396") body_piece("dedication");
    }
    color("#8f9396") translate([0, -explode, 0]) grille();
    color("#f2f2ee") translate([0, 2 * explode, 0]) back();
    color("#8f9396") translate([explode, 0, 0]) cover();
    color("#8f9396") translate([0, 0, explode]) handle();
    color("#222326") translate([0, 0, -explode / 2]) place_feet();
    color("#26282b") translate([0, 0, -explode]) screws_feet(true);
    color("#8f9396") translate([2 * explode, 0, 0]) knob();
    color("#3a3d41") translate([explode, 0, 0]) pot_env();
    color("#2e6b3f") translate([explode, 0, 0]) pwm_board_env();
    color("#c9c9c9") translate([0, explode, 0]) chg_module_env();
    color("#4b2a7a") translate([0, 2 * explode, 0]) usbc_env();
    color("#303236") translate([0, explode, 0]) fan_visual();
    color("#3f7fbf") translate([0, explode / 2, 0]) battery_env();
}

// ---------- branches: the tools check that print_project.py PARTS matches them ----------
if      (part == "assembly") assembly();
else if (part == "exploded") assembly(40);
else if (part == "metrics") echo("PROJECT_METRICS", [
    ["wall", wall], ["front_t", front_t], ["back_t", back_t], ["corner_r", corner_r], ["body_mm", [body_w, body_d, body_h]],
    ["fan_size", fan_size], ["fan_pad", fan_pad], ["fan_t", fan_t], ["fan_pitch", fan_pitch], ["fan_hole_d", fan_hole_d],
    ["fan_blade_d", fan_blade_d], ["pot_shaft_len", pot_shaft[2]], ["pwm_pcb", pwm_pcb], ["pot_axis_h", pot_axis_h], ["knob_shaft_engagement", pot_shaft[2] - knob_stem_z], ["knob_top_skin", knob_len - knob_bore_top], ["knob_protrusion", knob_cap_z + knob_h - cover_out], ["handle_clearance", handle_h - handle_bar], ["handle_open_top", handle_open[1]], ["handle_mount_wall", wall + handle_pad[0]], ["foot_clearance", foot_cl], ["foot_lift", foot_lift], ["fan_axis", [fan_cx, fan_cz]], ["fan_y", fan_y], ["shroud_r", [open_r, open_r + shroud_t]], ["shroud_gap", shroud_gap], ["open_d", 2 * open_r], ["grille_gap", grille_gap],
    ["bat_mm", [bat_d, bat_l]], ["bat_bms", bat_bms], ["bat_clear", bat_clear], ["saddle_gap", saddle_gap], ["cradle_rings", len(cradle_z)], ["shelf_gap", shelf_gap],
    ["lip_clearance", lip_cl], ["spigot_clearance", spigot_cl],
    ["insert_hole_d", insert_hole_d], ["insert_w_min", insert_w_min], ["mount_insert", mount_insert], ["mount_floor", mount_floor], ["insert_len", insert_len], ["insert_depth", insert_depth],
    ["screws", screw_table],
    // insert pockets: [assembly body, opening point, direction into the material, depth]
    ["inserts", concat(
        [for (p = grille_screws()) ["body", [p[0], front_t + grille_boss_h, p[1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (p = fan_holes()) ["body", [p[0], fan_y - fan_pad, p[1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (b = back_bosses()) ["body", [b[0][0], body_d - back_t, b[0][1]], [0, -1, 0], insert_depth, insert_hole_d, insert_w_min]],
        [for (p = cover_screws()) ["body", [body_w, p[0], p[1]], [-1, 0, 0], cover_ins_depth, insert_hole_d, insert_w_min]],
        [for (p = handle_screws()) ["handle", [p[0], p[1], body_h - handle_key[0]], [0, 0, 1], handle_ins_depth, insert_hole_d, insert_w_min]],
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
else if (part == "handle") handle_print_pose() handle();
else if (part == "knob") knob_print_pose() knob_local();
else if (part == "foot") foot_print_pose() foot();
