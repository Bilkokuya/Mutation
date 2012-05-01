package mutation.entity.hats 
{
	import flash.display.Bitmap;

	public class ExplorerHat extends Hat
	{
		[Embed(source="../../../../resouces/gfx/explorerhat.png")]
		private var BITMAP:Class;
		
		public function ExplorerHat() 
		{
			super(BITMAP);
		}
		
	}

}