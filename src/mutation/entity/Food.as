//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Food
//		A floating food object that can be consumed by the bacteria


package mutation.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import GDM.Mutation.events.MutationEvent;

	//	Class: Food
	public class Food extends Sprite
	{
		
		//	Constructor: default
		public function Food() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises once the stage has been created
		private function onInit(e:Event = null):void
		{
			graphics.beginFill(0x33FF33, 0.8);
			graphics.drawRect( -5, -2, 10, 4);
			graphics.endFill();
			rotation = Math.random() * 90;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(MutationEvent.TICK, onTick);
		}
		
		private function onTick(e:MutationEvent):void
		{
			if (e.tickCount % 15 == 0) {
				
			}
		}
		
	
		
	}

}