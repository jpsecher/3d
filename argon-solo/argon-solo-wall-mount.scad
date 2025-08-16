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
	// must touch all legs.
	difference() {
		square([gap, length]);
		translate([(gap - screw_separation)/2,length/1.5 - 10,0])
			union() {
				screw_hole();
				translate([screw_separation,0,0]) screw_hole();				
			}
		translate([51,120,0])
		  grid_copies(13, n=[6,3])
				square(13 - rounder, center=true);
		translate([51,87.5,0])
		  grid_copies(13, n=[4,2])
				square(13 - rounder, center=true);
		translate([51,42,0])
		  grid_copies(13, n=[6,5])
				square(13 - rounder, center=true);
	}
}

*plate_2d();


module pole () {
		cube([thickness, thickness, foot_height + gap_height]);
		translate([0,-thickness,-thickness])
			cube([thickness, thickness, foot_height + height + 2*thickness]);
		translate([0,0,foot_height + height + thickness])
			rotate([0,90,0])
				cylinder(thickness, thickness, thickness);
}

module bottom_support () {
	union () {
		translate([0,0,thickness])
			pole();
		translate([thickness,0,0])
			cylinder(foot_height + 3*thickness, thickness, thickness);
		translate([thickness,0,foot_height + 3*thickness])
			sphere(thickness);
		translate([gap - thickness,0,thickness])
			pole();
		translate([gap - thickness,0,0])
			cylinder(foot_height + 3*thickness, thickness, thickness);
		translate([gap - thickness,0,foot_height + 3*thickness])
			sphere(thickness);
	}
}

module top_pole() {
	translate([0,0,thickness])
		union() {
			translate([0,-thickness,-thickness])
				cube([thickness, thickness, foot_height + height + 2*thickness]);
			translate([0,0,foot_height + height + thickness])
				rotate([0,90,0])
					cylinder(thickness, thickness, thickness);
		}
}

module top_support () {
	union() {
		top_pole();
		translate([thickness,-thickness,0])
			cube(thickness);
		translate([thickness,0,thickness])
			rotate([90,0,0])
				cylinder(thickness, thickness, thickness);
	}
	translate([gap - thickness,0,0])
		union() {
			top_pole();
			translate([-thickness,-thickness,0])
				cube(thickness);
			translate([0,0,thickness])
				rotate([90,0,0])
					cylinder(thickness, thickness, thickness);
		}
}

module holder () {
	union () {
		linear_extrude(thickness)
			plate_2d();
		cube([gap, thickness, foot_height + thickness*3]);
	  bottom_support();
		translate([gap,length,0])
			rotate([0,0,180])
			  top_support();
	}
}

holder();
