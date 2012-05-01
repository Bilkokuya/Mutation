package mutation.entity.hats 
{
	import flash.display.Bitmap;

	public class PrettyHat extends Hat
	{
		[Embed(source="../../../../resouces/gfx/prettyhat.png")]
		private var BITMAP:Class;
		
		public function PrettyHat() 
		{
			super(BITMAP);
		}
		
	}

}