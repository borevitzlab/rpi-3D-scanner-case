// RPi Case Cover
// by Ming-Dao Chia
// Last update: 1/20/2017
// for the Borevitz Lab, Australian National University

// original Sketchup version for comparison
// no longer in use
module importBase(){ 
rotate([0,180,0])
translate([0,0,-37])
import("RPi_case_top.stl");
}

// just the cover without holes
module baseCover(){ 
    difference(){
        cube([64,93,6]);
        translate([2,2,2]) 
            cube([60,89,10]);
    };
};

// configurable hole for screws
module screwHole(diameter, x, y){ 
    translate([x,y,-2])
    cylinder(d=diameter, h=10, $fs=0.2);
}

// slots for ribbon wires
module cableSlot(xpos, ypos, xsize, ysize){ 
    translate([xpos,ypos,-2])
    cube([xsize,ysize,10]);
}

// rods to connect to case bottom
module baseMountingHoles(){ 
    screwHole(3, 7.5, 7);
    screwHole(3, 7.5, 65.5);
    screwHole(3, 56.5, 7);
    screwHole(3, 56.5, 65.5);
}
    
// larger 180 camera
module bigCamera(xpos,ypos){
    screwHole(4, xpos,ypos);
    screwHole(4, xpos+29,ypos);
    screwHole(4, xpos,ypos+29);
    screwHole(4, xpos+29,ypos+29);
}

// fits standard RPi camera
module smallCamera(xpos,ypos){
    screwHole(3,xpos,ypos);
    screwHole(3,xpos+21,ypos);
    screwHole(3,xpos,ypos+13);
    screwHole(3,xpos+21,ypos+13);
}

module tempHumiditySensor(xpos,ypos){
    screwHole(3, xpos,ypos);
    screwHole(3, xpos,ypos-15);
    screwHole(3,xpos-27,ypos-7.5);
}

difference(){
    baseCover(); // everything is subtracted from this
    baseMountingHoles();
    cableSlot(10,46,25,2);
    bigCamera(10,14);
    smallCamera(10,24);
    tempHumiditySensor(40,84.5);
    cableSlot(52,73,6,9); // humidity sensor cable
}

    