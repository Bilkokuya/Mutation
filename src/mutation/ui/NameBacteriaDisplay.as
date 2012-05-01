package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.events.FocusEvent;
	import flash.ui.Keyboard;
	import mutation.entity.Bacteria;
	import mutation.events.BacteriaEvent;
	
	public class NameBacteriaDisplay extends PopupDisplay
	{
		public var infoOut:TextField;
		public var nameInput:TextField;
		public var submitOut:TextField;
		public var submitButton:Sprite;
		private var bacteria:Bacteria = new Bacteria(0,0,5);
		
		public function NameBacteriaDisplay(x:Number = 0, y:Number = 0) 
		{
			infoOut = new TextField();
			nameInput = new TextField();
			submitOut = new TextField();
			submitButton = new Sprite();
			
			infoOut.text = "Congratulations! \n" +
							"A new Bacteria has been born! \n" +
							"Let's give it a name.";
			infoOut.y = -50;
			infoOut.width = boxWidth_;
			infoOut.multiline = true;
			infoOut.autoSize = TextFieldAutoSize.LEFT;

			nameInput.type = TextFieldType.INPUT;
			nameInput.text = "Name...";
			nameInput.border = true;
			nameInput.y = 10;
			nameInput.x = 25;
			nameInput.multiline = false;
			nameInput.background = true;
			nameInput.backgroundColor = 0xDDDDDD;
			nameInput.width = 100;
			nameInput.height = 20;
			nameInput.restrict = "a-zA-Z .";
			
			
			super(x, y, 150, 100, 0, 0);
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function onInit(e:Event = null):void
		{
			addChild(infoOut);
			addChild(nameInput);
			addChild(submitOut);
			addChild(submitButton);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			nameInput.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			nameInput.addEventListener(KeyboardEvent.KEY_UP, onEnter);
		}
		
		private function onFocus(e:FocusEvent):void
		{
			nameInput.text = "";
		}
		
		private function onEnter(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ENTER) {
				bacteria.nameString = nameInput.text;
				dispatchEvent(new BacteriaEvent(BacteriaEvent.COMPLETE, bacteria, true));
			}
		}
		
		public function display(bacteria:Bacteria):void
		{
			show();
			nameInput.text = "Name...";
			this.bacteria = bacteria;
			
		}
	}

}