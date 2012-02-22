//	Copyright 2012 Gordon D McKendrick
//	Author: Gordon D Mckendrick
//	
//	Bacteria
//		A bacteria contained in a test tube, holding various genetic informations
//		Represents a single bacteria, which can be held in a test-tube

package GDM.Mutation.objects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import GDM.Mutation.events.ButtonEvent;
	import GDM.Mutation.events.MutationEvent;
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{		
		public var food:Number;			//	Currently food level for this colony
		public var production:int;		//	Percent towards next production
		private var randomNum:Number;
		private var randomNum2:Number;
		
		//	Constructor: default
		public function Bacteria() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises this bacteria once added to the stage correctly
		public function onInit(e:Event = null):void
		{
			food = 100;
			production = 0;
			
			draw();
			
			randomNum = 0;
			randomNum2 = 0;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		//	Function: update
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent = null):void
		{
			//	Refill the random every 1/2 second
			if ((e.tickCount % 15) == 0) randomNum = Math.random() - 0.5;
			if ((e.tickCount % 15) == 0) randomNum2 = Math.random() - 0.5;
			
			//	Process the food etc (move to FSM)
			if (e.tickCount%5 == 0){
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
				
				if (food > 100) food = 100;
				
				updateColour(food);
			}
			
			//	Update the location "randomly"
			x += randomNum * 2;
			y += randomNum2 * 2;
			
			
			//	Ensure movement is within bounds, by radius
			if (Math.sqrt((x * x) + (y * y)) > 60) {
				randomNum *= -1;
				randomNum2 *= -1;
				
				if (x > 0) x--;
				else x++;

				if (y > 0) y--;
				else y++;
			}
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x0066FF, 0.3);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
		
		private function updateColour(food:int):void
		{
			var factor:Number = food * 5;
			if ( factor > 100) factor = 100;
			factor = factor / 100;
			
			this.transform.colorTransform = new ColorTransform(1, factor, factor, 1, 255*(1-factor) );
		}
		
		
		//	Function: kill
		//	Kills this bacteria, dispatching it's death event
		public function kill():void
		{
			
		}
	}

}