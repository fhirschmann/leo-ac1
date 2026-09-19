// LEO-AC1: battery fan styled like the outdoor unit of an air conditioner, 120 mm PC fan,
// 3.2 V 6000 mAh LiFePO4 pack. Skill openscad-print-project. Units mm, Z up.
// Installed frame: x = width (left to right seen from the front), y = depth (front face at y = 0,
// back face at y = body_d), z = height (underside of the body at z = 0).
// Modules build every part in its INSTALLED position; the part branches at the end put each print
// part into PRINT orientation (largest flat face on the bed at z = 0). The tools set `part`.

part = "assembly";   // print part, "body_base" / "body_label", "assembly", "exploded", "metrics", "none"
$fa = 2;
$fs = 0.6;
eps = 0.01;

/* [Body] */
body_w = 225;        // outer width (x); proportions of an 800 x 550 x 285 mm outdoor unit
body_h = 155;        // outer height (z)
body_d = 80;         // outer depth (y) without grille and service cover
wall = 2.4;          // side, top and bottom walls, six 0.4 mm lines
front_t = 2.4;       // front plate
corner_r = 3;        // corner radius seen from the front
edge_c = 1;          // 45 degree chamfer on the bed edges (front of the body, back of the cover)
part_x = 152;        // left face of the partition between fan section and electronics bay
part_t = 2;
inner_c = 3;         // 45 degree fillet between front plate and walls (stiffness, printable)

/* [Fan, 120 mm PC fan] */
fan_size = 120;
fan_t = 25;
fan_pitch = 105;     // mounting hole spacing
fan_hole_d = 4.3;
fan_blade_d = 116;   // swept blade diameter (typical)
fan_cx = 84;         // fan axis x
fan_cz = body_h / 2; // fan axis z
fan_standoff = 8;    // bosses between front plate and fan frame
fan_boss_d = 9;
shroud_t = 1.6;      // round duct front plate -> fan frame, bore = grille opening: air leaves only through the grille
shroud_gap = 0.2;    // duct end to the fan frame face

/* [Grille] */
open_r = 59;         // opening in the front plate
grille_r = 68;       // outer radius of the grille ring
grille_t = 3;        // ring in front of the front plate
grille_depth = 3;    // bars reach this far behind the front face
spigot_t = 2;        // locating collar inside the opening
spigot_w = 2.2;
spigot_cl = 0.3;     // radial clearance of the collar
grille_bar = 2;      // ring and spoke width
grille_hub_r = 8;
grille_rings = 6;
grille_spokes = 8;
grille_screw_r = 63.5;
grille_screw_a0 = 22.5;  // screw angles between the spokes
grille_boss_d = 8.4;
grille_boss_h = 7.6; // behind the front plate, stays below fan_standoff

/* [Back cover] */
back_t = 2.4;
lip_h = 4;           // lip reaching into the body
lip_t = 2.4;
lip_cl = 0.25;       // clearance per side between lip and body wall
boss_d = 8;          // screw bosses for inserts (back, service cover)
boss_inset = 6.5;    // back bosses: axis distance from the outer edges
back_boss_len = 12;
gusset = 14;         // 45 degree cone below the back bosses in print orientation
slot_w = 1.6;        // intake slots, back and left side
slot_pitch = 3.2;

/* [Battery, 3.2 V 6000 mAh LiFePO4 pack] */
bat_d = 35;          // 32700 cell, label "3,4 x 7 cm" incl. protection board; envelope with tolerance
bat_l = 72;          // the cable leaves at one end: that end up, through the shelf slot
cable_slot_w = 10;   // slot in the shelf above the battery, open towards the back
bat_cx = 180;
bat_clear = 0.5;     // radial clearance in the cradle
bat_front_gap = 3.5; // front plate to battery, clears the inner fillet
bat_retain_gap = 1;  // retaining ribs on the back cover to battery
cradle_z = [12, 52]; // lower faces of the two cradle ribs
cradle_t = 2.4;
retain_z = [22, 46]; // lower faces of the two retaining ribs
retain_t = 3;
retain_w = 24;
shelf_gap = 3;       // battery top to electronics shelf (cable, protection board)
shelf_t = 2.4;
shelf_d = 50;        // shelf depth from the front plate

/* [Service cover, right side] */
cover_y = 57;        // centre
cover_z = 70;
cover_w = 34;        // along y
cover_hgt = 84;      // along z
cover_out = 11;      // protrusion
cover_t = 2;
cover_r = 4;
cover_screw_dz = 28;

/* [Handle, top] */
handle_len = 150;      // along x
handle_h = 34;         // above the top wall
handle_d = 20;         // along y
handle_cx = body_w / 2;
handle_cy = body_d / 2;
handle_bar = 12;       // grip thickness (z)
handle_open = [96, 76, 12];  // opening: width at the bottom, width at the top, height of its vertical sides
handle_end = [15, 8];  // outer ends: slant inset at the top, height of the vertical foot face
handle_c = 2.5;        // 45 degree bevels on all edges
handle_screw_dx = [54, 69];  // screw axes from the handle centre, both sides

/* [Screws, M3 heat-set inserts] */
insert_hole_d = 4.0; // Ruthex M3 x 5.7
insert_len = 5.7;
insert_depth = 6.5;  // pocket depth
screw_clear_d = 3.4;
csk_d = 6.4;         // countersink at the surface, 90 degrees
screw_head_d = 5.5;  // pan / socket head
screw_head_h = 3;
len_grille = 12;     // M3 x 12 countersunk, from the front
len_fan = 30;        // M3 x 30 socket head, from behind the fan
len_back = 8;        // M3 x 8 countersunk, from the back
len_cover = 8;       // M3 x 8 socket head, from inside the body
len_handle = 8;      // M3 x 8 socket head, from inside the body

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

// ---------- derived values ----------
logo_w = text_w(brand_sub, sub_size, sub_stroke, sub_gap);
big_gap = (logo_w - text_w(brand, big_size, big_stroke, 0)) / (len(brand) - 1);
logo_x0 = logo_cx - logo_w / 2;
logo_bottom = logo_top - big_size[1] - 2 * (line_gap + sub_size[1]);
fan_y = front_t + fan_standoff;                       // front face of the fan frame
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
function handle_screws() = [for (sx = [-1, 1], dx = handle_screw_dx) [handle_cx + sx * dx, handle_cy]];
function cover_screws() = [for (s = [-1, 1]) [cover_y, cover_z + s * cover_screw_dz]];
// thread engagement in the insert and margin of the screw tip to the pocket end
screw_table = [
    // name, length, engagement, tip margin
    ["grille", len_grille, (-grille_t + len_grille) - (front_t + grille_boss_h - insert_len),
     (front_t + grille_boss_h) - (-grille_t + len_grille)],
    ["fan", len_fan, fan_y - max(fan_y + fan_t - len_fan, fan_y - insert_len),
     (fan_y + fan_t - len_fan) - (fan_y - insert_depth)],
    ["back", len_back, (body_d - back_t) - max(body_d - len_back, body_d - back_t - insert_len),
     (body_d - len_back) - (body_d - back_t - insert_depth)],
    ["cover", len_cover, min(len_cover - wall, insert_len), insert_depth - (len_cover - wall)],
    ["handle", len_handle, min(len_handle - wall, insert_len), insert_depth - (len_handle - wall)]];

assert(wall >= 3 * 0.4 && front_t >= 3 * 0.4 && back_t >= 3 * 0.4, "Walls need at least three perimeters");
// heat-set inserts need material between pocket and visible face, otherwise the face deforms when pressing
assert(front_t + grille_boss_h - insert_depth >= 3, "Grille insert pocket too close to the front face");
assert(fan_y - insert_depth >= 3, "Fan insert pocket too close to the front face");
assert(front_t + grille_boss_h <= fan_y - 0.3, "Grille bosses touch the fan");
assert(grille_depth <= fan_y - 2, "Grille bars too close to the fan");
assert(grille_gap <= 6, "Grille openings wider than 6 mm (finger safety)");
assert(ring_in - spigot_w > grille_hub_r + grille_rings * grille_bar, "Grille collar hits the rings");
assert(grille_screw_r - grille_boss_d / 2 > open_r, "Grille bosses reach into the opening");
assert(grille_r - (grille_screw_r + csk_d / 2) >= 1.2, "Grille ring too narrow outside the countersinks");
assert(fan_blade_d / 2 < open_r, "Front opening smaller than the fan blades");
assert(open_r < fan_size / 2 - 0.5, "Air duct does not sit on the fan frame face");
assert(fan_cx - open_r - shroud_t > wall + inner_c && fan_cx + open_r + shroud_t < part_x
       && fan_cz - open_r - shroud_t > wall + inner_c && fan_cz + open_r + shroud_t < body_h - wall - inner_c,
       "Air duct hits the walls or the partition");
assert(cover_out - insert_depth >= 3, "Cover insert pocket too close to the visible face");
assert(shelf_z + shelf_t < body_h - wall, "Shelf above the top wall");
assert(handle_h - handle_bar >= 20, "Handle opening too low for a hand");
assert(handle_end[1] > insert_depth && handle_open[2] > insert_depth, "Handle insert pockets reach the slants");
assert(handle_screw_dx[0] - insert_hole_d / 2 - handle_open[0] / 2 >= 2 && handle_len / 2 - handle_screw_dx[1] - insert_hole_d / 2 >= 2,
       "Handle feet too thin around the inserts");
assert(logo_x0 > fan_cx + grille_r + 3 && logo_x0 + logo_w < body_w - corner_r - 2 && logo_top < body_h - corner_r - 2,
       "Logo outside the free front area");
assert(big_gap >= 2, "Big letters too wide for the second line");
assert(sub_stroke >= 1.2 && stencil_gap >= 1.2, "Logo lines or gaps below 1.2 mm");
assert(front_t - groove_depth >= 1.2 && groove_pitch - groove_w >= 1.1, "Grooves too deep or webs too thin");
assert(groove_z0 + (groove_count - 1) * groove_pitch + groove_w < logo_bottom - 3, "Grooves run into the logo");
for (s = screw_table) assert(s[2] >= 4 && s[3] >= 0.3, str("Screw ", s[0], ": engagement ", s[2], ", tip margin ", s[3]));

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
module inlay_zone(d = inlay_t) translate([0, 0, -eps]) linear_extrude(d + eps) children();
module inlay_base(d = inlay_t) difference() { children(0); inlay_zone(d) children(1); }
module inlay_piece(d = inlay_t) intersection() { children(0); inlay_zone(d) children(1); }

// ---------- body ----------
module body_outline(inset = 0) translate([body_w / 2, body_h / 2]) rrect([body_w - 2 * inset, body_h - 2 * inset], max(corner_r - inset, 0.5));
module body_inner(extra = 0) body_outline(wall + extra);
module boss_footprint(b) hull() { translate(b[0]) circle(d = boss_d); rect(b[1], b[2]); }

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
    for (x = [14.8:slot_pitch:146], z = bars) slot2d([x, z[0] + slot_w / 2], [x, z[1] - slot_w / 2], slot_w);
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
        // round air duct from the front plate to the fan frame face
        difference() {
            cyl_y([fan_cx, fan_cz], front_t - eps, fan_y - shroud_gap, open_r + shroud_t);
            cyl_y([fan_cx, fan_cz], front_t - 1, fan_y, open_r);
        }
        // partition between fan section and electronics bay
        translate([part_x, front_t - eps, wall - eps]) cube([part_t, part_y1 - front_t + eps, body_h - 2 * wall + 2 * eps]);
        for (p = fan_holes()) cyl_y(p, front_t - eps, fan_y, fan_boss_d / 2);
        for (p = grille_screws()) cyl_y(p, front_t - eps, front_t + grille_boss_h, grille_boss_d / 2);
        for (b = back_bosses()) back_boss(b);
        // battery cradle ribs, open towards the back
        for (z = cradle_z) difference() {
            translate([bay_x0 - eps, front_t - eps, z]) cube([bay_x1 - bay_x0 + 2 * eps, bat_cy - front_t + eps, cradle_t]);
            translate([bat_cx, bat_cy, z - 1]) cylinder(r = bat_d / 2 + bat_clear, h = cradle_t + 2);
        }
        // electronics shelf, also stops the battery upwards
        translate([bay_x0 - eps, front_t - eps, shelf_z]) cube([bay_x1 - bay_x0 + 2 * eps, shelf_d + eps, shelf_t]);
    }
    cyl_y([fan_cx, fan_cz], -1, front_t + 1, open_r);
    for (i = [0:groove_count - 1]) let (z = groove_z0 + i * groove_pitch)
        along_y(-1, groove_depth) slot2d([groove_x[0] + groove_w, z], [groove_x[1] - groove_w, z], groove_w);
    for (p = grille_screws()) {
        cyl_y(p, -1, front_t + grille_boss_h, screw_clear_d / 2);
        cyl_y(p, front_t + grille_boss_h - insert_depth, front_t + grille_boss_h + 1, insert_hole_d / 2);
    }
    for (p = fan_holes()) cyl_y(p, fan_y - insert_depth, fan_y + 1, insert_hole_d / 2);
    for (b = back_bosses()) cyl_y(b[0], body_d - back_t - insert_depth, body_d + 1, insert_hole_d / 2);
    // cable notch at the back edge of the partition
    translate([part_x - 1, part_y1 - 14, 120]) cube([part_t + 2, 15, 12]);
    // battery cable slot through the shelf; the shelf rim still stops the battery upwards
    translate([bat_cx - cable_slot_w / 2, bat_cy - 6, shelf_z - 1]) cube([cable_slot_w, shelf_d + front_t - bat_cy + 7, shelf_t + 2]);
    along_x(-1, wall + 1) intake_slots_side();
    for (p = cover_screws()) cyl_x(p, body_w - wall - 1, body_w + 1, screw_clear_d / 2);
    for (p = handle_screws()) translate([p[0], p[1], body_h - wall - 1]) cylinder(d = screw_clear_d, h = wall + 2);
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
            cyl_y(p, -grille_t - eps, -grille_t + (csk_d - screw_clear_d) / 2, csk_d / 2, screw_clear_d / 2);
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
        for (z = retain_z) translate([bat_cx - retain_w / 2, bat_cy + bat_d / 2 + bat_retain_gap, z])
            cube([retain_w, y1 - (bat_cy + bat_d / 2 + bat_retain_gap) + eps, retain_t]);
    }
    along_y(y1 - 1, body_d + 1) intake_slots_back();
    for (b = back_bosses()) {
        cyl_y(b[0], body_d - (csk_d - screw_clear_d) / 2, body_d + eps, screw_clear_d / 2, csk_d / 2);
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
        for (p = cover_screws()) cyl_x(p, x0, x1 - cover_t + eps, boss_d / 2);
    }
    for (p = cover_screws()) cyl_x(p, x0 - 1, x0 + insert_depth, insert_hole_d / 2);
    // two grip grooves on the outer face (bed side in print), as on the original valve cover
    for (s = [-1, 1]) translate([x1 - 0.8, cover_y - cover_w / 2 + 6, cover_z + s * 8 - 1]) cube([1, cover_w - 12, 2]);
}
module cover_print_pose() translate([0, 0, body_w + cover_out]) rotate([0, 90, 0]) children();   // outer face on the bed

// ---------- handle ----------
function handle_outer() = let (l = handle_len / 2, e = handle_end)
    [[-l, 0], [l, 0], [l, e[1]], [l - e[0], handle_h], [-l + e[0], handle_h], [-l, e[1]]];
function handle_opening() = let (o = handle_open)
    [[-o[0] / 2, -1], [o[0] / 2, -1], [o[0] / 2, o[2]], [o[1] / 2, handle_h - handle_bar], [-o[1] / 2, handle_h - handle_bar], [-o[0] / 2, o[2]]];
module handle() translate([handle_cx, 0, body_h]) difference() {   // side profile in (x, z), bevelled on both faces
    y0 = handle_cy - handle_d / 2;
    y1 = handle_cy + handle_d / 2;
    c = handle_c;
    hull() {
        along_y(y0, y0 + eps) offset(delta = -c) polygon(handle_outer());
        along_y(y0 + c, y1 - c) polygon(handle_outer());
        along_y(y1 - eps, y1) offset(delta = -c) polygon(handle_outer());
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
    for (sx = [-1, 1], dx = handle_screw_dx) translate([sx * dx, handle_cy, -eps]) cylinder(d = insert_hole_d, h = insert_depth + eps);
}
module handle_print_pose() translate([0, 0, -(handle_cy - handle_d / 2)]) rotate([90, 0, 0]) children();   // front face on the bed

// ---------- bought parts: envelopes for the checks ----------
module fan_env() translate([fan_cx - fan_size / 2, fan_y, fan_cz - fan_size / 2]) cube([fan_size, fan_t, fan_size]);
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
module battery_env() translate([bat_cx, bat_cy, wall]) cylinder(d = bat_d, h = bat_l);

// Local +z = screw direction, z = 0 at the surface under the head. socket = hex key recess for the viewer,
// the checks use the plain envelope.
module screw(len, countersunk, socket = false) difference() {
    union() {
        if (countersunk) cylinder(r1 = screw_head_d / 2, r2 = 1.5, h = screw_head_d / 2 - 1.5);
        else translate([0, 0, -screw_head_h]) cylinder(d = screw_head_d, h = screw_head_h);
        cylinder(r = 1.5, h = len);
    }
    if (socket) translate([0, 0, (countersunk ? 0 : -screw_head_h) - eps])
        cylinder(d = (countersunk ? 2 : 2.5) / cos(30), h = countersunk ? 1 : 1.5, $fn = 6);
}
module screws_grille(socket = false) for (p = grille_screws()) translate([p[0], -grille_t, p[1]]) orient([0, 1, 0]) screw(len_grille, true, socket);
module screws_fan(socket = false) for (p = fan_holes()) translate([p[0], fan_y + fan_t, p[1]]) orient([0, -1, 0]) screw(len_fan, false, socket);
module screws_back(socket = false) for (b = back_bosses()) translate([b[0][0], body_d, b[0][1]]) orient([0, -1, 0]) screw(len_back, true, socket);
module screws_handle(socket = false) for (p = handle_screws()) translate([p[0], p[1], body_h - wall]) orient([0, 0, 1]) screw(len_handle, false, socket);
module screws_cover(socket = false) for (p = cover_screws()) translate([body_w - wall, p[0], p[1]]) orient([1, 0, 0]) screw(len_cover, false, socket);

module assembly(explode = 0) {
    body_install_pose() {
        color("#f2f2ee") inlay_base() { body_print_pose() body(); body_label_print_2d(); }
        color("#8f9396") inlay_piece() { body_print_pose() body(); body_label_print_2d(); }
    }
    color("#8f9396") translate([0, -explode, 0]) grille();
    color("#f2f2ee") translate([0, 2 * explode, 0]) back();
    color("#8f9396") translate([explode, 0, 0]) cover();
    color("#8f9396") translate([0, 0, explode]) handle();
    color("#303236") translate([0, explode, 0]) fan_visual();
    color("#3f7fbf") translate([0, explode / 2, 0]) battery_env();
}

// ---------- branches: the tools check that print_project.py PARTS matches them ----------
if      (part == "assembly") assembly();
else if (part == "exploded") assembly(40);
else if (part == "metrics") echo("PROJECT_METRICS", [
    ["wall", wall], ["front_t", front_t], ["back_t", back_t], ["body_mm", [body_w, body_d, body_h]],
    ["fan_size", fan_size], ["fan_t", fan_t], ["fan_pitch", fan_pitch], ["fan_hole_d", fan_hole_d],
    ["fan_blade_d", fan_blade_d], ["fan_axis", [fan_cx, fan_cz]], ["fan_y", fan_y], ["shroud_r", [open_r, open_r + shroud_t]], ["shroud_gap", shroud_gap], ["open_d", 2 * open_r], ["grille_gap", grille_gap],
    ["bat_mm", [bat_d, bat_l]], ["bat_clear", bat_clear], ["bat_retain_gap", bat_retain_gap], ["shelf_gap", shelf_gap],
    ["lip_clearance", lip_cl], ["spigot_clearance", spigot_cl],
    ["insert_hole_d", insert_hole_d], ["insert_len", insert_len], ["insert_depth", insert_depth],
    ["screws", screw_table],
    // insert pockets: [assembly body, opening point, direction into the material, depth]
    ["inserts", concat(
        [for (p = grille_screws()) ["body", [p[0], front_t + grille_boss_h, p[1]], [0, -1, 0], insert_depth]],
        [for (p = fan_holes()) ["body", [p[0], fan_y, p[1]], [0, -1, 0], insert_depth]],
        [for (b = back_bosses()) ["body", [b[0][0], body_d - back_t, b[0][1]], [0, -1, 0], insert_depth]],
        [for (p = cover_screws()) ["cover", [body_w, p[0], p[1]], [1, 0, 0], insert_depth]],
        [for (p = handle_screws()) ["handle", [p[0], p[1], body_h], [0, 0, 1], insert_depth]])]]);
else if (part == "none") {}
else if (part == "body") body_print_pose() body();
else if (part == "body_base") inlay_base() { body_print_pose() body(); body_label_print_2d(); }
else if (part == "body_label") inlay_piece() { body_print_pose() body(); body_label_print_2d(); }
else if (part == "back") back_print_pose() back();
else if (part == "grille") grille_print_pose() grille();
else if (part == "cover") cover_print_pose() cover();
else if (part == "handle") handle_print_pose() handle();
