// Hue blend for two-switches + no-plugs socket
quality = 100;
epsilon = 0.001;

include <blend.scad>
include <hue-holder.scad>

x = 86;
y = 146;
thickness = 2.5;
wall = 1;

switch_from_border = 42.5;
light_switch_height=5.2;
cutout_depth=3.5;
base_depth = 5;
additional_depth=light_switch_height+cutout_depth;
magnet_depth=5;
screw1_offset = 25; screw2_offset = 60;

y_asymetry=6.25;

difference() {
  union() {
    translate([0,y_asymetry,additional_depth])
      blend_case(x, y+y_asymetry, 8, base_depth+additional_depth, cutout_depth+3, thickness);
    translate([0,y/2-screw1_offset,-base_depth])
      screw_case(base_depth+additional_depth);
    translate([0,y/2-screw2_offset,-base_depth])
      screw_case(base_depth+additional_depth);
    translate([0,-y/2+screw1_offset,-base_depth])
      screw_case(base_depth+additional_depth);
    translate([0,-y/2+screw2_offset,-base_depth])
      screw_case(base_depth+additional_depth);
    translate([0,y/2-switch_from_border,-base_depth]) {
      linear_extrude(base_depth+light_switch_height) difference() {
        scale([1.1,1.1]) switch_hole();
        switch_hole();
      };
    }
    translate([0,-y/2+switch_from_border,-base_depth]) {
      linear_extrude(base_depth+light_switch_height) difference() {
        scale([1.1,1.1]) switch_hole();
        switch_hole();
      };
    }
  };

  translate([0,y_asymetry,light_switch_height]) {
    translate([0,0,0])
      cutout(cutout_depth);
    translate([magnet_x_offset,0, -wall])
      translate([0,0,-magnet_depth]) negative_magnet_holder(magnet_depth);
    translate([-magnet_x_offset,0,-wall])
      translate([0,0,-magnet_depth]) negative_magnet_holder(magnet_depth);
  }
  translate([0,y/2-switch_from_border,0]) linear_extrude(additional_depth) {
    switch_hole();
  }
  translate([0,-y/2+switch_from_border,-base_depth]) linear_extrude(base_depth+light_switch_height+epsilon) {
    switch_hole();
  }

  // only two screws.. the other two would look ugly
  translate([0, y/2-screw2_offset, 0])
    screw_negative();
  translate([0, -y/2+screw2_offset, 0])
    screw_negative();
};


*translate([0,y/2-switch_from_border,0])
  light_switch(light_switch_height);
*translate([0,-y/2+switch_from_border,0])
  light_switch(light_switch_height);
*blend_two_zero();

module screw_negative() {
  union() {
    screw_head();
    screw_head_extension();
    translate([0,0,-20])
    linear_extrude(40) screw_hole();
  }
}

module screw_case(height) {
  linear_extrude(height) circle(d=6.5);
}

module light_switch(height) {
  color("blue") translate([0,0,0])
    linear_extrude(height) switch_hole();
}
