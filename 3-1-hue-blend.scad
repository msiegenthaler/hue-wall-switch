// Hue blend for three-switches + one-plug socket
quality = 100;
epsilon = 0.001;

include <blend.scad>
include <hue-holder.scad>

x = 86;
y = 205;
thickness = 2.5;
wall = 1;

switch1_offset=30.8+25/2;
switch2_offset=90.5+25/2;
switch3_offset=205-40-25/2;
light_switch_height=5.2;

screw_switch_offset=30.8-25/2;
plug_screw_offset=36;

cutout_depth=3.5;
base_depth = 5;
additional_depth=light_switch_height+cutout_depth;
magnet_depth=5;

cutout_offset = -25;


blend();
*translate([0,y/2-switch1_offset,0])
  light_switch(light_switch_height);
*translate([0,y/2-switch2_offset,0])
  light_switch(light_switch_height);
*translate([0,y/2-switch3_offset,0])
  light_switch(light_switch_height);
*blend_three_one();

module blend() {
  difference() {
    union() {
      translate([0,0,additional_depth])
        blend_case(x, y, 8, base_depth+additional_depth, cutout_depth+3, thickness);
      screw_cases();      
      switch_cases();
    };

    full_cutout();
    screw_and_switch_cutouts();
  };
}

module full_cutout() {
  translate([0,cutout_offset,light_switch_height]) {
    translate([0,0,0])
      cutout(cutout_depth);
    translate([magnet_x_offset,0, -wall])
      translate([0,0,-magnet_depth]) negative_magnet_holder(magnet_depth);
    translate([-magnet_x_offset,0,-wall])
      translate([0,0,-magnet_depth]) negative_magnet_holder(magnet_depth);
  }
}

module screw_and_switch_cutouts() {
  // completly cover the top switch, it's not used (redundant)
  *translate([0,y/2-switch1_offset,0]) {
    linear_extrude(additional_depth) switch_hole();
    // bad placement, don't need it
    translate([0,screw_switch_offset,0])
    screw_negative();
    translate([0,-screw_switch_offset,0])
    screw_negative();
  }
  translate([0,y/2-switch2_offset,0]) {
    linear_extrude(additional_depth) switch_hole();
    // bad placement, don't need it
    *translate([0,screw_switch_offset,0])
    screw_negative();
    translate([0,-screw_switch_offset,0])
    screw_negative();
  }
  translate([0,y/2-switch3_offset,0]) {
    linear_extrude(additional_depth) switch_hole();
  }
  translate([0,-y/2+plug_screw_offset,0])
    screw_negative();
}

module screw_cases() {
  translate([0,y/2-switch1_offset+screw_switch_offset,-base_depth])
    screw_case(base_depth+additional_depth);
  translate([0,y/2-switch1_offset-screw_switch_offset,-base_depth])
    screw_case(base_depth+additional_depth);
  translate([0,y/2-switch2_offset+screw_switch_offset,-base_depth])
    screw_case(base_depth+additional_depth);
  translate([0,y/2-switch2_offset-screw_switch_offset,-base_depth])
    screw_case(base_depth+additional_depth);
  translate([0,-y/2+plug_screw_offset,-base_depth])
    screw_case(base_depth+additional_depth);
}

module switch_cases() {
  translate([0,y/2-switch1_offset,-base_depth]) {
    linear_extrude(base_depth+light_switch_height) difference() {
      scale([1.1,1.1]) switch_hole();
      switch_hole();
    };
  }
  translate([0,y/2-switch2_offset,-base_depth]) {
    linear_extrude(base_depth+light_switch_height) difference() {
      scale([1.1,1.1]) switch_hole();
      switch_hole();
    };
  }
  translate([0,y/2-switch3_offset,-base_depth]) {
    linear_extrude(base_depth+light_switch_height) difference() {
      scale([1.1,1.1]) switch_hole();
      switch_hole();
    };
  }
}

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