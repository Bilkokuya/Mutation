//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and such like

package mutation
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mutation.entity.Bacteria;

	import mutation.events.MutationEvent;
	import mutation.entity.TestTube;
	import mutation.util.Keys;
	
	//	Class: Main extends Sprite
	//	The main game class with main loop
	public class Mutation extends Sprite 
	{
		static public var money:int;
		
		private var tickCount:int;
		private var testTube:TestTube;
		private var moneyOut:TextField;
		
		//	Constructor: default
		public function Mutation():void 
		{			 
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation once the stage is created
		private function onInit(e:Event = null):void 
		{	
			testTube = new TestTube(100, 200, 100);
			moneyOut = new TextField();
		
			Keys.init(stage);
			
			var format:TextFormat = new TextFormat();
			format.size = 48;
			format.font = "Calibri";
			format.bold = true;
			format.color = 0xFF6600;
			format.align = TextFormatAlign.LEFT;
			
			moneyOut.x = 3 * stage.stageWidth / 4;
			moneyOut.y = 4 * stage.stageHeight / 5;
			moneyOut.autoSize = TextFieldAutoSize.LEFT;
			moneyOut.defaultTextFormat = format;
			
			tickCount = 0;
			money = 50;
			
			addChild(testTube);
			addChild(moneyOut);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Listener: onTick
		//	Runs once per frame as the main loop
		private function onTick(e:Event):void
		{
			tickCount++;
			
			moneyOut.text = "$" + money;
			
			//	Dispatch the main game tick event
			stage.dispatchEvent(new MutationEvent(MutationEvent.TICK, tickCount));
		}
		
	}

}
