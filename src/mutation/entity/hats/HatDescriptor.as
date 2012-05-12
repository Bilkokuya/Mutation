package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import mutation.entity.BaseDescriptor;
	import mutation.util.Resources;

	//	Acts as a base class for hats, can be loaded in from an XML object
	//	Instances of hats take one of these hat descriptors to function
	public class HatDescriptor extends BaseDescriptor
	{
		public var foodRateScale:Number;	//	Factor for the rate the food decreases at
		public var foodAmountScale:Number;	//	Factor for the amount of food the bacteria can hold
		public var moneyAmountScale:Number;	//	Factor for the amount of money the bacteria can hold
		public var moneyRateScale:Number;	//	Factor for the rate the money is created at
		
		//	Creates a new HatDescriptor from the XML input
		//	XML input expected to be just the XML for this hat node; not the entire file
		public function HatDescriptor(xml:XML) 
		{
			super();
			
			graphic 			= xml.graphic;
			names 				= xml.name;
			var stats:XMLList 	= xml.stats;
			foodAmountScale 	= stats.foodAmount;
			foodRateScale 		= stats.foodRate;
			moneyAmountScale	= stats.moneyAmount;
			moneyRateScale 		= stats.moneyRate;
			
			(xml.unlock.unlocked == "true") ? isUnlocked = true : isUnlocked = false;
			unlockCost 			= xml.unlock.cost;
		}
		
	}

}