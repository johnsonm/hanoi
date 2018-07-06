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
    disks = [
        [h*15/2, h*15/2, h*15, 0],
        [h*13/2, h*15+s+h*13/2, h*13, 0],
        [h*11/2, h*15+s+h*13+s+h*11/2, h*11, 0],
        [h*15/2, h*15/2, h*5, 1],
        [h*13/2, h*15+s+h*13/2, h*7, 1],
        [h*11/2, h*15+s+h*13+s+h*11/2, h*9, 1],
    ];
    for (p=disks) {
        x=p[0];
        y=p[1];
        d=p[2];
        o=p[3] * (sqrt((pow(x+d/2, 2))/2) + s/sqrt(2));
        translate([x+o, y+o]) disk(d, h);
    }
}
module base(radius_multiple) {
    $fn=30;
    h=disk_height;
    d=h*radius_multiple;
    x=-(d*0.5+h/2);
    hull() {
        translate([x, d*0.5]) disk(d, h);
        translate([x, d*2.5]) disk(d, h);
    }
    translate([x, d*0.5]) cylinder(r=post_radius, h=8*h);
    translate([x, d*1.5]) cylinder(r=post_radius, h=8*h);
    translate([x, d*2.5]) cylinder(r=post_radius, h=8*h);
    for (i=[1:6]) {
        z=i*disk_height;
        r=h*(3+2*(7-i));
        translate([x, d*0.5, z]) %disk(r, h);
    }

}
disk_set();
// If you print the base, you may have to adjust the size to fit,
// which might mean printing a smaller set of disks.
base(17);