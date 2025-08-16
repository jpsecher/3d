$fn = 32;

use <../lib/bosl2-0-716/std.scad>

screw_separation = 73;
screw_head = 9;  // 1 mm slack
screw_dia = 4;  // 1 mm slack
screw_protrution = 5.5;

length = 147;
height = 31.5;
gap = 101.5;
gap_height = 24;

corner_radius = 18.5;
foot_dia = 18.5;
foot_height = 3.6;

thickness = 2.65;
rounder = 2;

module screw_hole () {
	union() {
		circle(d=screw_head);
		translate([0,screw_head/2,0])
		  square(screw_dia, center=true);
		translate([0,screw_head/2 + screw_dia/2,0])
		  circle(d=screw_dia);
	}
}

module plate_2d () {
	// must cover all legs.
	difference() {
		translate([rounder,rounder,0])
			minkowski() {
				square([gap - 2*rounder, length / 1.2]);
				circle(rounder);
			}
		translate([(gap - screw_separation)/2,length/1.5 - 10,0])
			union() {
				screw_hole();
				translate([screw_separation,0,0]) screw_hole();				
			}
		translate([51,112,0])
		  grid_copies(foot_dia/2, n=[9,2])
				square(foot_dia/2 - rounder, center=true);
		translate([51,91,0])
		  grid_copies(foot_dia/2, n=[5,2])
				square(foot_dia/2 - rounder, center=true);
		translate([51,42,0])
		  grid_copies(foot_dia/2, n=[9,8])
				square(foot_dia/2 - rounder, center=true);
	}
}

*plate_2d();


module pole () {
		cube([thickness, thickness, foot_height + gap_height]);
		translate([0,-thickness,-thickness])
			cube([thickness, thickness, foot_height + height + 2*thickness]);
		#translate([0,0,foot_height + height + thickness])
			rotate([0,90,0])
				cylinder(thickness, thickness, thickness);
}

module support () {
	union () {
		linear_extrude(thickness)
			plate_2d();
		cube([gap, thickness, foot_height + thickness*3]);
		translate([0,0,thickness])
			pole();
		translate([thickness,0,0])
			cylinder(2*thickness, thickness, thickness);
		translate([gap - thickness,0,thickness])
			pole();
		translate([gap - thickness,0,0])
			cylinder(2*thickness, thickness, thickness);
	}
}

support();
