// Pi Camera Mount Core
// by Ming-Dao Chia
// (for adding to RPi Case)
// Last update: 17/2/2017
// for the Borevitz Lab, Australian National University

// Mount settings
screw_correction=.5;
base_screw_size=3;
screws=base_screw_size+screw_correction;
screw_res=40;

// Goes around the aluminum bar.
module frame(length, thickness){
    sides=thickness*2;
    rod_size=26;
    difference(){
        union(){
            cube([rod_size+sides,rod_size+sides,length]);
            translate([(rod_size+sides)/2-sides*1.5,rod_size+sides,0])
            cube([sides*3, 10,length]);
        }
        translate([thickness,thickness,-1])
        cube([rod_size,rod_size,length+2]);
        // top screw
        translate([0,rod_size+sides+5,length/2])
        rotate([0,90,0])
        cylinder(25,screws/2,screws/2,$fn=screw_res);
        // spacer for top screw
        translate([(rod_size+sides)/2-sides/2,rod_size,-1])
        cube([sides,rod_size,length+2]);
        
    }
}

// attaches to arm
module joint_screw(hole_size){
    triangle_size=10;
    difference(){
        cylinder(16,triangle_size,triangle_size,$fn=3);
        translate([1.5,0,-0.5])
        cylinder(25,hole_size/2,hole_size/2,$fn=screw_res);
        translate([0,0,3])
        cylinder(10,triangle_size*2,triangle_size*2, $fn=3);
        translate([6,-3,-1])
        cube([10,10,20]);
    }
}


// RPI case Settings
circle_res = 20; // increase when printing
case_height = 50;
rounding=2; // for square ports

// Constants
fudge=0.2; // just for the tongue
RPi_space_height = 4;
RPi_screws = 2.5;
RPi_screw_hole_thickness=0.41;

// configurable hole for screws
module screwHole(diameter, x, y){ 
    translate([x,y,-2])
    cylinder(d=diameter, h=10, $fn=circle_res);
}

module spacer(x,y){
    translate([x,y,2])
            cylinder(r=(RPi_screws/2)+(RPi_screw_hole_thickness*2),h=RPi_space_height, $fn=circle_res);
}

module sidePort(x,y, rounding=rounding){
    rotate([0,90,0])
    minkowski()
    {
      cube([y-rounding*2,x-rounding*2,1],center=true);
      cylinder(r=rounding,h=5, $fn=circle_res);
    }
}

module RPi_core(){
    difference(){
        union(){
            difference(){
                cube([64,93,case_height]);
                // space for the RPi itself
                translate([2,2,2])
                cube([60,89,case_height]);
            }
             // bottom mounting spacers
            spacer(7.5, 7);
            spacer(7.5, 65.5);
            spacer(56.5, 7);
            spacer(56.5, 65.5);
        }
        // USB/Ethernet port access
        translate([4,90,6])
        cube([56,5,case_height]);
        // Bottom mounting screws
        // rods to connect to case bottom
        screwHole(3, 7.5, 7);
        screwHole(3, 7.5, 65.5);
        screwHole(3, 56.5, 7);
        screwHole(3, 56.5, 65.5);
        // HDMI slot
        translate([60,36,11.5])
        sidePort(20,15);
        // Power cable
        translate([60,57.5,10.5])
        sidePort(7,7,4.5);
        // side USB
        translate([60,14,9])
        sidePort(14,10);
        // microSD slot
        translate([22,-1,-1])
        cube([20,8,10]);
        // rear camera ribbons slot
        translate([4,-1,9])
        cube([56,5,case_height]);
    }
}


module RPi_bottom(){
    union(){
        RPi_core();
        rotate([0,90,90])
        translate([-30,0,0])
        frame(20,2);
    }
}

RPi_bottom();