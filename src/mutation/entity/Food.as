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
		public function Food(x:Number = 0, y:Number = 0) {
			
			this.x = x;
			this.y = y;
			
			draw();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(MutationEvent.TICK, onTick);
		}
		
		//	OnTick Updates
		private function onTick(e:MutationEvent):void {
		}
		
		//	Draw the graphics representation
		private function draw():void {
			graphics.beginFill(0x00FF66);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
	
		
	}

}