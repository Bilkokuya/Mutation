package mutation.entity.hats 
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Hat extends Sprite
	{
		protected var colour:int;
		
		public function Hat(colour:int = 0xFF00FF) 
		{
			super();
			this.colour = colour;
			draw();
			
			if (stage) onInit;
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(colour);
			graphics.drawRect( -2, -4, 4, 6);
			graphics.endFill();
		}
	}

}