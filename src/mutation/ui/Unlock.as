package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Unlock extends Sprite
	{
		public var bitmap:Bitmap;
		public var index:int;
		
		public function Unlock(bitmap:Bitmap, index:int) 
		{
			this.bitmap = bitmap;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(bitmap);

			bitmap.width = 50;
			bitmap.height = 50;
		}
		
		public function setBitmap(bitmap:Bitmap):void
		{
			removeChild(this.bitmap);
			this.bitmap = bitmap;
			addChild(this.bitmap);
			this.bitmap.width = 50;
			this.bitmap.height = 50;
		}
	}

}