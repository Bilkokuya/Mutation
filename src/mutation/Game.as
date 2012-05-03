package mutation 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import mutation.entity.Bacteria;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.hats.HatDescriptor;
	import mutation.entity.items.Item;
	import mutation.entity.items.ItemDescriptor;
	import mutation.entity.levelling.Level;
	import mutation.entity.TestTube;
	import mutation.events.BacteriaEvent;
	import mutation.events.ButtonEvent;
	import mutation.events.MutationEvent;
	import mutation.ui.FoodSelector;
	import mutation.ui.NameBacteriaDisplay;
	import mutation.ui.UI;
	import mutation.util.Resources;

	public class Game extends Sprite
	{
		public const BACTERIA_COST:Number = 150;
		public const FOOD_UPGRADE_COST:Number = 250;
		
		public var background:Background;	//	Visual background of the game
		public var ui:UI;					//	UI overlay, handles all upgrades etc, passes info back to the game
		
		public var money:int = 250;
		public var collected:int = 0;
		
		public var testTubes:Vector.<TestTube>;
		public var foodSelection:int;
		private var popup:NameBacteriaDisplay;
		
		public function Game()
		{
			foodSelection = 1;
			
			testTubes = new Vector.<TestTube>();
			background = new Background();
			ui = new UI(this);
			
			testTubes.push( new TestTube(this, 125, 200, 100) );
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			popup = new NameBacteriaDisplay(this, stage.stageWidth / 2, stage.stageHeight / 2);
					
			addChild(testTubes[0]);
			
			addChild(ui);
			addChild(popup);
			
			popup.display(new Bacteria(this, 0, 0, 5));
			Main.isPaused = true;
			
			stage.addEventListener(MutationEvent.TICK, onTick);
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); 
			ui.collectButton.addEventListener(ButtonEvent.CLICKED, onCollected);
			ui.bacteriaButton.addEventListener(ButtonEvent.CLICKED, onButton);
		}
		
		//	Update eac tick
		private function onTick(e:MutationEvent):void
		{
			
		}
		
		//	Used to collect items into the chest, when clicked
		public function collect(amount:int):void
		{
			collected += amount;
			
			if (collected < 0) {
				collected = 0;
			}else if (collected > 1000) {
				collected = 1000;
			}
			ui.collectedOut.text = collected + "/ 1000";
		}
		
				
		//	Called when the new Bacteria button is pressed
		private function onButton(e:ButtonEvent):void
		{
			if (money < BACTERIA_COST) {
				return;
			}else {
				money -= BACTERIA_COST;
			}
			popup.display(new Bacteria(this, 0,0,5));
			Main.isPaused = true;
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		//	Called when a bacteria has been given a name
		private function onBacteriaNamed(e:BacteriaEvent):void
		{
			popup.hide();
			Main.isPaused = false;
			testTubes[0].spawnBacteria(e.bacteria);
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		//	Called when the collection is emptied (clicked on)
		private function onCollected(e:ButtonEvent):void
		{
			if (collected >= 1000) {
				collected = 0;
				money += 500;
			}
			ui.collectedOut.text = collected + "/ 1000";
		}
		
		//	Debug/Cheat code button - MUST REMOVE BEFORE HAND-IN
		//	Adds 1000 money when you hit the space bar
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE) {
				money += 1000;
			}
			ui.moneyOut.text = "$" + money;
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