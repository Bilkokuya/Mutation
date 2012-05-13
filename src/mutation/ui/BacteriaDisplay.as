package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mutation.entity.Bacteria;
	import mutation.Game;
	
	public class BacteriaDisplay extends PopupDisplay
	{
		private var nameField:TextField;
		private var foodField:TextField;
		private var productionField:TextField;
		private var game:Game;
		
		public function BacteriaDisplay(game:Game, x:Number, y:Number, width:Number, height:Number, length:Number = 10, thickness:Number = 20)
		{			
			this.game = game;
			
			nameField = new TextField();
			foodField = new TextField();
			productionField = new TextField();

			
			super(game, x, y, width, height, length, thickness);
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit)
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(nameField);
			addChild(foodField);
			addChild(productionField);
			
			var format:TextFormat = new TextFormat();
			format.size = 12;
			format.font = "Calibri";
			
			nameField.defaultTextFormat = format;
			foodField.defaultTextFormat = format;
			productionField.defaultTextFormat = format;
			
			nameField.x = arrowWidth_;
			nameField.y = (-boxHeight_/2) + 2;
			
			foodField.x = arrowWidth_;
			foodField.y = (-boxHeight_/2) + 17;
			
			productionField.x = arrowWidth_;
			productionField.y = (-boxHeight_/2) + 32;
		}
		
		public function update(names:String, food:Number, production:Number):void
		{
			nameField.text = "Name: " + names;
			foodField.text = "Money: " + food.toFixed(0);
			productionField.text = "Food: " + production.toFixed(0);
		}
	}

}