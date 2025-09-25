$fn = 16;

// Prusa Core One side cavity dimensions
front_width = 282;
back_width = 240;
back_elevation = 5.5;
depth = 65;

// Existing model for comparison
%translate([front_width/2,depth/2,0])
  import("side-storage.stl");

// Gridfinity
square_width = 42;

// Parameters
plate_min_thickness = 0.75;
n_squares = 5;

// Shorthands
tray_width = n_squares * square_width;

// Wedge dimensions (left side)
wedge_back_width = (back_width - tray_width) / 2;
wedge_front_width = (front_width - tray_width) / 2;

module left_wedge () {
	
}

left_wedge();
