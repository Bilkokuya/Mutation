package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Hat extends Sprite
	{
		public var bitmap:Bitmap;
		public var foodRateScale:Number;
		public var foodAmountScale:Number;
		public var moneyAmountScale:Number;
		public var moneyRateScale:Number;
		
		public function Hat(image:Class, foodRate:Number = 1, foodAmount:Number = 1, moneyAmount:Number = 1, moneyRate:Number = 1) 
		{
			super();
			this.bitmap = new image();
			addChild(bitmap);
			bitmap.width = 15;
			bitmap.height = 15;
			bitmap.x = - bitmap.width / 2;
			bitmap.y = - bitmap.height / 2;
			
			foodRateScale = foodRate;
			foodAmountScale = foodAmount;
			moneyAmountScale = moneyAmount;
			moneyRateScale = moneyRate;
		}
	}

}