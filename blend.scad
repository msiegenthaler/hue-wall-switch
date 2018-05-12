// Socket blends (covers)

quality = 50;
epsilon = 0.001;
include <lib.scad>;

// switch_hole();
// earthed_plug_holes();
// blend_one_one();
// blend_one_zero();
// blend_two_zero();

module blend_two_zero(depth=5) {
  x = 86; y=146; wall=3; thickness=2.5;
  switch_offset = 42.5;
  screw1_offset = 25; screw2_offset = 60;
  screw_depth = depth;
  difference() {
    blend_case(x, y, 8, depth, wall, thickness);

    translate([0, y/2 - switch_offset, -(depth+epsilon)])
      linear_extrude(depth+2*epsilon) switch_hole();
    translate([0, -y/2 + switch_offset, -(depth+epsilon)])
      linear_extrude(depth+2*epsilon) switch_hole();

    translate([0, y/2 - screw1_offset, (-depth+epsilon)])
      linear_extrude(depth+2*epsilon) screw_hole();
    translate([0, y/2 - screw1_offset, 0])
      screw_head();
    translate([0, -y/2 + screw1_offset, (-depth+epsilon)])
      linear_extrude(depth+2*epsilon) screw_hole();
    translate([0, -y/2 + screw1_offset, 0])
      screw_head();

    translate([0, y/2 - screw2_offset, (-depth+epsilon)])
      linear_extrude(depth+2*epsilon) screw_hole();
    translate([0, y/2 - screw2_offset, 0])
      screw_head();
    translate([0, -y/2 + screw2_offset, (-depth+epsilon)])
      linear_extrude(depth+2*epsilon) screw_hole();
    translate([0, -y/2 + screw2_offset, 0])
      screw_head();
  }
}

module blend_one_zero(depth=5) {
  x = 86; y = 86; wall = 3; thickness = 2.5;
  switch_offset = y/2;
  plug_offset = 23;
  screw_offset = 25; screw_depth = depth;
  union() {
    difference() {
      blend_case(x, y, 8, depth, wall, thickness);
      translate([0, y/2 - switch_offset, -(depth+epsilon)])
        linear_extrude(depth+2*epsilon) switch_hole();

      translate([0, y/2 - screw_offset, (-depth+epsilon)])
        linear_extrude(depth+2*epsilon) screw_hole();
      translate([0, y/2 - screw_offset, 0])
        screw_head();

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
    translate([0, y/2 - screw_offset, -screw_depth])
      linear_extrude(screw_depth-thickness) difference() {
        circle(d=7.9);
        screw_hole();
      };
    translate([0, -y/2 + screw_offset, -screw_depth])
      linear_extrude(screw_depth-thickness) difference() {
        circle(d=7.9);
        screw_hole();
      };
  }
}

// one switch and one plug
module blend_one_one(depth=5) {
  x = 86; y = 86; wall = 3; thickness = 2.5;
  switch_offset = 32.5;
  plug_offset = 23;
  screw_offset = 35.6; screw_depth = 5+depth;
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

module blend_case(x, y, r, depth, thickness_top, thickness_side) {
  difference() {
    roundedCube(x, y, depth, r);
    translate([0, 0, -thickness_top-0.01])
      roundedCube(x-2*thickness_side, y-2*thickness_side, depth-thickness_top, r);
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

module screw_head_extension() {
  head_diameter = 5.1;
  linear_extrude(20) circle(d=head_diameter);
}
