$fn = 16;

use <threads.scad>

rod_diameter = 30;
thread_pitch = 6;
wall_thickness = 3;
test_height = 14;
chamfer_size = 2;

outer_diameter = rod_diameter + (2 * wall_thickness);

difference() {
    // Outer cylinder
    cylinder(h=test_height, d=outer_diameter, $fn=60);

    // Internal threaded hole (goes all the way through)
    translate([0, 0, -0.1])
        ScrewHole(outer_diam=rod_diameter, height=test_height+0.2, 
                  pitch=thread_pitch, tolerance=0.4) 
            cylinder(h=test_height+0.2, d=rod_diameter, $fn=60);

    // Entry chamfer (top)
    translate([0, 0, test_height-chamfer_size])
        cylinder(h=chamfer_size+0.1, d1=rod_diameter, d2=rod_diameter+2*chamfer_size, $fn=60);

    // Entry chamfer (bottom)
    translate([0, 0, -0.1])
        cylinder(h=chamfer_size+0.1, d1=rod_diameter+2*chamfer_size, d2=rod_diameter, $fn=60);
}
