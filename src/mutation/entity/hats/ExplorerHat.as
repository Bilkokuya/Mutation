package mutation.entity.hats 
{
	import flash.display.Bitmap;

	public class ExplorerHat extends Hat
	{
		[Embed(source="../../../../resources/gfx/explorerhat.png")]
		private var BITMAP:Class;
		
		public function ExplorerHat() 
		{
			super(BITMAP, 0.5, 1, 2, 1);
		}
		
	}

}