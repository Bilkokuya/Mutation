package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Arrow extends Sprite
	{
		public static const LEFT:int = -1;
		public static const RIGHT:int = 1;
		public var direction:int;
		
		public function Arrow(direction:int) 
		{
			this.direction = direction;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			draw();
			this.scaleX *= direction;
		}
		
		public function setUnselectable():void
		{
			alpha = 0.3;
		}
		
		public function setSelectable():void
		{
			alpha = 1;
		}
		
		private function draw():void
		{
			graphics.beginFill(0xFFFF00);
			graphics.drawRect(-10, -20, 20, 40);
			graphics.endFill();
		}
	}

}