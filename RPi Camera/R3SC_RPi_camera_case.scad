
// screw settings
screw_correction=.5;
base_screw_size=3;
screws=base_screw_size+screw_correction;

// model height
height=9.6;

// printer tolerance for camera rails
cam_tolerance = 0.3;

circle_res=40;

module base_arm(){
    length=10;
    difference(){
    union(){
        cube([height,length,6]);
        rotate([0,90,0])
        translate([-4,0,0])
        cylinder(height,r=4,$fn=50);
        rotate([0,90,0])
        translate([-3,length,0])
        cylinder(height,r=3,$fn=50);
    }
    translate([-1,0,4])
    rotate([0,90,0])
    cylinder(25,screws/2,screws/2,$fn=30);
}
}

module cam_only_mount(){
    difference(){
        // outside shell
        cube([30,28,10]);
        // main camera space
        translate([4,-2,2])
        cube([22,26,9]);
        // guide rails
        translate([15,12,6.5])
        cube([26+cam_tolerance,28+cam_tolerance,1+cam_tolerance],center=true);
        // lens port
        translate([15,11,-1])
        cylinder(r=4,h=5, $fn=circle_res);
        // lens entry guide
        translate([11,-1,-1])
        cube([8,12,4]);
    }
}

module linkage(){
    union(){
        translate([10.3,0,0])
        rotate([0,0,20])
        cube([5,30,2]);
        translate([15,1.8,0])
        rotate([0,0,-20])
        cube([5,30,2]);
    }
}

module RPi_cam_mount(){
    union(){
        translate([10,4,0])
        base_arm();
        translate([0,37,0])
        cam_only_mount();
        translate([0,10,0])
        linkage();
    }
}

RPi_cam_mount();

// debugging

// from https://github.com/larsch/openscad-modules/blob/master/rpi-camera.scad
module rpi_camera() {
     color("darkblue")
	  difference() {
	  cube([24,25,1]);
	  translate([2,2,-1]) cylinder(d=2,h=3,$fn=8);
	  translate([2,23,-1]) cylinder(d=2,h=3,$fn=8);
	  translate([14.5,2,-1]) cylinder(d=2,h=3,$fn=8);
	  translate([14.5,23,-1]) cylinder(d=2,h=3,$fn=8);
     }
     color("DimGray") union() {
	  translate([10.25,8.5,1]) cube([8,8,3.25]);
	  translate([10.25+4,12.5,1+3.25]) cylinder(d=7.5,h=1,$fn=16);
	  translate([10.25+4,12.5,1+3.25+0.7]) cylinder(d=5.5,h=0.7,$fn=16);
     }
     color("orange") translate([1.75,8.625,1]) cube([8.5,7.75,1.5]);
     color("brown") translate([24-5.75,2.75,-2.75]) cube([4.5,19.5,2.75]);
     color("black") translate([22.75,2,-2.75]) cube([1.25,21,2.75]);
     color("grey") translate([24,4.25,-1]) cube([10,16.5,0.1]);
}

//translate([27.5,63,7]) rotate([0,180,90]) rpi_camera();

// original Sketchup version for comparison
//#translate([15,50,0]) import("cam_orig.stl");