package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Microphone;
	import flash.text.TextField;
	import mutation.events.ButtonEvent;
	import mutation.Game;

	public class GraphicButton extends Sprite
	{
		public var enabled:Boolean;
		public var bitmap:Bitmap;
		public var text:TextField;
		public var overlay:Sprite;
		
		public function GraphicButton( x:Number, y:Number, image:Bitmap) 
		{
			bitmap = image;
			this.x = x;
			this.y = y;
			enabled = true;
			
			text = new TextField();
			text.selectable = false;
			
			overlay = new Sprite();
			
			bitmap.width = 100;
			bitmap.height = 100;
			
			addChild(bitmap);
			addChild(overlay);
			addChild(text);
			
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onRelease);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		public function kill():void
		{
			enabled = true;
			disable();
		}
		
		public function enable():void
		{
			if (!enabled) {
				enabled = true;
				draw(0xFFFFFF, 0);
				addEventListener(MouseEvent.CLICK, onClick);
				addEventListener(MouseEvent.MOUSE_DOWN, onDown);
				addEventListener(MouseEvent.MOUSE_UP, onRelease);
				addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			}
		}
		
		public function disable():void
		{
			if (enabled) {
				enabled = false;
				draw(0x555555, 0.5);
				removeEventListener(MouseEvent.CLICK, onClick);
				removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
				removeEventListener(MouseEvent.MOUSE_UP, onRelease);
				removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
				removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			}
		}
		
		//	When clicked, this will dispatch an event to change the type of item held
		private function onClick(e:Event):void
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.CLICKED, ""));
		}
		
		private function onDown(e:MouseEvent):void
		{
			draw(0x000000, 0.15);
		}
		private function onRelease(e:MouseEvent):void
		{
			draw(0xFFFFFF, 0.15);
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			draw(0xFFFFFF,0.15);
		}
		private function onRollOut(e:MouseEvent):void
		{
			draw(0x000000, 0);
		}
		
		private function draw(colour:int, alpha:Number):void
		{
			overlay.graphics.clear();
			overlay.graphics.beginFill(colour, alpha);
			overlay.graphics.drawRect( 0, 0, 82, 82);
			overlay.graphics.endFill();
		}
		
	}

}