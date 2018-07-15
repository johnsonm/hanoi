# Parametric Towers of Hanoi sets

## hanoi.scad

Printable six-disk [towers of Hanoi](https://en.wikipedia.org/wiki/Tower_of_Hanoi) set.

### Modifications

As designed, this set barely fits on the 270mm-long bed of my
printer, so if you do not have 270mm in at least one axis you may
have to modify this.  You can try printing the disks separately
and printing the base across the diagonal.  The easiest way is
probably to separate the pieces in the slicer and re-arrange them
there until they fit your printer.

While this set is designed to work for disk thickness down to
3mm, in practice even the 5mm default thickness is about as
thin as is comfortable to manipulate.  Because this set is
designed to preserve aspect ratio, you will need a large
printer to print this set above the default 5mm disk thickness,
or you will need to explicitly change the aspect ratio.

If you print posts, the `post_radius` should not be less than
5mm, at least with PLA.  PETG might be sufficiently strong with
thinner posts.

If you do not print posts, you'll have to drill holes in the
bottoms of whatever you use for the posts.  You can set a non-zero
`post_offset` to print a pocket for the posts (in which case you
will almost certainly want to use a lathe to exactly center the hole
in the rod), but make sure there is some room between the bottom of
the pocket and the head of the screw so that the post doesn't easily
tear out of the base.  If you do this, you might need to increase
`base_height` to accommodate the additional thickness required.
When rendering, OpenSCAD will print out the post height it expects
so that you can cut rod to the appropriate size for the posts.
You may want to chamfer or round the top of the posts to make it
easier to slip the disks on the posts.

Note that in OpenSCAD, F5 preview will show a stack of disks
on the base (and the posts if not printed) as "background",
which can help you make sure that the parameters you have
chosen will work well.

You can print an extra set of discs in a second color for
[two color towers of Hanoi](https://www.cut-the-knot.org/recurrence/BiColorHanoi.shtml).
If you do that, increase the size of the posts by at least two
rings.

## panoi.scad

Printable eight-pyramid [towers of Hanoi](https://en.wikipedia.org/wiki/Tower_of_Hanoi) set.

Prints in two alternating stacks on the printer. Preview shows the
hanoi-style stack.  These are intended to be played by setting
up the stack and moving pyramids from stack to stack across
three locations, using the same rules as disks.  Print two or more
sets in different colors for [multi-color towers](https://www.cut-the-knot.org/recurrence/BiColorHanoi.shtml).

### Modifications

Almost everything about this set can be customized.

* The `count` is the number of total pyramids to print.  The
odd-numbered pyramids are in negative Y, and the even-numbered
pyramids are in positive Y.  They are all stacked largest on
the bottom and smallest on the top for play, but they are of
course printed the other way around.

* The `sides` says how many sides to print.  `60` will be close
enough to a cone as makes little difference when printed.  Three
to six sides should be generally playable, but go ahead and
experiment.

* The `base` is the *diameter* of the *circumscribing cylinder*
around the *smallest* pyramid, and for an odd number of sides will
not correspond to any specific measurement of the objects produced.

* The `thickness` is the X-Y thickness of the shells, so that the
actual thickness of the shells in the object will be `tan(angle)*thickness`

* The `angle` is the *external* angle, the slope of the pyramid away
from vertical. *20* is a very tall pyramid; 45 is a squat pyramid and
is probably as large an `angle` as you want.

If you try to split and re-arrange in the slicer, *be careful* because
the inner pyramids are unlikely to rearrange with the outer ones.
This is a case where it is better to rearrange in the model than in
the slicer.

Copyright 2018 Michael K Johnson
Use allowed under Attribution 4.0 International (CC BY 4.0) license terms
https://creativecommons.org/licenses/by/4.0/legalcode

