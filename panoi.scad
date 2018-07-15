// Copyright 2018 Michael K Johnson
// Use allowed under Attribution 4.0 International (CC BY 4.0) license terms
// https://creativecommons.org/licenses/by/4.0/legalcode
// Print a set of pyramids for towers of hanoi

// Number of pyramids to print
count=8; // [3:20]
// Number of sides for each pyramid
sides=4; // [3:10]
// Width of circumscribing cylinder around base of smallest pyramid
base=20;
// Thickness of pyramid shells
thickness=2;
// External angle of pyramid side
angle=30; // [20:45]

module pyramid(r, inner=false) {
    height=r*tan(90-angle);
    difference() {
        // change this rotation to parallel adjacent sides regardless of number of sides
        rotate([0, 0, 180/sides])
            cylinder(r1=r, r2=0, h=height, $fn=sides);
        if (!inner) {
            pyramid(r=r-thickness, inner=true);
        }
    }
}
module stack() {
    max_r=base/2 + thickness*count;
    for (i=[1:count]) {
        Y=max_r * ((i%2)?1:-1);
        translate([0, Y, 0]) pyramid(base/2 + thickness*i);
    }
}
module preview_stack() {
    X=base + 2*thickness*count;
    for (i=[1:count]) {
        Z=2*(count-i)*thickness*tan(90-angle);
        translate([-X, 0, Z]) pyramid(base/2 + thickness*i);
    }
    
}
%preview_stack();
stack();