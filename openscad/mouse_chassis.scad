include <28BYJ-48-Stepper-Motor.scad>


chassisWidth = 44;
chassisLenght = 60;
chassisBaseThickness = 3;
chassisCornerRadius = 6;

//Stepper motors (to check fit)
translate([1,0,11]) rotate([90,180,90]) stepper28BYJ();
translate([-1,0,11]) rotate([270,0,90]) stepper28BYJ();


module chassisBase()
{
	//Chassis base
	minkowski()
	{
		translate([0,0,chassisBaseThickness/2]) cube([chassisWidth-(2*chassisCornerRadius),chassisLenght-(2*chassisCornerRadius),chassisBaseThickness], center=true);
		cylinder(r=chassisCornerRadius, h=chassisBaseThickness, $fn=40);
	}
}


//Mount tabs for stepper
//Single tab 
module stepperMountingTab()
{
	difference()
	{
		hull()
		{
			translate([5,0,1]) cube([10,10,2], center=true);
			translate([0,0,0]) cylinder(r=5,h=2,$fn=40);
		}

	//Mounting hole
	translate([0,0,-1]) cylinder(r=2.5,h=4,$fn=40);
	}
}

//Module that takes the mouting tab and makes a hull of it
//Note we have to redrill the holes as they are lost during
//the hull operation
//module stepperMountingSide()

//difference()
//{
	//hull()
	//{
	//translate([0,-17.5,11]) rotate([0,90,0]) stepperMountingTab();
	//translate([0,17.5,11]) rotate([0,90,0]) stepperMountingTab();
	//}
	//Re drill holes (they are filled in during the hull operation :(
	//translate([-1,-17.5,11]) rotate([0,90,0]) cylinder(r=2,h=4,$fn=40);
	//translate([-1,17.5,11]) rotate([0,90,0]) cylinder(r=2,h=4,$fn=40);
//}

//Module that takes the component parts and creates the main chassis base
module chassisBaseAssembly()
{
	difference()
	{
		//Join these objects
		union()
		{
			translate([0,0,-2]) chassisBase();
			translate([20,17.5,11]) rotate([0,90,0]) stepperMountingTab();
			translate([-22,17.5,11]) rotate([0,90,0]) stepperMountingTab();
			translate([20,-17.5,11]) rotate([0,90,0]) stepperMountingTab();
			translate([-22,-17.5,11]) rotate([0,90,0]) stepperMountingTab();
		}

		//subtract these objects
		union()
		{
			//Test subtract motors shapes to see what material we need to remove
			translate([1,0,11]) rotate([90,180,90]) stepper28BYJ();
			translate([-1,0,11]) rotate([270,0,90]) stepper28BYJ();

			//Cutout for motor boss			
			translate([18,0,5]) rotate([0,90,0]) cylinder(r=9/2, h=2, $fn=40);
			translate([20.5,0,10.5]) rotate([0,90,0]) cube([15,9,2], center=true);

			//Cutout for motor shaft
			translate([22.5,0,10.5]) rotate([0,90,0]) cube([15,3,2], center=true);
		}
	
	}//end of difference

}//end of chassisBaseAssembly() module

chassisBaseAssembly();

//translate([18,0,5]) rotate([0,90,0]) cylinder(r=9/2, h=2, $fn=40);