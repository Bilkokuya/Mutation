package mutation.entity.foods 
{
	import flash.display.Sprite;
	
	public class FoodDescriptor
	{
		public var radius:Number;
		public var foodAmount:int;
		public var debrisCount:int;
		public var debrisType:int;
		public var startingLife:int;
		
		public var isUnlocked:Boolean;
		public var unlockCost:Number;
		
		public function FoodDescriptor(xml:XML) 
		{
			this.radius 		= xml.radius;
			this.foodAmount 	= xml.foodAmount;
			this.debrisType 	= xml.debrisType;
			this.debrisCount 	= xml.debrisCount;
			this.startingLife 	= xml.life;
			
			isUnlocked 			= xml.unlock.unlocked;
			unlockCost 			= xml.unlock.cost;
		}
		
	}

}