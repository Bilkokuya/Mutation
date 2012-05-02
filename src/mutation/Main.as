//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and such like

package mutation
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import mutation.container.Background;
	import mutation.entity.Bacteria;
	import mutation.entity.Food;
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
		static public var money:int = 250;
		static public var collected:int = 0;
		static public var isPaused:Boolean = false;
		public const BACTERIA_COST:Number = 150;
		public const FOOD_UPGRADE_COST:Number = 250;
		
		private var tickCount:int = 0;
		private var testTube:TestTube;
		private var moneyOut:TextField;
		private static var collectedOut:TextField;
		private var collectButton:Button;
		private var bacteriaButton:Button;
		private var upgradeFood:Button;
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
			collectedOut = new TextField();
			collectButton = new Button(350, 20, "COLLECT", 100, 50);
			bacteriaButton = new Button(100, 20, "BACTERIA", 75, 30);
			upgradeFood = new Button(200, 20, "FOOD", 75, 30);
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
			moneyOut.selectable = false;
			
			collectedOut.x = 320;
			collectedOut.y = 12;
			collectedOut.autoSize = TextFieldAutoSize.LEFT;
			collectedOut.selectable = false;
			
			addChild(testTube);
			addChild(moneyOut);
			addChild(bacteriaButton);
			addChild(collectButton);
			addChild(collectedOut);
			addChild(upgradeFood);
			addChild(popup);
			
			moneyOut.text = "$" + money;
			collectedOut.text = collected + "/ 1000";
			
			popup.display(new Bacteria(0, 0, 5));
			isPaused = true;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
			bacteriaButton.addEventListener(ButtonEvent.CLICKED, onButton);
			upgradeFood.addEventListener(ButtonEvent.CLICKED, onFoodUpgrade);
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			collectButton.addEventListener(ButtonEvent.CLICKED, onCollected);
		}
		
		//	Used to collect items into the chest, when clicked
		public static function collect(amount:int):void
		{
			collected += amount;
			
			if (collected < 0) {
				collected = 0;
			}else if (collected > 1000) {
				collected = 1000;
			}
			collectedOut.text = collected + "/ 1000";
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
		
		//	Called when the new Bacteria button is pressed
		private function onButton(e:ButtonEvent):void
		{
			if (money < BACTERIA_COST) {
				return;
			}else {
				money -= BACTERIA_COST;
			}
			popup.display(new Bacteria(0,0,5));
			isPaused = true;
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		//	Called when the upgrade food button is pressed
		private function onFoodUpgrade(e:ButtonEvent):void
		{
			if (money < FOOD_UPGRADE_COST) {
				return;
			}else {
				money -= FOOD_UPGRADE_COST;
			}
			
		}
		
		//	Called when a bacteria has been given a name
		private function onBacteriaNamed(e:BacteriaEvent):void
		{
			popup.hide();
			isPaused = false;
			testTube.spawnBacteria(e.bacteria);
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		//	Called when the collection is emptied (clicked on)
		private function onCollected(e:ButtonEvent):void
		{
			if (collected >= 1000) {
				collected = 0;
				money += 500;
			}
			collectedOut.text = collected + "/ 1000";
		}
		
		//	Debug/Cheat code button - MUST REMOVE BEFORE HAND-IN
		//	Adds 1000 money when you hit the space bar
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE) {
				money += 1000;
			}
			moneyOut.text = "$" + money;
		}
	}

}
