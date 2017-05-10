// Pi Camera Arm
// by Ming-Dao Chia
// Last update: 2/3/2017
// for the Borevitz Lab, Australian National University

// screw settings
screw_correction=.5;
base_screw_size=3;
screws=base_screw_size+screw_correction;

// model height
height=9.6;

module base_arm(){
    length=20;
    difference(){
    union(){
        cube([height,length,10]);
        rotate([0,90,0])
        translate([-5,0,0])
        cylinder(height,5,5,$fn=50);
    }
    translate([-1,0,5])
    rotate([0,90,0])
    cylinder(25,screws/2,screws/2,$fn=30);
}
}


// connects to main arm
module adapt_joint(){
    difference(){
        cube([18,height,12]);
        translate([4,-.5,-.5])
        cube([10,height+1,13]);
        rotate([90,0,90])
        translate([5,3,-10])
        cylinder(30,screws/2,screws/2,$fn=30);
    }
}

rotate([0,90,0])
union(){
base_arm();
rotate([90,90,0])
translate([-14,0,-28])
adapt_joint();
}