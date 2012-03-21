//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mcndrick
//
//	Button (extends Sprite)
//		A button to click on screen, that throws global bubbling events
//		Allows for functionality that changes a lot of how the game plays

package mutation.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import GDM.Mutation.events.ButtonEvent;

	//	Class: Button extends Sprite
	//	A button that registers clicks and fires events of the specified type.
	public class Button extends Sprite
	{
		
		public var buttonName:String;
		private var text:TextField;
		
		public function Button(name:String) 
		{
			super()
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
			graphics.drawRect( -50, -20, 100, 40);
			graphics.endFill();
			
			addChild(text);
			text.text = buttonName;
			text.x = -45;
			
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		//	Function: init (int, int, String)
		//	Initialises the position after creation
		//		Prevents issues with long constructors that might fail
		public function init(x:int, y:int, name:String = null) {
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
			trace("dispatch");
		}
	}

}