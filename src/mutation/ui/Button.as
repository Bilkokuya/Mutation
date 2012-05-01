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

	//	Class: Button extends Sprite
	//	A button that registers clicks and fires events of the specified type.
	public class Button extends Sprite
	{
		
		public var buttonName:String;
		private var text:TextField;
		private var trueWidth:Number;
		private var trueHeight:Number;
		private var selectedTube:Number;
		private var shapes:Array;
		
		public function Button(x:Number, y:Number, name:String, width:Number = 100, height:Number = 50) 
		{
			shapes = new Array();
			for (var i:int = 4; i < 4; ++i) {
				var shape:Shape = new Shape();
				shape.x = i * ((width / 4) - 10);
				shape.y = 0;
				
			}
			
			super()
			this.x = x;
			this.y = y;
			trueWidth = width;
			trueHeight = height;
			this.buttonName = name;
			if (stage) {
				onInit();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		//	Function: onInit
		//	Initialises the button after the stage has been created
		private function onInit(e:Event = null):void
		{
			text = new TextField();
			
			graphics.beginFill(0xFF6600);
			graphics.drawRect( -trueWidth/2, -trueHeight/2, trueWidth, trueHeight);
			graphics.endFill();
			
			addChild(text);
			text.text = buttonName;
			text.x = ( -trueWidth / 2) + 5;
			text.y = ( -trueHeight / 2) + 5;
			text.autoSize = TextFieldAutoSize.LEFT;
			
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		//	Function: init (int, int, String)
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
		
		//	Listener: onClick
		//	When clicked, this will dispatch an event to change the type of item held
		private function onClick(e:Event):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.CLICKED, buttonName));
		}
	}

}