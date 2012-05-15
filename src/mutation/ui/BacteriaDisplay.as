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
		private var nameOut:TextField;
		private var foodOut:TextField;
		private var levelOut:TextField;
		private var game:Game;
		
		public function BacteriaDisplay(game:Game, x:Number, y:Number, width:Number, height:Number, length:Number = 10, thickness:Number = 20)
		{			
			this.game = game;
			
			nameOut = new TextField();
			foodOut = new TextField();
			levelOut = new TextField();

			
			super(game, x, y, width, height, length, thickness);
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit)
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(nameOut);
			addChild(foodOut);
			addChild(levelOut);
			
			var format:TextFormat = new TextFormat();
			format.size = 9;
			format.font = "Calibri";
			
			nameOut.defaultTextFormat = format;
			foodOut..defaultTextFormat = format;
			levelOut..defaultTextFormat = format;
			
			nameOut.x = arrowWidth_;
			nameOut.y = (-boxHeight_/2) + 2;
			
			foodOut.x = arrowWidth_;
			foodOut.y = (-boxHeight_/2) + 17;
			
			levelOut.x = arrowWidth_;
			levelOut.y = (-boxHeight_/2) + 32;
		}
		
		public function update(names:String, food:int, level:int):void
		{
			nameOut.text = "Name: " + names;
			foodOut.text = "Hunger: " + food + "%";
			levelOut.text = "Level: " + level;
		}
	}

}