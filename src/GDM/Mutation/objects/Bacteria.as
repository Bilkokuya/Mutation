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
	import GDM.Mutation.events.ButtonEvent;
	import GDM.Mutation.events.MutationEvent;
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{		
		public var food:int;		//	Currently food level for this colony
		public var production:int;	//	Percent towards next production
		private var randomNum:Number;
		
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
			
			graphics.beginFill(0x0066FF, 0.3);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		//	Function: update
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent = null):void
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
			
			x += Math.random() * 5 - 2.5;
			y += Math.random() * 5 - 2.5;
		}
		
		//	Function: kill
		//	Kills this bacteria, dispatching it's death event
		public function kill():void
		{
			
		}
	}

}