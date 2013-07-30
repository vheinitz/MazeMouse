//Battery holder mockup
//2x2 configuration

module batteryBox()
{
//Battery size
AA = [ 14.5, 50.5 ];

color("black")
difference()
{
	hull()
	{
		color("blue") translate([0,0,0]) cylinder(r=AA[0]/2+1, h=AA[1]+4, $fn=50);

		color("blue") translate([AA[0]+1,0,0]) cylinder(r=AA[0]/2+1, h=AA[1]+4, $fn=50);

		color("blue") translate([AA[0]+1,AA[0]+1,0]) cylinder(r=AA[0]/2+1, h=AA[1]+4, $fn=50);

		color("blue") translate([0,AA[0]+1,0]) cylinder(r=AA[0]/2+1, h=AA[1]+4, $fn=50);
	}

	translate([0,0,2]) union()
	{
		color("blue") translate([0,0,0]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

		color("blue") translate([AA[0]+1,0,0]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

		color("blue") translate([AA[0]+1,AA[0]+1,0]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

		color("blue") translate([0,AA[0]+1,0]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);
	}

	translate([-10,-10,2]) cube([40,10,50.5]);
	translate([-10,15,2]) cube([40,10,50.5]);
}//end of difference

		color("blue") translate([0,0,2]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

		color("blue") translate([AA[0]+1,0,2]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

		color("blue") translate([AA[0]+1,AA[0]+1,2]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

		color("blue") translate([0,AA[0]+1,2]) cylinder(r=AA[0]/2, h=AA[1], $fn=50);

}//end of batteryBox(); module

//batteryBox();