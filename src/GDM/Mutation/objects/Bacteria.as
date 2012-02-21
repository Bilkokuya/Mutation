//	Copyright 2012 Gordon D McKendrick
//	Author: Gordon D Mckendrick
//	
//	Bacteria
//		A bacteria contained in a test tube, holding various genetic informations
//		Represents a single bacteria, which can be held in a test-tube

package GDM.Mutation.objects 
{
	
	//	Class: bacteria
	public class Bacteria 
	{		
		public var food:int;		//	Currently food level for this colony
		public var production:int;	//	Percent towards next production
		public var productionNeeded:int;
		
		//	Constructor: default
		public function Bacteria() 
		{
			food = 100;
			production = 0;
			productionNeeded = 20000;
		}
		
		//	Function: update
		//	Updates the logic of this each frame, needs to be called by it's container
		public function update():void
		{
			if (food > 75) {
				production += 2;
				food--;
			}else if ( food > 50) {
				production++;
				food--;
			}else if (food < 0) {
				kill();
			}else {
				food--;
			}
		}
		
		//	Function: kill
		//	Kills this bacteria, dispatching it's death event
		public function kill():void
		{
			
		}
	}

}