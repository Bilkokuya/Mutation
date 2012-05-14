package mutation.entity.foods 
{
	import flash.display.Sprite;
	import mutation.entity.BaseDescriptor;
	
	public class FoodDescriptor extends BaseDescriptor
	{
		public var radius:Number;
		public var foodAmount:int;
		public var debrisCount:int;
		public var debrisType:int;
		public var startingLife:int;
		public var cost:int;
		
		public function FoodDescriptor(xml:XML) 
		{
			this.graphic 			= xml.graphic;
			this.radius 				= xml.radius;
			this.foodAmount 	= xml.foodAmount;
			this.debrisType 		= xml.debrisType;
			this.debrisCount 	= xml.debrisCount;
			this.startingLife 		= xml.life;
			this.names 				= xml.name;
			this.cost 					= xml.cost;
			
			(xml.unlock.unlocked == "true") ? isUnlocked = true : isUnlocked = false;
			unlockCost 				= xml.unlock.cost;
		}
		
	}

}