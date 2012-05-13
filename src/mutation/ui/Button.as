//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mcndrick
//
//	Button (extends Sprite)
//		A button to click on screen, that throws global bubbling events
//		Allows for functionality that changes a lot of how the game plays

package mutation.ui
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.events.ButtonEvent;
	import mutation.util.Resources;

	//	Class: Button extends Sprite
	//	A button that registers clicks and fires events of the specified type.
	public class Button extends Sprite
	{
		
		public var buttonName:String;
		private var textOut:TextField;
		private var trueWidth:Number;
		private var trueHeight:Number;
		private var colourNormal:int;
		private var colourHover:int;

		public function Button(x:Number, y:Number, name:String, width:Number = 100, height:Number = 50, colour:int = 0xAAAAAA, colour2:int = 0xDDDDDD) 
		{
			super();
			this.x = x;
			this.y = y;
			trueWidth = width;
			trueHeight = height;
			this.buttonName = name;
			this.colourNormal = colour;
			this.colourHover = colour2;
			
			if (stage) {
				onInit();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		//	Initialises the button after the stage has been created
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			textOut = new TextField();

			addChild(textOut);
			textOut.defaultTextFormat = Resources.FORMAT_H2;
			textOut.text = buttonName;
			textOut.x = 0;
			textOut.y = 0;
			textOut.autoSize = TextFieldAutoSize.CENTER;
			textOut.selectable = false;
			
			draw(colourNormal);
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onRelease);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		public function kill():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onRelease);
			removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		//	Initialises the position after creation
		//		Prevents issues with long constructors that might fail
		public function init(x:int, y:int, name:String = null):void
		{
			if (name != null) {
				buttonName = name;
			}
			
			this.x = x;
			this.y = y;
		}
		
		//	When clicked, this will dispatch an event to change the type of item held
		private function onClick(e:Event):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.CLICKED, buttonName));
		}
		
		private function onDown(e:MouseEvent):void
		{
			draw(colourHover,2,2);
		}
		private function onRelease(e:MouseEvent):void
		{
			draw(colourHover, 0,0);
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			draw(colourHover);
		}
		private function onRollOut(e:MouseEvent):void
		{
			draw(colourNormal);
		}
		
		private function draw(colour:int, dx:int = 0, dy:int = 0 ):void
		{
			graphics.clear();
			
			//	Draw the thin "shadow" (it's not a shadow, but semi-border)
			graphics.beginFill(0x838383);
			graphics.drawRect(1, 1, trueWidth, trueHeight);
			graphics.endFill();
			
			//	Draw the main box
			graphics.beginFill(colour);
			graphics.drawRect( dx, dy, trueWidth, trueHeight);
			graphics.endFill();
			
			textOut.x = dx;
			textOut.y = dy;
		}
	}

}