$fn = 16;

c_diameter = 27;
c_height = 19;
c_thickness = 3;
c_rounding = 1;

s_diameter = 9;
s_height = 25;
s_thickness = 2;
s_cut = 7;

c_radius = c_diameter / 2;
c_r_thick = c_thickness / 2;
s_radius = s_diameter / 2;
s_r_thick = s_thickness / 2;

module knob() {
    minkowski() {
        #difference() {
            cylinder(c_height, c_radius, c_radius);
            translate([0, 0, c_r_thick])
                cylinder(c_height, c_radius - c_r_thick, c_radius - c_r_thick);
        }
        sphere(c_rounding);
    }
}

module shaft() {
    difference() {
        union () {
            cylinder(s_height, s_radius, s_radius);
            translate([0, 0, s_height - 2]) union () {
                translate([0, 0, 1])
                    cylinder(1, s_radius + 1, s_radius);
                cylinder(1, s_radius, s_radius + 1);
            }
            cylinder(c_thickness, s_diameter, s_radius);
        }
        translate([0, 0, c_r_thick * 2])
            cylinder(s_height, s_radius - s_r_thick, s_radius - s_r_thick);
        translate([0, 0, s_height - s_cut])
            linear_extrude(s_cut + 1)
                square([s_diameter+3, 2],center=true);
    }
}

module assembly() {
    union () {
        knob();
        shaft();
    }
}

assembly();
