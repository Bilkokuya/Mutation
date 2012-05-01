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
	import flash.text.TextFieldType;
	import mutation.container.Background;
	import mutation.entity.Bacteria;
	import mutation.events.BacteriaEvent;
	import mutation.ui.Button;
	import mutation.ui.NameBacteriaDisplay;

	import mutation.events.MutationEvent;
	import mutation.entity.TestTube;
	import mutation.util.Keys;
	import mutation.events.ButtonEvent;
	
	//	Class: Main extends Sprite
	//	The main game class with main loop
	public class Main extends Sprite 
	{
		static public var money:int;
		static public var isPaused:Boolean = false;
		public const BACTERIA_COST:Number = 150;
		
		private var tickCount:int;
		private var testTube:TestTube;
		private var moneyOut:TextField;
		private var bacteriaButton:Button;
		private var popup:NameBacteriaDisplay;
		
		//	Constructor: default
		public function Main():void 
		{			 
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation once the stage is created
		private function onInit(e:Event = null):void 
		{	
			testTube = new TestTube(125, 200, 100);
			moneyOut = new TextField();
			bacteriaButton = new Button(100,20,"BACTERIA", 75, 30);
			popup = new NameBacteriaDisplay(stage.stageWidth/2, stage.stageHeight/2);
			
			Keys.init(stage);
			
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
			
			tickCount = 0;
			money = 50;
			
			addChild(testTube);
			addChild(moneyOut);
			addChild(bacteriaButton);
			addChild(popup);
			
			popup.display(new Bacteria(0, 0, 5));
			isPaused = true;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(ButtonEvent.CLICKED, onButton);
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		//	Listener: onTick
		//	Runs once per frame as the main loop
		private function onTick(e:Event):void
		{
			if (!isPaused){
				tickCount++;
				moneyOut.text = "$" + money;
				
				//	Dispatch the main game tick event
				stage.dispatchEvent(new MutationEvent(MutationEvent.TICK, tickCount));
			}
		}
		
		private function onButton(e:ButtonEvent):void
		{
			if (e.buttonName == "BACTERIA") {
				if (money < BACTERIA_COST) {
					return;
				}else {
					money -= BACTERIA_COST;
				}
				popup.display(new Bacteria(0,0,5));
				isPaused = true;
				popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			}
		}
		
		private function onBacteriaNamed(e:BacteriaEvent):void
		{
			popup.hide();
			isPaused = false;
			testTube.spawnBacteria(e.bacteria);
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
	}

}
