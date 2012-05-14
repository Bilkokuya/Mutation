package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mutation.events.ButtonEvent;
	import mutation.util.Resources;

	public class UnlockableDisplayElement extends Sprite
	{
		public var bitmap:Bitmap;
		public var backing:Bitmap;
		public var overlay:Shape;
		public var index:int;
		public var costOut:TextField;
		public var isEnabled:Boolean = false;
		
		public function UnlockableDisplayElement(bitmap:Bitmap, index:int, cost:int = 0 ) 
		{
			this.bitmap = bitmap;
			backing = new Resources.GFX_UI_BUTTON_BASE;
			overlay = new Shape();
			
			costOut = new TextField();
			costOut.defaultTextFormat = new TextFormat("Century Gothic", 24, 0x7C2C00, true);
			costOut.text = "";
			costOut.selectable = false;
			costOut.x = 5;
			costOut.y = 50;
			
			if (cost) {
				costOut.text = "菌" + cost;
			}
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		
			addChild(backing);
			addChild(bitmap);
			addChild(overlay);
			addChild(costOut);
			

			bitmap.x = 15;
			bitmap.y = 15;
			bitmap.width = 50;
			bitmap.height = 50;
			
			enable();
		}
		
		public function setBitmap(bitmap:Bitmap, cost:int = 0):void
		{
			removeChild(this.bitmap);
			this.bitmap = bitmap;
			addChild(this.bitmap);
			
			bitmap.x = 15;
			bitmap.y = 15;
			bitmap.width = 50;
			bitmap.height = 50;
			
			if (cost) {
				costOut.text = "菌" + cost;
			}else {
				costOut.text = "";
			}
		}
		
		public function enable():void
		{
			if (!isEnabled) {
				isEnabled = true;
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
			if (isEnabled) {
				isEnabled = false;
				draw(0x555555, 0.5);
				removeEventListener(MouseEvent.CLICK, onClick);
				removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
				removeEventListener(MouseEvent.MOUSE_UP, onRelease);
				removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
				removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			}
		}
		
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
		
		public function kill():void
		{
			disable();
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