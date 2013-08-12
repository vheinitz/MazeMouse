// Maze Mouse 3D Printed Chassis

// Wide version 001

// Mark Benson

// 12/08/2013

// Creative Commons Non Commerical

include <28BYJ-48-Stepper-Motor.scad>
include <wheel.scad>
include <2x2-AA-battery-holder.scad>


chassisWidth = 55;
chassisLenght = 75;
chassisBaseThickness = 3;
chassisCornerRadius = 6;

//Stepper motors (to check fit)
//translate([5.4,-6,12.1]) rotate([90,0,90]) stepper28BYJ();
//translate([-5.4,-6,12.1]) rotate([270,180,90]) stepper28BYJ();

//Wheels to check fit
//color() translate([35,-6,20]) rotate([270,0,90]) mouseWheel();
//color() translate([-35,-6,20]) rotate([90,180,90]) mouseWheel();

//16mm sphere to check marble fit
//color("red") translate([0,58,3]) sphere(r=16/2, $fn=50);

//Battery module to check fit
//translate([-27,25,28]) rotate([0,90,0]) batteryBox();

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
			translate([5,0,1.5]) cube([10,10,3], center=true);
			translate([0,0,0]) cylinder(r=5,h=3,$fn=40);
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
	castorWheelHousingHeight = 6;
	castorWheelHousingLength = 30;
	standardMarbleDiameter = 16;
	castorWheelHousingWallThickness = 2.5;

	difference()
	{
		union()
		{
			hull()
			{
				translate([0,0,castorWheelHousingHeight/2]) cube([30,1,castorWheelHousingHeight], center=true);
				translate([0,castorWheelHousingLength,0]) cylinder(r=12/2, h=castorWheelHousingHeight, $fn=40);
			}//end hull

			translate([0,castorWheelHousingLength,0]) cylinder(r=standardMarbleDiameter/2+castorWheelHousingWallThickness, h=standardMarbleDiameter+2, $fn=40);

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

module reinforcingRib()
{
	difference()
	{
		cube([2.5,10,10], center=true);
		rotate([45,0,0]) translate([-2,-10,0]) cube([4,20,10], center=false);
	}
}//end of module reinforcingRib

//translate([0,43,9]) reinforcingRib();

//Module that takes the component parts and creates the main chassis base
module chassisBaseAssembly()
{
	
	difference()
	{
		//Join these objects
		
		union()
		{
			translate([0,-5,-2]) chassisBase();
			translate([24.5,11.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([-27.5,11.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([24.5,-23.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([-27.5,-23.5,12]) rotate([0,90,0]) stepperMountingTab();
			translate([0,28,-2]) rotate([0,0,0]) castorWheelHousing();
			translate([0,43,9]) reinforcingRib();
		}

		//subtract these objects
		union()
		{
			//Test subtract motors shapes to see what material we need to remove
			//translate([5.4,-6,12.1]) rotate([90,0,90]) stepper28BYJ();
			//translate([-5.4,-6,12.1]) rotate([270,180,90]) stepper28BYJ();

			translate([-4.2,-6,8]) rotate([270,180,90]) cylinder(r=29/2, h=20);

			translate([24.2,-6,8]) rotate([270,180,90]) cylinder(r=29/2, h=20);

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

			//Cutout for wiring
			//hull()
			//{
			//translate([0,3,-3]) rotate([0,0,0]) cylinder(r=5/2, h=10, $fn=40);
			//translate([0,-16,-3]) rotate([0,0,0]) cylinder(r=3.5, h=10, $fn=40);
			//}
			
			translate([0,-2,0])
			hull()
			{
			translate([-15,-25,-3]) rotate([0,0,0]) cylinder(r=4.5, h=10, $fn=40);
			translate([15,-25,-3]) rotate([0,0,0]) cylinder(r=4.5, h=10, $fn=40);
			}


			translate([0,3,0])
			hull()
			{
			translate([-15,12,-3]) rotate([0,0,0]) cylinder(r=4.5, h=10, $fn=40);
			translate([15,12,-3]) rotate([0,0,0]) cylinder(r=4.5, h=10, $fn=40);
			}
		}
	
	}//end of difference

}//end of chassisBaseAssembly() module

chassisBaseAssembly();





