package mutation.entity.hats 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import mutation.Game;
	import mutation.util.Resources;
	
	//	An instace of the hat itself; used by the bacteria visually and functionaly
	//	Based off of a HatDescriptor which describes it's behaviour
	//	Extends Sprite so it can be drawn to the stage
	public class Hat extends Sprite
	{
		private var game:Game;					//	Reference to the game being run
		
		public var type:HatDescriptor;		//	The base type this instance takes functionality from
		private var bitmap:Bitmap;				//	The visual element of this instance
		
		//	Constructor takes an existig HatDescriptor
		public function Hat(game:Game, hatType:HatDescriptor) 
		{
			this.game = game;
			
			super();
			this.type = hatType;
			
			//	Setup the bitmap to be visually cetered on the x,y co-ordinates
			this.bitmap = new Resources.GRAPHICS_HATS[type.graphic];
			addChild(bitmap);
			bitmap.width = 15;
			bitmap.height = 15;
			bitmap.x = - bitmap.width / 2;
			bitmap.y = - bitmap.height / 2;
		}
		
		//	Accessor for the foodRateScale found in the HatDescriptor - for backwards compatibility
		public function get foodRateScale():Number 
		{
			return type.foodRateScale;
		}
		
		//	Accessor for the foodAmountScale found in the HatDescriptor - for backwards compatibility
		public function get foodAmountScale():Number 
		{
			return type.foodAmountScale;
		}
		
		//	Accessor for the moneyAmountScale found in the HatDescriptor - for backwards compatibility
		public function get moneyAmountScale():Number 
		{
			return type.moneyAmountScale;
		}
		
		//	Accessor for the moneyRateScale found in the HatDescriptor - for backwards compatibility
		public function get moneyRateScale():Number 
		{
			return type.moneyRateScale;
		}
		
	}

}