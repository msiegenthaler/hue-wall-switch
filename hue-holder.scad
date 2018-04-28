// Hue holder

quality = 50;
epsilon = 0.001;
include <lib.scad>;

// bar();
//lower_plate();
//upper_plate();
// cutout(5);
// magnet_holder();
// simple(43, 100);

magnet_x_offset=9;
magnet_depth=2+0.2;

module simple(x, y) {
  cutout_depth=3.8;
  wall_strength=2;
  d = cutout_depth+wall_strength+magnet_depth;
  union() {
    difference() {
      cube([x, y, d], center=true);
      translate([0,0,0.3]) cutout(cutout_depth);
      translate([magnet_x_offset,0,-d/2-epsilon])
        negative_magnet_holder(magnet_depth);
      translate([-magnet_x_offset,0,-d/2-epsilon])
        negative_magnet_holder(magnet_depth);
    }
  }
}

module negative_magnet_holder(depth) {
  difference() {
    cylinder(depth, d=17);
    scale([1,1,1.1]) magnet_holder(depth);
  }
}

module magnet_holder(depth) {
  holders = 10;
  holder_len = 0.4; holder_width = 0.5;
  diameter = 15;
  outer = diameter + 2;
  difference() {
    union() {
      for (i = [0:10]) {
        rotate(a=[0, 0, i*360/holders], v=[10,10,0])
          cube([holder_width, holder_len+diameter/2, depth], center=false);
      }
    };
    translate([0,0,-epsilon]) cylinder(depth+epsilon*2, d=diameter);
  }
  difference() {
    cylinder(depth, d=outer);
    translate([0,0,-epsilon]) cylinder(depth+2*epsilon, d=diameter+2*holder_len);
  }
}

module cutout(total_depth) {
  depth = 3.8;
  depth_straight = 1.5;
  union() {
    linear_extrude(depth_straight) lower_plate();
    hull() {
      translate([0,0,depth_straight]) linear_extrude(epsilon) lower_plate();
      translate([0,0,depth]) linear_extrude(epsilon) upper_plate();
    }
    translate([0,0,depth]) linear_extrude(total_depth-depth) upper_plate();
    translate([0,40,0]) bar();
  }
}

base_w=35; base_h=93;
upper_delta=2;
module lower_plate() {
  roundedRect(base_w, base_h, 2.5);
}
module upper_plate() {
  roundedRect(base_w+2*upper_delta, base_h+2*upper_delta, 2+upper_delta);
}

module bar() {
  low_len = 21.5;  diameter = 4.1;
  union() {
    rotate([0,90,0]) cylinder(low_len, d=diameter, center=true);
    translate([low_len/2,0,0]) sphere(d=diameter);
    translate([-low_len/2,0,0]) sphere(d=diameter);
  }
}
