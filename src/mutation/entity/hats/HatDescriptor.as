package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import mutation.util.Resources;

	//	Acts as a base class for hats, can be loaded in from an XML object
	//	Instances of hats take one of these hat descriptors to function
	public class HatDescriptor 
	{
		public var bitmapIndex:int;			//	Index in the resource list for this bitmap
		public var foodRateScale:Number;	//	Factor for the rate the food decreases at
		public var foodAmountScale:Number;	//	Factor for the amount of food the bacteria can hold
		public var moneyAmountScale:Number;	//	Factor for the amount of money the bacteria can hold
		public var moneyRateScale:Number;	//	Factor for the rate the money is created at
		
		public var isUnlocked:Boolean;		//	True if it is unlocked/useable by default
		public var unlockCost:Boolean;		//	Cost to unlock it (if it is not unlocked)
		
		//	Creates a new HatDescriptor from the XML input
		//	XML input expected to be just the XML for this hat node; not the entire file
		public function HatDescriptor(xml:XML) 
		{
			bitmapIndex 		= xml.graphic;
			var stats:XMLList 	= xml.stats;
			foodAmountScale 	= stats.foodAmount;
			foodRateScale 		= stats.foodRate;
			moneyAmountScale	= stats.moneyAmount;
			moneyRateScale 		= stats.moneyRate;
			
			isUnlocked 			= xml.unlock.unlocked;
			unlockCost 			= xml.unlock.cost;
		}
		
	}

}