timeDialDiam = 30;
keyOuterDiam = 10.0;
keyInnerDiam = 6.2;
keyInnerAcross = 5.3;
keyLength = 12;
keyRotation = 35;
epsilon = 0.001;
asymmetric = false;


module key(d,h,a) {
    rotate(keyRotation, [0,0,1]){
    difference() {
        cylinder(d=d,h=h);
        translate([d/-2,a-d/2,-epsilon])
            cube([d+epsilon,d-a+epsilon,h+2*epsilon]);
    }
    translate([0,0,-epsilon])
        cylinder(d1=d+3,d2=0,h=5);
}}

module timeDial() {
    plateH = 1;
    baseH = 0.05 * timeDialDiam;
    totalH = 0.5 * timeDialDiam;
    upperDiam = timeDialDiam - 2*baseH;
    aspectRatio = 0.3;
    needleSize = 0.22 * timeDialDiam;
    
    difference() {
        union() {

            // base plate
            cylinder(d=timeDialDiam, h=plateH+epsilon);
            
            // chamfer
            translate([0,0,plateH])
                cylinder(d1=timeDialDiam, d2=upperDiam, h=baseH);
            
            // handle
            scale([aspectRatio, 1, totalH / (timeDialDiam*0.5)])
                intersection() {
                    if (asymmetric) {
                        intersection() {
                            sphere(timeDialDiam/2);
                            translate([0,timeDialDiam*0.25,0])
                                scale([1.17,2,1])
                                    sphere(timeDialDiam/2);
                        }
                    } else {
                        sphere(timeDialDiam/2);                        
                    }
                    cylinder(d=timeDialDiam, h=timeDialDiam/2);
                }
            
            // needle
            translate([0,timeDialDiam/2-needleSize*0.2,0])
                rotate([0,0,90])
                    cylinder(d=needleSize,h=(baseH+plateH),$fn=3);
                
            // axle
            translate([0,0,-keyLength])
                cylinder(d=keyOuterDiam, h=keyLength+epsilon);
                        
        }
        
        // key
        translate([0,0,-keyLength-epsilon])
            key(keyInnerDiam, keyLength+plateH+10, keyInnerAcross);
    }
}

$fn=128;
timeDial();
