package mutation.entity.hats 
{
	import flash.display.Bitmap;

	public class PrettyHat extends Hat
	{
		[Embed(source="../../../../resources/gfx/prettyhat.png")]
		private var BITMAP:Class;
		
		public function PrettyHat() 
		{
			super(BITMAP, 1, 1, 1, 1);
		}
		
	}

}