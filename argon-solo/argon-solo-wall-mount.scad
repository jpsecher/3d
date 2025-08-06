$fn = 32;

thickness = 2.65;
length = 147;
height = 31.5;
gap = 101.5;
gap_height = 24;

corner_radius = 18.5;
foot_dia = 18.5;


module plate_2d () {
	// Only a slim lip for now to test support
	difference () {
		union () {
			square([gap, foot_dia]);
			translate([foot_dia,foot_dia,0])
				circle(foot_dia - 2*thickness);
			translate([foot_dia,thickness,0])
				square([gap - 2*foot_dia, length / 2]);
		}
		translate([0,15,0])
			circle(d=foot_dia+2);
	}
}

plate_2d();

module pole () {
		cube([thickness, thickness, gap_height]);
		translate([0,-thickness,-thickness])
			cube([thickness, thickness, height + 2*thickness]);
		translate([0,0,height + thickness/2])
			rotate([0,90,0])
				cylinder(thickness, thickness/2, thickness/2);
}

module support () {
	union () {
		#linear_extrude(thickness)
			plate_2d();
		%cube([gap, thickness, thickness*2]);
		%translate([0,0,thickness])
			pole();
		translate([thickness,0,0])
			cylinder(2*thickness, thickness, thickness);
		translate([gap - thickness,0,thickness])
			pole();
		translate([gap - thickness,0,0])
			cylinder(2*thickness, thickness, thickness);
	}
}

*support();
