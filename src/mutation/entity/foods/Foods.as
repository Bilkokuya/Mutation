package mutation.entity.foods 
{
	public class Foods 
	{
		
		public function Foods() 
		{
		}
		
		private static var selectedFood:int = 0;
		private static const NUMBER_OF_FOODS:int = 1;
		
		public static const SMALL_DEBRIS:BaseFood = new BaseFood(2.5, 0xFF6600, 100);
		public static const BIG_DEBRIS:BaseFood = new BaseFood(2.5, 0xFF22FF, 8);
		
		public static const FOOD_TYPES:Array = new Array(
			new BaseFood(5, 0xFF6600, 200, SMALL_DEBRIS, 3),
			new BaseFood(6, 0xFF00FF, 200, BIG_DEBRIS, 5)
		);
		
		
		
		public static function nextFood():int
		{
			selectedFood++;
			if (selectedFood > NUMBER_OF_FOODS) {
				selectedFood = 0;
			}
			return selectedFood;
		}
		
		public static function lastFood():int
		{
			selectedFood--;
			if (selectedFood < 0) {
				selectedFood = NUMBER_OF_FOODS;
			}
			return selectedFood;
		}
		
		public static function thisFood():int
		{
			return selectedFood;
		}
		
		public static function getFood():BaseFood
		{
			return FOOD_TYPES[selectedFood];
		}
	}

}