package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import mutation.entity.Bacteria;
	
	public class BacteriaDisplay extends Sprite
	{
		private var nameField:TextField;
		private var foodField:TextField;
		private var productionField:TextField;
		
		private var boxWidth_:int;
		private var boxHeight_:int;
		private var arrowWidth_:int;
		private var arrowHeight_:int;
		
		public function BacteriaDisplay(x:int, y:int, width:int, height:int, length:int = 10, thickness:int = 20)
		{
			this.x = x;
			this.y = y;
			boxWidth_ = width;
			boxHeight_ = height;
			arrowWidth_ = length;
			arrowHeight_ = thickness;
			
			visible = false;
			
			nameField = new TextField();
			foodField = new TextField();
			productionField = new TextField();
			
			var format:TextFormat = new TextFormat();
			format.size = 12;
			format.font = "Calibri";
			
			nameField.defaultTextFormat = format;
			foodField.defaultTextFormat = format;
			productionField.defaultTextFormat = format;
			
			nameField.x = arrowWidth_;
			nameField.y = (-boxHeight_/2) + 2;
			
			foodField.x = arrowWidth_;
			foodField.y = (-boxHeight_/2) + 17;
			
			productionField.x = arrowWidth_;
			productionField.y = (-boxHeight_/2) + 32;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit)
		}
		
		private function onInit(e:Event = null):void
		{
			addChild(nameField);
			addChild(foodField);
			addChild(productionField);
			
			draw();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function show():void
		{
			this.visible = true;
		}
		public function hide():void
		{
			this.visible = false;
		}
		
		public function update(names:Number, food:Number, production:Number):void
		{
			nameField.text = "DNA: " + names.toFixed(0);
			foodField.text = "APS: " + food.toFixed(0);
			productionField.text = "PAPS: " + production.toFixed(0);
		}
		
		private function draw():void
		{
			//	orange surround
			graphics.beginFill(0xFF6600, 0.7);
			graphics.drawRoundRect( arrowWidth_ - 2, (-boxHeight_/2) - 2, boxWidth_ + 4, boxHeight_ + 4, 11);
			graphics.endFill();
			
			//orange triangle to bacteria
			graphics.lineStyle();
			graphics.beginFill(0xFF6600, 0.7);
			graphics.moveTo(0, 0);
			graphics.lineTo((arrowWidth_) - 2, -arrowHeight_/2);
			graphics.lineTo((arrowWidth_) - 2, arrowHeight_/2);
			graphics.lineTo(0, 0);
			graphics.endFill();
			
			
			//	white background to make text obvious
			graphics.beginFill(0xFFFFFF, 0.7);
			graphics.drawRoundRect(arrowWidth_, -boxHeight_/2, boxWidth_, boxHeight_, 10);
			graphics.endFill();
			
			
		}
		
	}

}