// Wheel for maze mouse

// Shaft fitting for 28BYJ-48 geared stepper

// http://www.thingiverse.com/thing:122070

// Mark Benson

// 23/07/2013

// Creative commons non commercial

module mouseWheel()
{

difference()
{
	union()
	{
		//rim
		cylinder(r=60/2,h=4,$fn=100);

		//boss
		cylinder(r=12/2,h=7,$fn=100);
	}

	union()
	{
		//shaft cutout (shaft with flat)
		translate([0,0,1])
		intersection()
		{
			cylinder(r=5/2,h=8,$fn=40);
			translate([0,0,4]) cube([3,8,10], center=true);
		}

		//rim groove cutout
		translate([0,0,2])
		rotate_extrude(convexity=10, $fn=100)
		translate([30.5,0,10])
		rotate([0,0,45])
		square([2,2],center=true);

		//holes in the wheel
		for(i = [0:5])
		{
			rotate(i*360/6,[0,0,1])
			translate([18,0,-1])
			cylinder(r=16/2,h=8,$fn=40);
		}

	}
}

}//end mouseWheel();


//Call model to render, comment out if including in another model
//mouseWheel();