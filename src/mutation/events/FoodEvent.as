package mutation.events 
{
	import flash.events.Event;
	import mutation.entity.foods.Food;
	
	public class FoodEvent extends Event 
	{
		public static const DEATH:String = "FOOD_DEATH";
		public static const UNLOCK:String = "FOOD_UNLOCK";
		public var food:Food;
		
		public function FoodEvent(type:String, food:Food, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.food = food;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new FoodEvent(type, food, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FoodEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}