$fn = 16;

use <threads.scad>

rod_diameter = 30;
inner_diameter = 25;
thread_pitch = 6;
wall_thickness = 3;
test_height = 18;
chamfer_size = 1;
tolerance = 0.4;

outer_diameter = rod_diameter + (2 * wall_thickness);

difference() {
    ScrewHole(outer_diam=rod_diameter, height=test_height+0.2, 
              pitch=thread_pitch, tolerance=tolerance) 
        cylinder(h=test_height, d=outer_diameter, $fn=60);

    translate([0, 0, -0.1])
        cylinder(h=test_height+0.2, d=inner_diameter+tolerance, $fn=60);
    // chamfer (top)
    // translate([0, 0, test_height-chamfer_size])
    //     cylinder(h=chamfer_size+0.1, d1=rod_diameter+tolerance, d2=rod_diameter+2*chamfer_size+tolerance, $fn=60);
    // chamfer (bottom)
    // translate([0, 0, -0.1])
    //     cylinder(h=chamfer_size+0.1, d1=rod_diameter+2*chamfer_size+tolerance, d2=rod_diameter+tolerance, $fn=60);
}
