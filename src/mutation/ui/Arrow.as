package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.util.Resources;

	public class Arrow extends Sprite
	{
		public static const LEFT:int = 1;
		public static const RIGHT:int = -1;
		public var direction:int;
		private var bitmap:Bitmap;
		
		public function Arrow(direction:int) 
		{
			this.direction = direction;
			bitmap = new Resources.GFX_UI_ARROW;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(bitmap);
			bitmap.width = 20;
			bitmap.height = 20;
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
	}

}