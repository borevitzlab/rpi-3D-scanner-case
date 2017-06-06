// RPi Case Cover
// by Ming-Dao Chia
// Last update: 1/20/2017
// for the Borevitz Lab, Australian National University

lid_height = 6; // Total lid height, not including the little front tab
rounding = 2; // just for the cable tie slots (less = sharper corners)
circle_res = 40; // can increase for final export

// just the cover without holes
module baseCover(){ 
    difference(){
        cube([64,93,lid_height]);
        translate([2,2,2]) 
            cube([60,89,lid_height+4]);
    };
    // front flap helps prevent unwanted sideways movement
    translate([4,91,lid_height-2]) 
    cube([55.6,2,5]);
    // back flap to fit other side
    translate([4,0,lid_height-2]) 
    cube([55.6,2,5]);
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

// rounded rectangle module
module sidePort(x,y, rounding=rounding){
    rotate([0,0,0])
    minkowski()
    {
      cube([y-rounding*2,x-rounding*2,1],center=true);
      cylinder(r=rounding,h=5, $fn=circle_res);
    }
}

// Holes for cable ties
module cableTiePort(x,y){
    translate([x,y,-2])
    sidePort(12,4.2);
}

difference(){
    baseCover(); // everything is subtracted from this
    baseMountingHoles();
    cableSlot(10,46,25,2);
    bigCamera(10,14);
    smallCamera(10,24);
    tempHumiditySensor(40,84.5);
    cableSlot(52,73,6,9); // humidity sensor cable
    // cable ties to secure top and bottom
    cableTiePort(6,55);
    cableTiePort(58,55);
}

    