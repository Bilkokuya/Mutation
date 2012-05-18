package mutation 
{
	import flash.display.GradientType;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
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
	import mutation.ui.contracts.ContractDescriptor;
	import mutation.ui.FoodSelector;
	import mutation.ui.screens.ContractScreen;
	import mutation.ui.screens.PauseScreen;
	import mutation.ui.screens.SpawnBacteriaScreen;
	import mutation.ui.UI;
	import mutation.util.Resources;

	public class Game extends Sprite
	{
		public const NUM_TUBES:Number = 4;				//	Number of test tubes allowed in game
		public const MAX_BACTERIA:Number = 4 * 5;
		private const BACTERIA_BASE_COST:Number = 250;	//	Cost of buying a new bacteria
		
		public var hats:Unlockables = new Unlockables(HatDescriptor, Resources.getXML(Resources.XML_HATS).hat);				//	Hat types that have been unlocked
		public var foods:Unlockables = new Unlockables(FoodDescriptor, Resources.getXML(Resources.XML_FOODS).food);	//	Food types that have been unlocked
		
		//	Abuse of Unlockables type for contracts, but it shares so much functionality it is worth it. Can be refactored later
		public var contracts:Unlockables = new Unlockables(ContractDescriptor, Resources.getXML(Resources.XML_CONTRACTS).contract);
		
		public var ui:UI;							//	UI overlay, handles all upgrades etc, passes info back to the game
		public var money_:int = 50;					//	Money for buying food  and upgrades
	
		public var contract:Contract;				//	Current contract for collecting items
		public var foodSelection:int;				//	Current food selected
		public var testTubes:Vector.<TestTube>;		//	Test Tubes that hold the individual bacteria
		
		private var popup:SpawnBacteriaScreen;		//	Popup that appears when a bacteria is spawned
		private var pauseMenu:PauseScreen;			//	Pause menu that appears over the game
		public var contractSelector:ContractScreen;	//	Contract selection screen when a new contract is needed
		
		//	Simple constructor
		//	use buildFromToken() to load existing game, once instantiated
		public function Game()
		{
			foodSelection = 1;
			
			ui = new UI(this);
			
			testTubes = new Vector.<TestTube>();
			pauseMenu = new PauseScreen(this);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			popup = new SpawnBacteriaScreen(this);
			
			contractSelector = new ContractScreen(this);
			
			for (var i:int = 0; i < NUM_TUBES; ++i){
				testTubes.push( new TestTube(this, ((stage.stageWidth - (NUM_TUBES * 75)) / 2)  + (i * 100), 200, 60) );
				addChild(testTubes[i]);
			}
			
			addChild(ui);
			addChild(popup);
			addChild(contractSelector);
			addChild(pauseMenu);
			pauseMenu.visible = false;
			contractSelector.visible = false;
			popup.visible = false;
			
			draw();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); 
			stage.addEventListener(ContractEvent.COMPLETED, onContractComplete);
			ui.collectButton.addEventListener(ButtonEvent.CLICKED, onCollected);
			ui.bacteriaButton.addEventListener(ButtonEvent.CLICKED, onButton);
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			contractSelector.addEventListener(ContractEvent.SELECTED, onContract);
		}
		
		//	Starts the game - allows for game to be built from load, before main ticks start
		public function start():void
		{
			stage.addEventListener(MutationEvent.TICK_MAIN, onTick);
			if (!contract) {
				Main.isPaused = true;
				contractSelector.visible = true;
			}else {
				Main.isPaused = false;
			}
			
			ui.update();
			ui.collectButton.addEventListener(ButtonEvent.CLICKED, onCollected);
			ui.bacteriaButton.addEventListener(ButtonEvent.CLICKED, onButton);
		}
		
		//	Main update loop
		private function onTick(e:MutationEvent):void
		{
			if ( (money < bacteriaCost) && (bacteriaCount < 1) ) {
				Main.isPaused = true;
				popup.display(new Bacteria(this, 0, 0));
				popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			}
		}
		
		//	Recursively kills itself and then everything it holds
		public function kill():void
		{
			if (stage){
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); 
				stage.removeEventListener(ContractEvent.COMPLETED, onContractComplete);
				stage.removeEventListener(MutationEvent.TICK_MAIN, onTick);
			}
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			ui.collectButton.removeEventListener(ButtonEvent.CLICKED, onCollected);
			ui.bacteriaButton.removeEventListener(ButtonEvent.CLICKED, onButton);
			contractSelector.removeEventListener(ContractEvent.SELECTED, onContract);
			
			ui.kill();
			for each (var testTube:TestTube in testTubes) {
				testTube.kill();
			}
			pauseMenu.kill();
			popup.kill();
			contractSelector.kill();
			if (contract){
				contract.kill();
			}
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
			if (money > bacteriaCost) {
				money -= bacteriaCost;
			}else {
				return;
			}
			popup.display(new Bacteria(this, 0,0));
			Main.isPaused = true;
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
		}
		
		public function get bacteriaCost():int
		{
			var cost:Number =  (BACTERIA_BASE_COST * ((bacteriaCount * bacteriaCount) / 5 + 1));
			if (cost > 15000) {
				cost  = 15000;
			}
			return cost;
		}
		
		//	Called when a bacteria has been given a name
		private function onBacteriaNamed(e:BacteriaEvent):void
		{
			popup.visible = false;
			Main.isPaused = false;
			
			var tube:int = 0;
			do{
				tube = Math.random() * 3.99;
			} while (testTubes[tube].bacteriaCount > 5);
			
			testTubes[tube].spawnBacteria(e.bacteria);
			popup.removeEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			ui.bacteriaButtonOut.text = "菌" + bacteriaCost;
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
			/* Debugging key for getting money fast. Removed for release.
			if (e.keyCode == Keyboard.SPACE) {
				money += 1000;
			}*/
			if ((e.keyCode == Keyboard.ESCAPE)  ||(e.keyCode == Keyboard.END)){
				if (Main.isPaused) {
					stage.dispatchEvent(new MutationEvent(MutationEvent.UNPAUSE));
				}else {
					stage.dispatchEvent(new MutationEvent(MutationEvent.PAUSE));
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
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			var colours:Array = [0x597DA5, 0x325EB8,  0x87AAEA, 0x6699CC];
			var alphas:Array  = [0.25, 0.25, 0.25, 0.25];
			var ratios:Array  = [120 , 140 , 141 , 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, 90 * (Math.PI / 180), 0 , 0);
			
			graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
		
		// Accessor for getting the total bacteria currently in game
		public function get bacteriaCount():int
		{
			var count:int = 0;
			for each (var t:TestTube in testTubes) {
				count += t.bacteriaCount;
			}
			return count;
		}
		
		//	Gets the save-token object for the entire game
		public function getToken():Object
		{
			var testtubesTokens:Array		=	new Array();
			for (var i:int = 0; i < NUM_TUBES; ++i) {
				testtubesTokens.push(testTubes[i].getToken());
			}
			var token:Object 			= new Object();
			token.hatsUnlocked 	= hats.numUnlocked;
			token.foodUnlocked 	= foods.numUnlocked;
			token.money			= money;
			token.contract		= contract.type.arrayListing;
			token.boxesShipped 	= contract.boxesShipped;
			token.collected		= contract.collected;
	
			token.testtubes		= testtubesTokens;
			
			return token;
		}
		
		//	Rebuilds the game from an existing save token.
		public function buildFromToken(token:Object):void
		{
			this.money = token.money;
			this.contract = new Contract(stage, contracts.getAt(token.contract) as ContractDescriptor);
			this.contract.boxesShipped = token.boxesShipped;
			this.contract.collected = token.collected;
			
			for (var hatCount:int = hats.numUnlocked; hatCount < token.hatsUnlocked; ++hatCount ) {
				hats.unlockNext();
			}
			for (var foodCount:int = foods.numUnlocked; foodCount < token.foodUnlocked; ++foodCount ) {
				foods.unlockNext();
			}
			for (var i:int = 0; i < NUM_TUBES; ++i) {
				testTubes[i].buildFromToken(token.testtubes[i]);
			}
			
		}
		
	}

}