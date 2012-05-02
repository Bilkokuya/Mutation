package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import mutation.util.Resources;
	
	public class Hat extends Sprite
	{
		private var type:HatDescriptor;
		private var bitmap:Bitmap;
		
		public function Hat(hatType:HatDescriptor) 
		{
			super();
			this.type = hatType;
			
			this.bitmap = new Resources.GRAPHICS[type.bitmapIndex];
			addChild(bitmap);
			bitmap.width = 15;
			bitmap.height = 15;
			bitmap.x = - bitmap.width / 2;
			bitmap.y = - bitmap.height / 2;
		}
		
		public function get foodRateScale():Number 
		{
			return type.foodRateScale;
		}
		
		public function get foodAmountScale():Number 
		{
			return type.foodAmountScale;
		}
		
		public function get moneyAmountScale():Number 
		{
			return type.moneyAmountScale;
		}
		
		public function get moneyRateScale():Number 
		{
			return type.moneyRateScale;
		}
	}

}