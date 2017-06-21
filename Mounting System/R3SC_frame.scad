// 3D Scanner Frame
// Designed for use with Hyperspectral Camera system

// Variables
bar_screw_size=3; // in mm
frame_thickness=3; 
$fn=30; // fix constant 
frame_width=15;

// Constants (may still need adjustment for printing)
top_screw_size=3; 
top_length=105; 
side_length=212;


module frame_half(){
    difference(){
        union(){
            //top
            translate([0,0,2.5])
            cube([frame_thickness, top_length/2, 5]);
            cube([frame_width, top_length/2+frame_thickness, frame_thickness]);
            //side
            translate([0,top_length/2,-side_length])
            cube([frame_width, frame_thickness, side_length]);
            //bottom
            translate([0,top_length/2,-side_length])
            cube([frame_width, top_length/4, frame_thickness]);
        }
        // screws
        translate([0,top_length/2-32,5])
        rotate([0,90,0])
        cylinder(d=top_screw_size,h=frame_thickness*2);
        translate([frame_width/2,top_length/2+top_length/8,-side_length])
        cylinder(d=bar_screw_size,h=frame_thickness*2);
    }
}

module frame(){
    union(){
    frame_half();
    mirror([0,1,0])
    frame_half();
    }
}

frame();