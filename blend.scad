// Socket blends (covers)

quality = 50;
epsilon = 0.1;
include <lib.scad>;

// switch_hole();
// earthed_plug_holes();
blend_one_one();

// one switch and one plug
module blend_one_one() {
  x = 86; y = 86; depth = 5;  wall = 3; thickness = 2.5;
  switch_offset = 32.5;
  plug_offset = 23;
  screw_offset = 35.6; screw_depth = 10;
  union() {
    difference() {
      blend_case(x, y, 8, depth, wall, thickness);
      translate([0, y/2 - switch_offset, -(depth+epsilon)])
        linear_extrude(depth+2*epsilon) switch_hole();
      translate([0, -y/2 + plug_offset, -(depth+epsilon)])
        linear_extrude(depth+2*epsilon) earthed_plug_holes();
      translate([0, -y/2 + screw_offset, (-depth+epsilon)])
        linear_extrude(depth+2*epsilon) screw_hole();
      translate([0, -y/2 + screw_offset, 0])
        screw_head();
    }
    translate([0, y/2 - switch_offset, -depth])
      linear_extrude(depth-thickness) difference() {
        scale([1.1,1.1]) switch_hole();
        switch_hole();
      };
    translate([0, -y/2 + screw_offset, -screw_depth])
      linear_extrude(screw_depth-thickness) difference() {
        circle(d=7.9);
        screw_hole();
      };
  }
}

module blend_case(x, y, r, depth, wall, thickness) {
  difference() {
    roundedCube(x, y, depth, r);
    translate([0, 0, -depth - thickness])
      linear_extrude(depth) roundedRect(x-2*wall, y-2*wall, r-wall);
  }
}

module blend_flat() {
  size = 86;
  difference() {
    roundedRect(size, size, 8);
    translate([0, size/2 - 32.25]) switch_hole();
    translate([0, -size/2 + 23]) earthed_plug_holes();
  }
}

module switch_hole() {
  roundedRect(27, 25, 3);
}

// 0,0 = earth plug hole center
module earthed_plug_holes() {
  // gem. https://de.wikipedia.org/wiki/SEV_1011
  distance_x = 9.5; //19/2
  distance_y = 5;
  union() {
    plug_hole();
    translate([-distance_x,distance_y]) plug_hole();
    translate([distance_x,distance_y]) plug_hole();
  }
}

module plug_hole() {
  // gem. https://de.wikipedia.org/wiki/SEV_1011
  circle(d=4.5);
}

module screw_hole() {
  circle(d=3.3);
}

module screw_head() {
  head_diameter = 5.1;
  head_depth = 1.5;
  hull() {
    linear_extrude(epsilon) circle(d=head_diameter);
    translate([0,0,-head_depth]) linear_extrude(epsilon) screw_hole();
  }
}
