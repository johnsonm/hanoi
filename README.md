Parametric Towers of Hanoi set
==============================

Printable six-disk [towers of Hanoi](https://en.wikipedia.org/wiki/Tower_of_Hanoi) set.

Modifications
-------------

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

Copyright 2018 Michael K Johnson
Use allowed under Attribution 4.0 International (CC BY 4.0) license terms
https://creativecommons.org/licenses/by/4.0/legalcode

