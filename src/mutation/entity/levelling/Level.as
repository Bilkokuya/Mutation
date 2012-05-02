package mutation.entity.levelling 
{
	import flash.display.Sprite;
	import mutation.entity.Item;

	//	Simple data holding class for giving new values to the bacteria after it levels
	//	Used by the levelling systems
	public class Level 
	{
		public var experienceNeeded:Number;	//	Amount of experience needed to obtain this leel
		public var foodScale:Number;		//	Factor to scale the food-use of the bacteria by
		public var moneyScale:Number;		//	Factor to scale the amount of money produced by the bacteria
		public var moneyType:Class;			//	New money type, or null if the money type won't change this level
		public var visual:Sprite;			//	New visual appearance, or null if the appearance won't change this level
		
		public function Level(exp:Number, food:Number, money:Number, moneyTypeChange:Class = null, visualChange:Sprite = null) 
		{
			experienceNeeded = exp;
			foodScale = food;
			moneyScale = money;
			moneyType = moneyTypeChange;
			visual = visualChange;
		}
		
		//	Returns true if the level can be obtained with the given amount of exp
		public function canLevel(exp:Number):Boolean
		{
			return (exp >= experienceNeeded);
		}
	}

}