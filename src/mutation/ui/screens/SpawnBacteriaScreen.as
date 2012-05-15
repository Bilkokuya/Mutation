package mutation.ui.screens 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.events.FocusEvent;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import mutation.entity.Bacteria;
	import mutation.entity.hats.Hat;
	import mutation.events.BacteriaEvent;
	import mutation.events.ButtonEvent;
	import mutation.Game;
	import mutation.ui.Button;
	import mutation.ui.HatSelector;
	import mutation.ui.PopupDisplay;
	import mutation.util.Resources;
	
	public class SpawnBacteriaScreen extends Screen
	{
		private var game:Game;
		
		public var infoOut:TextField;
		public var nameInput:TextField;
		private var bacteria:Bacteria;
		private var hatSelector:HatSelector;
		private var tubeChoices:Vector.<Sprite>;
		private var confirmButton:Button;
		private var menu:Sprite;
		private var selectionBacking:Shape;
		
		public function SpawnBacteriaScreen(game:Game) 
		{
			this.game		= game;
			
			tubeChoices = new Vector.<Sprite>();
			
			confirmButton = new Button(15, 250, "  CONFIRM", 140, 50);
			selectionBacking = new Shape();
			menu 				= new Sprite();
			infoOut				= new TextField();
			nameInput		= new TextField();
			hatSelector	= new HatSelector(game);
			bacteria			= new Bacteria(game, 0, 0);
			hatSelector.x	= 15;
			hatSelector.y	= 50;
					
			infoOut.defaultTextFormat =  new TextFormat("Century Gothic", 36, 0x6699CC, true);
			infoOut.text = "Spawn a Bacteria";
			infoOut.y = 0;
			infoOut.x = 105;
			infoOut.autoSize = TextFieldAutoSize.LEFT;
			infoOut.selectable = false;
			
			nameInput.defaultTextFormat =  new TextFormat("Calibri", 14, 0x3366AA, true);;
			nameInput.type = TextFieldType.INPUT;
			nameInput.text = "Name...";
			nameInput.y = 15;
			nameInput.x = 15;
			nameInput.multiline = false;
			nameInput.background = true;
			nameInput.backgroundColor = 0xd9e5f2;
			nameInput.width = 140;
			nameInput.height = 25;
			nameInput.restrict = "a-zA-Z .";
			selectionBacking.x = nameInput.x;
			selectionBacking.y = nameInput.y;
			selectionBacking.graphics.beginFill(0x838383);
			selectionBacking.graphics.drawRect(1, 1, 140, 25);
			selectionBacking.graphics.endFill();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(menu);
			menu.addChild(new Resources.GFX_UI_MENU as Bitmap);
			menu.addChild(selectionBacking);
			menu.addChild(nameInput);
			menu.addChild(hatSelector);
			menu.addChild(confirmButton);
			addChild(infoOut);
			
			
			menu.x = (stage.stageWidth - 150)/2;
			menu.y = 50;

			nameInput.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			nameInput.addEventListener(KeyboardEvent.KEY_UP, onEnter);
			confirmButton.addEventListener(ButtonEvent.CLICKED, onClicked);
		}
		
		public function kill():void
		{
			nameInput.removeEventListener(FocusEvent.FOCUS_IN, onFocus);
			nameInput.removeEventListener(KeyboardEvent.KEY_UP, onEnter);
			
			hatSelector.kill();
		}
		
		private function onFocus(e:FocusEvent):void
		{
			if (nameInput.text == "Enter a Name..."){
				nameInput.text = "";
			}
		}
		
		private function onEnter(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ENTER) {
				submit();
			}
		}
		
		private function onClicked(e:ButtonEvent):void
		{
			submit();
		}
		
		private function submit():void
		{
			if (nameInput.text == "Enter a Name...") {
				nameInput.text = "Nameless Nick";
			}
			bacteria.nameString = nameInput.text;
			bacteria.setHat(new Hat(game, hatSelector.getHatDescriptor()));
			dispatchEvent(new BacteriaEvent(BacteriaEvent.COMPLETE, bacteria, true));
		}
		
		public function display(bacteria:Bacteria):void
		{
			visible = true;
			nameInput.text = "Enter a Name...";
			this.bacteria = bacteria;
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
		}
		
	}

}