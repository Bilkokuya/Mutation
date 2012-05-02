package mutation.entity.foods 
{
	import flash.display.Sprite;
	
	public class BaseFood extends Sprite
	{
		public var radius:Number;
		public var foodAmount:int;
		public var colour:Number;
		public var debrisCount:int;
		public var debrisType:BaseFood;
		
		public function BaseFood(radius:Number, colour:Number, foodAmount:Number, debrisType:BaseFood = null, debrisCount:int = 0) 
		{
			this.radius = radius;
			this.colour = colour;
			this.foodAmount = foodAmount;
			this.debrisType = debrisType;
			this.debrisCount = debrisCount;
		}
		
	}

}