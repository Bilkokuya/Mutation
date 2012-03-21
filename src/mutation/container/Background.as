//	Copyright 2012	Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Background
//		The background of the world, that can scale separately if needed

package mutation.container 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	//	Class: Background
	public class Background extends Sprite
	{
		
		//	Constructor: default
		public function Background() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		
		//	Funcfion: onInit (Event = null)
		//	Initialises the object once the stage is added
		private function onInit(e:Event = null):void
		{
			var colours:Array = [0x00BBBB, 0x008888, 0x55BBBB, 0xAAFFFF];
			var alphas:Array  = [1,1,1,1];
			var ratios:Array  = [20, 100,101, 200];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth*2, stage.stageHeight*2, 270*(Math.PI/180), -stage.stageWidth, -stage.stageHeight);
			
			graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			graphics.drawRect(-stage.stageWidth, -stage.stageHeight, 2*stage.stageWidth, 2*stage.stageHeight);
			graphics.endFill();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
	}

}