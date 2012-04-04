package mutation.entity 
{
	import flash.display.Sprite;
	
	public class BaseFood extends Sprite
	{
		public var radius:Number;
		public var foodAmount:int;
		public var colour:Number;
		
		public function BaseFood(radius:Number, colour:Number, foodAmount:Number) 
		{
			this.radius = radius;
			this.colour = colour;
			this.foodAmount = foodAmount;
		}
		
	}

}