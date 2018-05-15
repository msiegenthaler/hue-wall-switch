// Hue blend for one-switch + one-plug socket
quality = 100;
epsilon = 0.001;

include <blend.scad>
include <hue-holder.scad>

x = 86;
y = 145;
thickness = 2.5;
wall = 1;

switch_offset=y-25/2-(86-32.5)+25/2;
light_switch_height=5.2;

screw_switch_offset=30.8-25/2;
plug_screw_offset=36;

cutout_depth=3.5;
base_depth = 5;
additional_depth=light_switch_height+cutout_depth;
magnet_y_offset=0;
magnet_depth=5;

cutout_offset = 14.75;


blend();
*translate([0,y/2-switch_offset,0])
  light_switch(light_switch_height);
*translate([0,-y/2+86/2,0])
  blend_one_one();

module blend() {
  difference() {
    union() {
      translate([0,0,additional_depth])
        blend_case(x, y, 8, base_depth+additional_depth, cutout_depth+3, thickness);
      screw_cases();      
      switch_cases();
      plug_case();
    };

    full_cutout();
    screw_and_switch_cutouts();
    plug_cutout();
  };
}

module full_cutout() {
  translate([0,cutout_offset,light_switch_height]) {
    translate([0,0,0])
      cutout(cutout_depth);
    #translate([magnet_x_offset,-magnet_y_offset, -wall])
      translate([0,0,-magnet_depth]) negative_magnet_holder(magnet_depth);
    #translate([-magnet_x_offset,-magnet_y_offset,-wall])
      translate([0,0,-magnet_depth]) negative_magnet_holder(magnet_depth);
  }
}

module screw_and_switch_cutouts() {
  translate([0,y/2-switch_offset,0]) {
    linear_extrude(light_switch_height+epsilon) switch_hole();
  }
  translate([0,-y/2+plug_screw_offset,0])
    screw_negative();
}

module plug_cutout() {
  translate([0,-y/2+27.5,0])
    linear_extrude(base_depth+light_switch_height)
      plug_shape(0);
  translate([0,-y/2+27.5,-base_depth])
    linear_extrude(thickness)
      plug_shape(0);
  translate([0, -y/2+22.5, -base_depth])
    linear_extrude(base_depth+additional_depth+1) earthed_plug_holes();
}

module plug_case() {
  translate([0,-y/2+27.5,-base_depth])
    linear_extrude(base_depth+light_switch_height)
      plug_shape(2.5);
}

module plug_shape(delta=0) {
  width = 37+delta;
  w2 =18/2;
  height = 22+delta;
  h2 = 1;
  translate([-width/2,-height/2,0])
  polygon(points=[[width/2-w2,0],
    [0,height/2-h2],[0,height/2+h2],
    [width/2-w2,height], [width/2+w2,height],
    [width,height/2+h2],[width,height/2-h2],
    [width/2+w2,0], [width/2-w2,0]]);
}

module screw_cases() {
  translate([0,-y/2+plug_screw_offset,-base_depth])
    screw_case(base_depth+additional_depth);
}

module switch_cases() {
  translate([0,y/2-switch_offset,-base_depth]) {
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
