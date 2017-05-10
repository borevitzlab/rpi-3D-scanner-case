// Pi Camera Mount Core
// by Ming-Dao Chia
// Last update: 2/3/2017
// for the Borevitz Lab, Australian National University

// screw settings
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

union(){
    frame(20,2);
    rotate([90,180,0])
    translate([4.5,-10,-16])
    joint_screw(screws);
    rotate([90,0,0])
    translate([34.5,10,-16])
    joint_screw(screws);
}