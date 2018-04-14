// Common functions

$fn = quality;

module roundedRect(x, y, radius) {
  hull() {
      translate([(-x/2)+(radius), (-y/2)+(radius), 0])
      circle(r=radius);

      translate([(x/2)-(radius), (-y/2)+(radius), 0])
      circle(r=radius);

      translate([(-x/2)+(radius), (y/2)-(radius), 0])
      circle(r=radius);

      translate([(x/2)-(radius), (y/2)-(radius), 0])
      circle(r=radius);
  }
}

module roundedCube(x, y, z, rxy) {
  intersection() {
    translate([0, 0, -z]) hull() {
      translate([(-x/2)+(rxy), (-y/2)+(rxy), 0])
        scale([rxy, rxy, z]) sphere(r=1);
      translate([(x/2)-(rxy), (-y/2)+(rxy), 0])
        scale([rxy, rxy, z]) sphere(r=1);
      translate([(-x/2)+(rxy), (y/2)-(rxy), 0])
        scale([rxy, rxy, z]) sphere(r=1);
      translate([(x/2)-(rxy), (y/2)-(rxy), 0])
        scale([rxy, rxy, z]) sphere(r=1);
    };
    translate([0, 0, -z/2]) cube([x, y, z], center=true);
  }
}
