$fn = 40;
in2mm = 25.4;

tubeInnerDiam = 149.1;
tubeInnerRad = tubeInnerDiam/2;
tubeWallThicc = 4.98;
tubePlatoDiam = tubeInnerDiam + tubeWallThicc;
tubePlatoRad = tubePlatoDiam / 2;
tubeOuterDiam = tubeInnerDiam + 2*tubeWallThicc;
tubeOuterRad = tubeOuterDiam / 2;
tubelen = 12*in2mm;

plateDiam = 7*in2mm;
plateThicc = 0.5*in2mm;

trenchDepth = plateThicc/3;
gasketThicc = 2;
trenchWidth = tubeWallThicc * 2;
trenchDevia = tubeWallThicc;

boltDiam = 0.25*in2mm;
boltRad = boltDiam/2;
boltOffset = 5;

boltLen = 14*in2mm;

domeDiam = 3 * in2mm;
domeRad = domeDiam / 2;

module tube()
{
    translate([0,0,-tubelen/2])
    linear_extrude(tubelen)
    difference()
    {
        circle(r = tubeOuterRad);
        circle(r = tubeInnerRad);
        square([10000,10000]);
    };
}

module plate(thicc)
{
    difference()
    {
    color([0.5,0.7,1,0.4])
        linear_extrude(plateThicc)
        {
            difference()
            {
                union()
                {
                    //circle(d = plateDiam);
                    hull()
                    {   
                        // The mounting bumps
                        for(r=[0:60:359])
                        {
                            rotate(r)
                            translate([tubeOuterDiam/2+boltOffset,0])
                            circle(d = 25);
                        }
                    }
                } // end union
                
                // Start cutting things out
                
                // Like bolt holes
                for(r=[0:60:359])
                {
                    rotate(r)
                    translate([tubeOuterDiam/2+boltOffset+boltRad,0])
                    circle(d = boltDiam+1);
                }
            }
        }
        color("tomato")
        // And the gasket trench
        translate([0,0,-0.1])
        linear_extrude(trenchDepth)
        difference()
        {
            circle(r = tubePlatoRad + trenchDevia);
            circle(r = tubePlatoRad - trenchDevia);
        }
        color("tomato")
        cylinder(r = domeRad, h = 200, center = true);
    }
}

module dome()
{
    color([0.5,0.7,1,0.4])
    difference()
    {
        union()
        {
            sphere(r = domeRad);
            cylinder(r = domeRad + 10, h = 4, center = true);
        }
        mirror([0,0,1])
        cylinder(r = 1000, h = 1000);
        sphere(r = domeRad-2);
    }
}

module gasket()
{
    color("darkslategrey")
    difference()
    {
        cylinder(r = tubePlatoRad + trenchDevia, h = gasketThicc);
        cylinder(r = tubePlatoRad - trenchDevia, h = 1000, center = true);
    }
}


module stuffedPlate()
{
    plate();
    translate([0,0,plateThicc])
    dome();
    translate([0,0,trenchDepth-gasketThicc])
    gasket();
}

module bolt()
{
    color("slategrey")
    cylinder(r = boltRad, h = boltLen, center = true, $fn = 20);
}

module housing()
{
    rotate([0,-90,0])
    {
        tube();
        translate([0,0,tubelen/2])
        stuffedPlate();
        translate([0,0,-tubelen/2])
        mirror([0,0,1])
        stuffedPlate();
        
            for(r=[0:60:359])
            {
                rotate(r)
                translate([tubeOuterDiam/2+boltOffset+boltRad,0])
                bolt();
            }
    }
}

module jetson()
{
    color("olive")
    cube([100,80,2], center = true);
}

module rov()
{
    rotate([30,0,0])
        housing();
    jetson();
}

rov();