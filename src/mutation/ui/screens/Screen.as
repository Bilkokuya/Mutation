package mutation.ui.screens 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	public class Screen extends Sprite
	{
		
		public function Screen() 
		{
			super();
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			draw();
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0.5);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			var colours:Array = [0x597DA5, 0x325EB8,  0x87AAEA, 0x6699CC];
			var alphas:Array  = [0.25, 0.25, 0.25, 0.25];
			var ratios:Array  = [180 , 200 , 201 , 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, 90 * (Math.PI / 180), 0 , 0);
			
			graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
		
	}

}