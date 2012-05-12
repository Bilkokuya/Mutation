package mutation.ui.screens 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.events.FocusEvent;
	import flash.ui.Keyboard;
	import mutation.entity.Bacteria;
	import mutation.entity.hats.Hat;
	import mutation.events.BacteriaEvent;
	import mutation.Game;
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
		private var menu:Sprite;
		
		public function SpawnBacteriaScreen(game:Game) 
		{
			this.game		= game;
			
			menu 			= new Sprite();
			infoOut			= new TextField();
			nameInput		= new TextField();
			hatSelector		= new HatSelector(game);
			bacteria		= new Bacteria(game, 0, 0, 5);
			hatSelector.x	= 15;
			hatSelector.y	= 30;
			
			
			infoOut.text = "Spawn New Bacteria";
			infoOut.y = 50;
			infoOut.x = 20;
			infoOut.width = 150;
			infoOut.multiline = true;
			infoOut.autoSize = TextFieldAutoSize.LEFT;
			infoOut.selectable = false;

			nameInput.type = TextFieldType.INPUT;
			nameInput.text = "Name...";
			nameInput.border = true;
			nameInput.y = 80;
			nameInput.x = 25;
			nameInput.multiline = false;
			nameInput.background = true;
			nameInput.backgroundColor = 0xDDDDDD;
			nameInput.width = 100;
			nameInput.height = 20;
			nameInput.restrict = "a-zA-Z .";
			
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(menu);
			menu.addChild(new Resources.GFX_UI_MENU as Bitmap);
			menu.addChild(infoOut);
			menu.addChild(nameInput);
			menu.addChild(hatSelector);
			
			
			menu.x = 225;
			menu.y = 50;
			
			draw();
			
			nameInput.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			nameInput.addEventListener(KeyboardEvent.KEY_UP, onEnter);
		}
		
		public function kill():void
		{
			nameInput.removeEventListener(FocusEvent.FOCUS_IN, onFocus);
			nameInput.removeEventListener(KeyboardEvent.KEY_UP, onEnter);
			
			hatSelector.kill();
		}
		
		private function onFocus(e:FocusEvent):void
		{
			nameInput.text = "";
		}
		
		private function onEnter(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ENTER) {
				bacteria.nameString = nameInput.text;
				bacteria.setHat(new Hat(game, hatSelector.getHatDescriptor()));
				dispatchEvent(new BacteriaEvent(BacteriaEvent.COMPLETE, bacteria, true));
			}
		}
		
		public function display(bacteria:Bacteria):void
		{
			visible = true;
			nameInput.text = "Name...";
			this.bacteria = bacteria;
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
		}
		
		private function draw():void
		{
		}
		
	}

}