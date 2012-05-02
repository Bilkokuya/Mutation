package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import mutation.util.Resources;

	//	Acts as a base clas for hats, can be loaded in from an XML object
	public class HatDescriptor 
	{
		public var bitmapIndex:int;
		public var foodRateScale:Number;
		public var foodAmountScale:Number;
		public var moneyAmountScale:Number;
		public var moneyRateScale:Number;
		public var isUnlocked:Boolean;
		public var unlockCost:Boolean;
		
		public function HatDescriptor(xml:XML) 
		{
			bitmapIndex = xml.graphic;
			var stats:XMLList = xml.stats;
			foodAmountScale = stats.foodAmount;
			foodRateScale = stats.foodRate;
			moneyAmountScale = stats.moneyAmount;
			moneyRateScale = stats.moneyRate;
		}
		
	}

}