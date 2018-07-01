// Print a set of disks for towers of hanoi

// Heights 3mm and larger will work
disk_height=5;
//disk_height=6.35; // 1/4 inch
post_radius=2.5;
hole_radius=post_radius+0.5;

e=0.01; // use to avoid coincident planes

module disk(diameter, height) {
    $fn=120;
    difference() {
        //cylinder(d=diameter, h=height);
        hull() {
            rotate_extrude(convexity = 10)
                translate([diameter/2-height/2, height/2, 0])
                circle(d=height);
        }
        translate([0, 0, -e]) cylinder(r=hole_radius, h=height+2*e);
    }
}

module disk_set() {
    // Set of six disks, with an attempt to use a small and
    // relatively square bounding box for printers with
    // limited space
    // Initial diameter is 5 times the height of the disk;
    // subsequent disk *radii* grow by the disk height.
    h=disk_height;
    // enough separation to print nicely; if you shrink this,
    // you may have to modify the position of the smallest disk
    s=h/2;
    for (p=[
            [h*7+h*9, h*9+h*5/2-s, h*5],
            [h*7/2, h*7/2, h*7],
            [h*7+s+h*9/2, h*9/2, h*9],
            [h*7+s+h*9+s+h*11/2, h*11/2, h*11],
            [h*7+s+h*9+s+h*11/2, h*11+s+h*13/2, h*13],
            [h*15/2, h*9+s+h*15/2, h*15]
        ]) {
        x=p[0];
        y=p[1];
        d=p[2];
        translate([x, y]) disk(d, h);
    }
}
module base(radius_multiple) {
    $fn=30;
    h=disk_height;
    d=h*radius_multiple;
    y=-(d*0.5+h/2);
    hull() {
        translate([d*0.5, y]) disk(d, h);
        translate([d*2.5, y]) disk(d, h);
    }
    translate([d*0.5, y]) cylinder(d=post_radius, h=8*h);
    translate([d*1.5, y]) cylinder(d=post_radius, h=8*h);
    translate([d*2.5, y]) cylinder(d=post_radius, h=8*h);
}
disk_set();
// If you print the base, you may have to adjust the size to fit,
// which might mean printing a smaller set of disks.
base(17);