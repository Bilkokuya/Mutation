package mutation.ui 
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;
	import mutation.events.BacteriaEvent;
	import mutation.events.ButtonEvent;
	import mutation.events.MutationEvent;
	import mutation.Game;
	import mutation.util.Resources;
	
	import mutation.ui.Button;
	
	public class UI extends Sprite
	{
		private var game:Game;
		public var moneyOut:TextField;
		public var collectedOut:TextField;
		public var collectButton:Button;
		public var bacteriaButton:Button;
		public var foodSelector:FoodSelector;
		public var unlockables:Unlockables;
		
		public function UI(game:Game) 
		{
			this.game = game;
			moneyOut = new TextField();
			collectedOut = new TextField();
			collectButton = new Button(275, 20, "COLLECT", 100, 50);
			bacteriaButton = new Button(50, 20, "BACTERIA", 75, 30);
			foodSelector = new FoodSelector(game);
			unlockables = new Unlockables(game);
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);

			addChild(moneyOut);
			addChild(bacteriaButton);
			addChild(collectButton);
			addChild(collectedOut);
			addChild(foodSelector);
			addChild(unlockables);
			
			unlockables.x = 350;
			
			foodSelector.maxFood = Resources.FOOD_TYPES.length - 1;
			foodSelector.x = 100;
			foodSelector.y = 25;
			game.foodSelection = foodSelector.minFood;
			
			var format:TextFormat = new TextFormat();
			format.size = 48;
			format.font = "Calibri";
			format.bold = true;
			format.color = 0xFF6600;
			format.align = TextFormatAlign.LEFT;
			
			moneyOut.x = 3 * stage.stageWidth / 4;
			moneyOut.y = 4 * stage.stageHeight / 5;
			moneyOut.autoSize = TextFieldAutoSize.RIGHT;
			moneyOut.defaultTextFormat = format;
			moneyOut.selectable = false;
			
			collectedOut.x = 275;
			collectedOut.y = 12;
			collectedOut.autoSize = TextFieldAutoSize.LEFT;
			collectedOut.selectable = false;	
			
			moneyOut.text = "$" + game.money;
			collectedOut.text = game.collected + "/ 1000";
			
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		private function onTick(e:MutationEvent):void
		{
			moneyOut.text = "$" + game.money;
		}
		
	}

}