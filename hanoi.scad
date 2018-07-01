// Print a set of disks for towers of hanoi

e=0.01;
// Heights 3mm and larger will work
disk_height=5;
//disk_height=6.35; // 1/4 inch
post_radius=3; // 0.5 to 1 larger than the actual radius of your post


module disk(diameter, height) {
    $fn=120;
    difference() {
        cylinder(d=diameter, h=height);
        translate([0, 0, -e]) cylinder(r=post_radius, h=height+2*e);
    }
}

module set() {
    // Set of six disks, with an attempt to use a small bounding box
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
        translate([x, y]) disk(d, disk_height);
    }
}
set();