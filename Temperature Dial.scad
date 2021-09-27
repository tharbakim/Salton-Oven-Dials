timeDialDiam = 30;
keyOuterDiam = 10.0;
keyInnerDiam = 7.4;
keyInnerAcross = 5.3;
keyProtrude = 12;
keyLength = 12;
keyRotation = 315;
calculatedKeyLength = keyLength - keyProtrude;
externalKeyHeight = keyLength;
externalKeyLength = keyOuterDiam;
externalKeyWidth = 0.8;
epsilon = 0.001;
asymmetric = false;


module key(d,h,a) {
                    rotate(keyRotation, [0,0,1]){
    union() {


    cube([d,h,a], center=true);
      
    }
        difference() {
                cylinder(d=keyOuterDiam, h=keyLength, center=true);

                cylinder(d=keyInnerDiam, h=keyLength, center=true);
        }
    }
        }
    


module dialKey() {
            // key
        translate([0,0,-(externalKeyHeight/2)+epsilon*2])
            key(externalKeyLength, externalKeyWidth, keyProtrude);
}

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
            translate([0,0,-calculatedKeyLength])
                cylinder(d=keyOuterDiam, h=calculatedKeyLength+epsilon);
               
                
        }
        
    }
dialKey();
    
}


$fn=128;
timeDial();
//dialKey();
