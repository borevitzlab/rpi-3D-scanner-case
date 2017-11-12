// translate([64,0,case_height+6]) rotate([0,180,0]) import("RPi Case/R3SC_RPi_top.stl");

//translate([64,0,case_height+6]) rotate([0,0,0]) import("RPi Case/R3SC_RPi_bottom.stl");

color("white") translate([36,15,47]) rotate([0,0,270]) import("Mounting System/R3SC_middle_arm.stl");

color("white") translate([0,0,50]) rotate([270,0,0]) import("Mounting System/R3SC_mounting_core.stl");

color("orange") translate([55.5,25,42]) rotate([-45,0,270]) import("RPi Camera/R3SC_RPi_camera_case.stl");