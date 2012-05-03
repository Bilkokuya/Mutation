package mutation.entity.foods 
{
	import flash.display.Sprite;
	
	public class FoodDescriptor
	{
		public var graphic:int;
		public var radius:Number;
		public var foodAmount:int;
		public var debrisCount:int;
		public var debrisType:int;
		public var startingLife:int;
		public var names:String;
		public var isUnlocked:Boolean;
		public var unlockCost:Number;
		
		public function FoodDescriptor(xml:XML) 
		{
			this.graphic 		= xml.graphic;
			this.radius 		= xml.radius;
			this.foodAmount 	= xml.foodAmount;
			this.debrisType 	= xml.debrisType;
			this.debrisCount 	= xml.debrisCount;
			this.startingLife 	= xml.life;
			this.names 			= xml.name;
			
			isUnlocked 			= xml.unlock.unlocked;
			unlockCost 			= xml.unlock.cost;
		}
		
	}

}