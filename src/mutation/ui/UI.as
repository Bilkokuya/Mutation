package mutation.ui 
{

	import flash.display.Bitmap;
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
	import mutation.events.ContractEvent;
	import mutation.events.MutationEvent;
	import mutation.events.MoneyEvent;
	import mutation.Game;
	import mutation.util.Resources;
	
	import mutation.ui.Button;
	
	public class UI extends Sprite
	{
		private var game:Game;
		public var moneyOut:TextField;
		
		public var collectedOut:TextField;
		public var collectButton:GraphicButton;
		
		public var bacteriaButton:GraphicButton;
		public var bacteriaButtonOut:TextField;
		
		public var foodSelector:FoodSelector;
		public var unlockablesDisplay:UnlockablesDisplay;
		
		public function UI(game:Game) 
		{
			this.game = game;
			moneyOut = new TextField();
			collectedOut = new TextField();
			collectButton = new GraphicButton(225, 5, new Resources.GFX_UI_BUTTON_CONTRACT);
			
			bacteriaButton = new GraphicButton(10, 5, new Resources.GFX_UI_BUTTON_BACTERIA);
			bacteriaButtonOut = new TextField();
			
			foodSelector = new FoodSelector(game);
			unlockablesDisplay = new UnlockablesDisplay(game);
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);

			addChild(moneyOut);
			addChild(bacteriaButton);
			addChild(bacteriaButtonOut);
			bacteriaButton.disable();
			
			addChild(collectButton);
			addChild(collectedOut);
			addChild(foodSelector);
			addChild(unlockablesDisplay);
			
			unlockablesDisplay.x = 350;
			unlockablesDisplay.y = 5;
			
			foodSelector.x = 100;
			foodSelector.y = 5;
			game.foodSelection = 1;
			
			initText();
			
			moneyOut.text = "菌" + game.money;
			collectedOut.text = 0 + "/" + 0;
			bacteriaButtonOut.text = "菌" + game.bacteriaCost;
			
			stage.addEventListener(MoneyEvent.CHANGED, onMoney);
			stage.addEventListener(ContractEvent.CHANGED, onContract);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		private function onTick(e:MutationEvent):void
		{
			if (game.bacteriaCount >= game.MAX_BACTERIA) bacteriaButton.disable();
			else if (game.money >= game.bacteriaCost) bacteriaButton.enable();
		}
		
		public function kill():void
		{
			if (stage){
				stage.removeEventListener(MoneyEvent.CHANGED, onMoney);
				stage.removeEventListener(ContractEvent.CHANGED, onContract);
				stage.addEventListener(MutationEvent.TICK, onTick);
			}
			
			collectButton.kill();
			foodSelector.kill();
			unlockablesDisplay.kill();
			bacteriaButton.kill();
		}
		
		private function onMoney(e:MoneyEvent):void
		{
			moneyOut.text = "菌" + e.money;
			if (e.money > game.bacteriaCost) {
				bacteriaButton.enable();
			}else {
				bacteriaButton.disable();
			}
		}
		
		public function update():void
		{
			foodSelector.update();
			unlockablesDisplay.update();
		}
		
		private function onContract(e:ContractEvent):void
		{
			var complete:int =  (100 * e.contract.collected / e.contract.type.collectionNeeded);
			collectedOut.text = complete +"%";
			
			if (e.contract.isFilled()) {
				collectButton.enable();
			}else {
				collectButton.disable();
			}
		}
		
		private function initText():void
		{
			var format:TextFormat = new TextFormat();
			format.size = 48;
			format.font = "Century Gothic";
			format.bold = true;
			format.color = 0x7C2C00;
			format.align = TextFormatAlign.LEFT;
			
			moneyOut.x = 3 * stage.stageWidth / 4;
			moneyOut.y = 4 * stage.stageHeight / 5;
			moneyOut.autoSize = TextFieldAutoSize.RIGHT;
			moneyOut.defaultTextFormat = format;
			moneyOut.selectable = false;
			
			collectedOut.defaultTextFormat = new TextFormat("Century Gothic", 24, 0x7C2C00, true);
			collectedOut.x = 235;
			collectedOut.y = 50;
			collectedOut.autoSize = TextFieldAutoSize.LEFT;
			collectedOut.selectable = false;	
			
			format.size = 24;
			format.font = "Century Gothic";
			format.bold = true;
			format.color = 0x7C2C00;
			format.align = TextFormatAlign.CENTER;
			
			bacteriaButtonOut.defaultTextFormat = new TextFormat("Century Gothic", 24, 0x7C2C00, true);
			bacteriaButtonOut.x = 0;
			bacteriaButtonOut.y = 55;
			bacteriaButtonOut.autoSize = TextFieldAutoSize.CENTER;
			bacteriaButtonOut.selectable = false;
			
		}
	}

}