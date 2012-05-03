package mutation 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.hats.HatDescriptor;
	import mutation.entity.items.Item;
	import mutation.entity.items.ItemDescriptor;
	import mutation.entity.levelling.Level;
	import mutation.entity.TestTube;
	import mutation.ui.FoodSelector;
	import mutation.util.Resources;

	public class Game extends Sprite
	{
		public var background:Background;	//	Visual background of the game
		public var ui:UI;					//	UI overlay, handles all upgrades etc, passes info back to the game
		
		public var testTubes:Vector.<TestTube>;
		public var foodSelector:FoodSelector;
		public var foodSelection:int;
		
		public function Game()
		{
			foodSelection = 0;
			
			background = new Background();
			foodSelector = new FoodSelector(this);
			
			testTube = new TestTube(125, 200, 100);
			
			ui = new UI();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addChild(foodSelector);
			foodSelector.maxFood = Resources.FOOD_TYPES.length - 1;
			foodSelector.x = 150;
			foodSelection = foodSelector.minFood;
			
		}
		
		public function get selectedFood():int
		{
			return foodSelection;
		}
		
		public function set selectedFood(value:int):void
		{
			foodSelection = value;
		}
		
	}

}