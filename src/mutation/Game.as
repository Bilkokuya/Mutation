package mutation 
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import mutation.entity.Bacteria;
	import mutation.entity.BaseDescriptor;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.hats.HatDescriptor;
	import mutation.entity.items.Item;
	import mutation.entity.items.ItemDescriptor;
	import mutation.entity.levelling.Level;
	import mutation.entity.TestTube;
	import mutation.entity.Unlockables;
	import mutation.events.BacteriaEvent;
	import mutation.events.ButtonEvent;
	import mutation.events.ContractEvent;
	import mutation.events.MoneyEvent;
	import mutation.events.MutationEvent;
	import mutation.ui.contracts.Contract;
	import mutation.ui.screens.ContractChoice;
	import mutation.ui.contracts.ContractDescriptor;
	import mutation.ui.FoodSelector;
	import mutation.ui.NameBacteriaDisplay;
	import mutation.ui.screens.PauseMenu;
	import mutation.ui.UI;
	import mutation.util.Resources;

	public class Game extends Sprite
	{
		public const NUM_TUBES:Number = 4;
		public var BACTERIA_COST:Number = 250;	//	Cost of buying a new bacteria
		public var bacteriaCount:int = 0;
		
		public var hats:Unlockables = new Unlockables(HatDescriptor, Resources.getXML(Resources.XML_HATS).hat);				//	Hat types that have been unlocked
		public var foods:Unlockables = new Unlockables(FoodDescriptor, Resources.getXML(Resources.XML_FOODS).food);	//	Food types that have been unlocked
		
		//	Abuse of Unlockables type for contracts, but it shares so much functionality it is worth it. Can be refactored later
		public var contracts:Unlockables = new Unlockables(ContractDescriptor, Resources.getXML(Resources.XML_CONTRACTS).contract);
		
		public var ui:UI;	//	UI overlay, handles all upgrades etc, passes info back to the game

		public var money_:int = 50;								//	Money for buying food  and upgrades
		
		public var contractSelector:ContractChoice;
		public var contract:Contract;
		
		public var testTubes:Vector.<TestTube>;		//	Test Tubes that hold the individual bacteria
		public var foodSelection:int;							//	Current food selected
		private var popup:NameBacteriaDisplay;	//	Popup that appears when a bacteria is spawned
		private var pauseMenu:PauseMenu;
		
		public function Game()
		{
			foodSelection = 1;
			
			ui = new UI(this);
			
			testTubes = new Vector.<TestTube>();
			pauseMenu = new PauseMenu();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			popup = new NameBacteriaDisplay(this, stage.stageWidth / 2, stage.stageHeight / 2);
			
			contractSelector = new ContractChoice(this);
			
			for (var i:int = 0; i < NUM_TUBES; ++i){
				testTubes.push( new TestTube(this, ((stage.stageWidth - (NUM_TUBES * 75)) / 2)  + (i * 100), 200, 60) );
				addChild(testTubes[i]);
			}
			
			addChild(ui);
			addChild(popup);
			addChild(contractSelector);
			addChild(pauseMenu);
			pauseMenu.visible = false;
			
			Main.isPaused = true;
			
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); 
			ui.collectButton.addEventListener(ButtonEvent.CLICKED, onCollected);
			ui.bacteriaButton.addEventListener(ButtonEvent.CLICKED, onButton);
			contractSelector.addEventListener(ContractEvent.SELECTED, onContract);
			stage.addEventListener(ContractEvent.COMPLETED, onContractComplete);
			stage.addEventListener(MutationEvent.TICK_MAIN, onTick);
			stage.addEventListener(BacteriaEvent.DEATH, onBacteriaDeath);
		}
		
		private function onTick(e:MutationEvent):void
		{
			if ( (money < BACTERIA_COST) && (bacteriaCount < 1) ) {
				Main.isPaused = true;
				popup.display(new Bacteria(this, 0, 0, 5));
			}
		}
		
		//	Recursively kills itself and then everything it holds
		public function kill():void
		{
			if (stage){
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); 
			}
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			ui.collectButton.removeEventListener(ButtonEvent.CLICKED, onCollected);
			ui.bacteriaButton.removeEventListener(ButtonEvent.CLICKED, onButton);

			ui.kill();
			for each (var testTube:TestTube in testTubes) {
				testTube.kill();
			}
			pauseMenu.kill();
			popup.kill();
			contract.kill();
		}
		
		private function onContract(e:ContractEvent):void
		{
			contract = e.contract;
			Main.isPaused = false;
			stage.dispatchEvent(new ContractEvent( ContractEvent.CHANGED, contract) );
		}
		
		private function onContractComplete(e:ContractEvent):void
		{
			money += e.contract.type.bonus;
		}
		
		//	Called when the new Bacteria button is pressed
		private function onButton(e:ButtonEvent):void
		{
			if (money > (BACTERIA_COST * (bacteriaCount*bacteriaCount))) {
				money -= (BACTERIA_COST * (bacteriaCount*bacteriaCount)) ;
			}else {
				return;
			}
			popup.display(new Bacteria(this, 0,0,5));
			Main.isPaused = true;
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		//	Called when a bacteria has been given a name
		private function onBacteriaNamed(e:BacteriaEvent):void
		{
			bacteriaCount++;
			popup.hide();
			Main.isPaused = false;
			testTubes[0].spawnBacteria(e.bacteria);
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		private function onBacteriaDeath(e:BacteriaEvent):void
		{
			bacteriaCount--;
		}
		
		//	Called when the collection is emptied (clicked on)
		private function onCollected(e:ButtonEvent):void
		{
			if (contract.isFilled()) {
				money += contract.type.payPerBox;
				contract.ship();
			}
		}
		
		//	Debug/Cheat code button - MUST REMOVE BEFORE HAND-IN
		//	Adds 1000 money when you hit the space bar
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE) {
				money += 1000;
			}else if (e.keyCode == Keyboard.ESCAPE) {
				if (Main.isPaused) {
					Main.isPaused = false;
					pauseMenu.visible = false;
				}else{
					pauseMenu.visible = true;
					Main.isPaused = true;
				}
			}
		}

		//	Setter for money, dispatches the change in case UI cares
		public function set money(amount:int):void
		{
			money_ = amount;
			stage.dispatchEvent(new MoneyEvent(MoneyEvent.CHANGED, money_));
		}
		
		//	Getter for money
		public function get money():int
		{
			return money_;
		}
		
	}

}