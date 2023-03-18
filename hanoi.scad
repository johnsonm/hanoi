// Copyright 2018 Michael K Johnson
// Use allowed under Attribution 4.0 International (CC BY 4.0) license terms
// https://creativecommons.org/licenses/by/4.0/legalcode
// Print a set of disks for towers of hanoi

// Heights 3mm and larger will work; 6.35mm is 1/4"
disk_height=5;
// The height of the base can be thicker if necessary for screw for post
base_height=5;
// 4.75 is 3/16" radius for 3/8" diameter rod; at least 3mm radius recommended
// 6 recommended for printed rods
post_radius=6; // [3:10]
hole_radius=post_radius+0.75;
// Add space for at least two additional rings for two-color Hanoi
rings_per_post=7;

// flat-head screws, assume M3 flat-head screw
// http://www.roymech.co.uk/Useful_Tables/Screws/cap_screws.htm
// Set dimensions so screws are countersunk below surface
// Screw head outer diameter (>= A_max)
screw_head_d=6.5;
// Screw outside thread diameter (M3 == 3mm, #6 == 3.5mm)
screw_d=3;
// depth of rod pocket cut into base (increase base_height)
post_offset=0;

e=0.01; // use to avoid coincident planes

module disk(diameter, height) {
    difference() {
        hull() {
            rotate_extrude(convexity=10, $fn=diameter)
                translate([diameter/2-height/2, height/2, 0])
                circle(d=height, $fn=6);
        }
        translate([0, 0, -e]) cylinder(r=hole_radius, h=height+2*e, $fn=post_radius*4);
    }
}
module post(r, h) {
    $fn=30;
    cylinder(r=r, h=h-r);
    translate([0, 0, h-r]) sphere(r=r);
}
module disk_set(h=disk_height) {
    // Initial diameter is 5 times the height of the disk;
    // subsequent disk *radii* grow by the disk height.
    // Enough separation to print nicely; if you shrink this,
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
module base(radius_multiple, print_posts=true) {
    $fn=30;
    h=base_height;
    d=h*radius_multiple;
    x=-(d*0.5+h/2);
    post_height=(rings_per_post+2)*h+post_offset;
    difference() {
        hull() {
            for (w=[d*0.5, d*2.5]) {
                translate([x, w]) disk(d, h);
            }
        }
        if (!print_posts) {
        union() {
                for (d=[d*0.5, d*1.5, d*2.5]) {
                    translate([x, d, -e]) {
                        // hole for post
                        translate([0, 0, base_height-post_offset])
                            cylinder(r=post_radius, h=h+2*e);
                        // hole for screw
                        cylinder(d=screw_d, h=base_height+e);
                        // ~90⁰ included angle in screw head
                        cylinder(d1=screw_head_d, d2=0, h=screw_head_d/sqrt(2));
                    }
                }
            }
        }
    }
    for (d=[d*0.5, d*1.5, d*2.5]) {
        translate([x, d, base_height-post_offset]) if (print_posts) {
            post(r=post_radius, h=post_height);
        } else {
            %post(r=post_radius, h=post_height+post_offset);
        }
    }
    echo("Post height: ", post_height, "mm");
    for (i=[1:6]) {
        z=i*disk_height;
        r=h*(3+2*(7-i));
        translate([x, d*0.5, z]) %disk(r, h);
    }

}
disk_set();
// If you print the base, you may have to adjust the size to fit,
// which might mean printing a smaller set of disks.
base(17, true);
