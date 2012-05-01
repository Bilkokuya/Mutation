package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class PirateHat extends Hat
	{
		[Embed(source = "../../../../resouces/gfx/piratehat.png")]
		private var BITMAP:Class;
		
		public function PirateHat() 
		{
			super(BITMAP);
		}
		
	}

}