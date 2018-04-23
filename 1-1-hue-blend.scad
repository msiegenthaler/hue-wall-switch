// Hue blend for one-switch + one-plug socket
quality = 50;
epsilon = 0.001;

include <blend.scad>
include <hue-holder.scad>

// light_switch();

holder_height = 98;
additonal_blend = holder_height+6;

wall_strength=1;

magnet_x_offset=9;
magnet_depth=2+0.2;

depth = 6.5;
cutout_depth = depth - (wall_strength+magnet_depth) ;
echo(cutout_depth);
holder_offset = 75;

difference() {
  union() {
    blend();
    translate([0, holder_offset, -depth/2])
      cube([42, holder_height, depth], center=true);
  }
  translate([0, holder_offset,0]) {
    translate([0,0,-cutout_depth+epsilon])
      cutout(cutout_depth);

    translate([magnet_x_offset,0,-depth-epsilon*4])
      negative_magnet_holder(magnet_depth);
    translate([-magnet_x_offset,0,-depth-epsilon*4])
      negative_magnet_holder(magnet_depth);
  }
}

module blend() {
  union() {
    blend_one_one(depth);
    translate([0,28+additonal_blend/2,0])
      blend_case(86, additonal_blend, 8, depth, 3, 2.5);
  }  
}

module light_switch() {
  color("blue") translate([0,10.5,0])
    linear_extrude(5.1) switch_hole();
}
