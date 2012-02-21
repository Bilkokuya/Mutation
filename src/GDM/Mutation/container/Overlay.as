//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Overlay
//		The UI and Menu overlay of the game
//		that will not scale at the same time as the world.

package GDM.Mutation.container 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;

	//	Class:	Overlay
	public class Overlay extends Sprite
	{
		private var moneyOut:TextField;

		//	Constructor: default
		public function Overlay() 
		{
			if (stage) {
				onInit();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		//	Function: onInit (Event = null)
		//	Initialises once the stage reference exists
		private function onInit(e:Event = null):void
		{
			moneyOut = new TextField();
			
			addChild(moneyOut);
			var format:TextFormat = new TextFormat("Arial", 60, 0xFF9900,true);
			
			moneyOut.text = "$1000";
			moneyOut.setTextFormat(format);
			moneyOut.defaultTextFormat = format;
			moneyOut.autoSize = TextFieldAutoSize.LEFT;
			moneyOut.x = stage.stageWidth - 170;
			moneyOut.y = stage.stageHeight - 70;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
	}

}