package mutation.ui.contracts 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import mutation.events.ButtonEvent;
	import mutation.events.ContractEvent;
	import mutation.Game;
	import mutation.ui.Button;
	import mutation.util.Resources;

	public class ContractOption extends Sprite
	{
		private var game:Game;
		private var option:Bitmap;
		
		private var backing:Shape;
		private var titleOut:TextField;
		private var descOut:TextField;
		private var statsOut:TextField;
		private var selectButton:Button;
		
		private var type:ContractDescriptor;
		
		public function ContractOption(game:Game, descriptor:ContractDescriptor) 
		{
			this.game = game;
			
			this.type = descriptor;
			
			backing = new Shape();
			statsOut = new TextField();
			titleOut = new TextField();
			descOut = new TextField();
			option  = new Resources.GFX_UI_MENU;
			selectButton = new Button(15, 250, "    SELECT", 140, 50);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			
			backing.graphics.beginFill(0x838383);
			backing.graphics.drawRect(1, 1, 140, 80);
			backing.graphics.endFill();
			backing.graphics.beginFill(0x97b9f3);
			backing.graphics.drawRect(0, 0, 140, 80);
			backing.graphics.endFill();
		
			backing.x = 15;
			backing.y = 160;
			
			initText();
			
			addChild(option);
			addChild(backing);
			addChild(titleOut);
			addChild(descOut);
			addChild(statsOut);
			addChild(selectButton);
			
			selectButton.addEventListener(ButtonEvent.CLICKED, onClick);
		}

		public function kill():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:ButtonEvent):void
		{
			dispatchEvent(new ContractEvent(ContractEvent.SELECTED, new Contract(stage, type))) ;
		}
		
		private function initText():void
		{
			var format:TextFormat = new TextFormat;
			format.font		= "Century Gothic";
			format.size		= 24;
			format.color	=	0x6699CC;
			format.bold 	=	true;
			
			titleOut.defaultTextFormat = format;
			titleOut.text = type.title;
			titleOut.autoSize = TextFieldAutoSize.LEFT;
			titleOut.x = 25;
			titleOut.y = 10;
			titleOut.wordWrap = true;
			titleOut.width = 140;
			
			format.size		= 12;
			format.font		= "Calibri";
			format.bold	= false;
			
			descOut.defaultTextFormat = format;
			descOut.text = type.description;
			descOut.autoSize = TextFieldAutoSize.LEFT;
			descOut.x = 15;
			descOut.y  = 38;
			descOut.wordWrap = true;
			descOut.width = 140;
			
			format.size	= 14;
			format.font	= "Century Gothic";
			format.bold = true;
			format.color = 0xFFFFFF;
			
			statsOut.defaultTextFormat = format;
			statsOut.autoSize = TextFieldAutoSize.LEFT;
			statsOut.x = 25;
			statsOut.y  = 160;
			statsOut.wordWrap = true;
			statsOut.width = 140;
			statsOut.text = "Boxes: " + type.boxesNeeded + "\n" +
										  "Size: " + type.collectionNeeded + "\n" + 
										  "Pay: 菌" + type.payPerBox + "\n" + 
										  "Bonus: 菌" + type.bonus;
			
		}
		
	}

}