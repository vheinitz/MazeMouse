include <28BYJ-48-Stepper-Motor.scad>
include <wheel.scad>
include <battery.scad>


chassisWidth = 44;
chassisLenght = 60;
chassisBaseThickness = 4;
chassisCornerRadius = 6;

//Stepper motors (to check fit)
//translate([1,0,12]) rotate([90,0,90]) stepper28BYJ();
//translate([-1,0,12]) rotate([270,180,90]) stepper28BYJ();

//Wheels to check fit
color("green") translate([30,0,20]) rotate([270,0,90]) mouseWheel();
color("green") translate([-30,0,20]) rotate([90,180,90]) mouseWheel();

//16mm sphere to check marble fit
color("red") translate([0,50,3]) sphere(r=16/2, $fn=50);

//Battery module to check fit
translate([0,0,15]) batteryHolder();

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


//Module for the castor wheel (third wheel) that allow press fitting
//of a 16mm marble.
module castorWheelHousing()
{
	castorWheelHousingHeight = 4;
	castorWheelHousingLength = 20;
	standardMarbleDiameter = 16;

	difference()
	{
		union()
		{
			hull()
			{
				translate([0,0,castorWheelHousingHeight/2]) cube([30,1,castorWheelHousingHeight], center=true);
				translate([0,castorWheelHousingLength,0]) cylinder(r=12/2, h=castorWheelHousingHeight, $fn=40);
			}//end hull

			translate([0,castorWheelHousingLength,0]) cylinder(r=standardMarbleDiameter/2+1, h=standardMarbleDiameter+2, $fn=40);

		}//end union

		union()
		{
			//Cutout for Marble
			translate([0,castorWheelHousingLength,4]) sphere(r=standardMarbleDiameter/2+0.25, $fn=50);
			
			//Slot to allow plastic to deform when fitting marble
			translate([0,castorWheelHousingLength,0]) cube([40,4,22], center=true);
		}//end union

	}//end difference

}//end of module castorWheelHousing

//Module that takes the component parts and creates the main chassis base
module chassisBaseAssembly()
{
	difference()
	{
		//Join these objects
		union()
		{
			translate([0,0,-2]) chassisBase();
			translate([20,17.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([-22,17.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([20,-17.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([-22,-17.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([0,30,-2]) rotate([0,0,0]) castorWheelHousing();
		}

		//subtract these objects
		union()
		{
			//Test subtract motors shapes to see what material we need to remove
			translate([1,0,12]) rotate([90,0,90]) stepper28BYJ();
			translate([-0.9,0,12]) rotate([270,180,90]) stepper28BYJ();

			//Cutout for motor boss - not needed when motors have the shaft at the top	
			//Positive x side		
			//translate([19.5,0,4]) rotate([0,90,0]) cylinder(r=9/2, h=4, $fn=40);
			//translate([20.5,0,11.5]) rotate([0,90,0]) cube([15,9,4], center=true);

			//Negative x side
			//translate([-22.5,0,4]) rotate([0,90,0]) cylinder(r=9/2, h=4, $fn=40);
			//translate([-20.5,0,11.5]) rotate([0,90,0]) cube([15,9,4], center=true);

			//Not needed anymore as using the boss cutout to clear space for shaft
			//Cutout for motor shaft
			//translate([22.5,0,10.5]) rotate([0,90,0]) cube([15,3,2], center=true);
		}
	
	}//end of difference

}//end of chassisBaseAssembly() module

chassisBaseAssembly();





