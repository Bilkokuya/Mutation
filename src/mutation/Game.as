package mutation 
{
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.hats.HatDescriptor;
	import mutation.entity.items.Item;
	import mutation.entity.items.ItemDescriptor;
	import mutation.entity.levelling.Level;
	import mutation.util.Resources;

	public class Game 
	{
		public static var hats:Vector.<HatDescriptor> = new Vector.<HatDescriptor>();
		public static var foods:Vector.<FoodDescriptor> = new Vector.<FoodDescriptor>();
		public static var items:Vector.<ItemDescriptor> = new Vector.<ItemDescriptor>();
		public static var levels:Vector.<Level> = new Vector.<Level>();
		
		public static var selectedFood:Number = 1;
		
		public function Game();
		
		//	Initialises the game
		public static function init():void
		{
			initHats(Resources.getXML(Resources.XML_HATS));
			initFoods(Resources.getXML(Resources.XML_FOODS));
			initItems(Resources.getXML(Resources.XML_ITEMS));
			initLevels(Resources.getXML(Resources.XML_LEVELS));
		}
		
		//	Loads the Hats data from XML
		private static function initHats(xml:XML):void
		{
			var hatList:XMLList = xml.hat;
			for each (var hatXML:XML in hatList) {
				hats.push( new HatDescriptor(hatXML) );
			}
		}
		
		//	Loads the Food data from XML
		private static function initFoods(xml:XML):void
		{
			var foodList:XMLList = xml.food;
			for each (var foodXML:XML in foodList) {
				foods.push( new FoodDescriptor(foodXML) );
			}
		}
		
		//	Loads the Items data from XML
		private static function initItems(xml:XML):void
		{
			var itemList:XMLList = xml.item;
			for each (var itemXML:XML in itemList) {
				items.push( new ItemDescriptor(itemXML) );
			}
		}
		
		//	Loads the level (experience level) data from XML
		private static function initLevels(xml:XML):void
		{
			var levelList:XMLList = xml.level;
			for each (var levelXML:XML in levelList) {
				levels.push( new Level(levelXML) );
			}
		}
		
	}

}