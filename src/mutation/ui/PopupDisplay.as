package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.Game;

	public class PopupDisplay extends Sprite
	{
		protected var boxWidth_:Number;
		protected var boxHeight_:Number;
		protected var arrowWidth_:Number;
		protected var arrowHeight_:Number;
		private var game:Game;
		
		public function PopupDisplay(game:Game, x:Number, y:Number, width:Number, height:Number, length:Number = 10, thickness:Number = 20) 
		{
			this.game = game;
			
			this.x = x;
			this.y = y;
			
			boxWidth_ = width;
			boxHeight_ = height;
			arrowWidth_ = length;
			arrowHeight_ = thickness;
			
			visible = false;
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			draw();
		}
		
		public function show():void
		{
			visible = true;
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
		}
		public function hide():void
		{
			visible = false;
		}
		
		private function draw():void
		{
			//	orange surround
			graphics.beginFill(0x97b9f3, 0.7);
			graphics.drawRect( arrowWidth_ - 2, (-boxHeight_/2) - 2, boxWidth_ + 4, boxHeight_ + 4);
			graphics.endFill();
			
			//orange triangle to bacteria
			graphics.lineStyle();
			graphics.beginFill(0x97b9f3, 0.7);
			graphics.moveTo(0, 0);
			graphics.lineTo((arrowWidth_) - 2, -arrowHeight_/2);
			graphics.lineTo((arrowWidth_) - 2, arrowHeight_/2);
			graphics.lineTo(0, 0);
			graphics.endFill();
			
			
			//	white background to make text obvious
			graphics.beginFill(0xFFFFFF, 0.7);
			graphics.drawRect(arrowWidth_, -boxHeight_/2, boxWidth_, boxHeight_);
			graphics.endFill();
		}
		
	}

}