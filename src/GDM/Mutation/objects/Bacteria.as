//	Copyright 2012 Gordon D McKendrick
//	Author: Gordon D Mckendrick
//	
//	Bacteria
//		A bacteria contained in a test tube, holding various genetic informations

package GDM.Mutation.objects 
{
	
	public class Bacteria 
	{
		public var name:String;
		
		public var food:int;		//	Currently food level for this colony
		public var production:int;	//	Percent towards next production
		public var productionNeeded:int;
		public var population:int;	//	Population of bacteria in this colony
		public var hunger:Number;		//	How hungry each member of population is
		public var prodrate:Number;
		
		//	Constructor: default
		public function Bacteria() 
		{
			name = "Bacteria";
			food = 15;
			production = 0;
			population = 10;
			hunger = 0.5;
			productionNeeded = 20000;
			prodrate = 0.3;
		}
		
		//	Function: update
		//	Updates the logic of this each frame, needs to be called by it's container
		public function update():void
		{
			food -= population * hunger;
			if (food<0){
				food -= population * prodrate;
				production += population * prodrate;
			}
			
			population += food;
		}
	}

}