package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Hat extends Sprite
	{
		public var bitmap:Bitmap;
		
		public function Hat(image:Class) 
		{
			super();
			this.bitmap = new image();
			addChild(bitmap);
			bitmap.width = 15;
			bitmap.height = 15;
			bitmap.x = - bitmap.width / 2;
			bitmap.y = - bitmap.height / 2;
		}
	}

}