package mutation.ui.screens 
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.events.BacteriaEvent;
	import mutation.events.ButtonEvent;
	import mutation.events.MutationEvent;
	import mutation.ui.Button;
	import mutation.util.Resources;

	public class IntroScreen extends Sprite
	{
		private var menu:Sprite;
		private var playButton:Button;
		private var logoOut:TextField;
		
		public function IntroScreen() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			menu = new Sprite();
			playButton = new Button(70, 50, "PLAY!");
			logoOut = new TextField();
			
			
			logoOut.defaultTextFormat = Resources.FORMAT_H1;
			logoOut.text = "MUTATI菌N";
			
			addChild(menu);
			addChild(logoOut);
			logoOut.x = 225;
			logoOut.y = 250;
			logoOut.autoSize = TextFieldAutoSize.CENTER;
			menu.x = (stage.stageWidth - 150)/2;
			menu.y = 50;
			
			menu.addChild(playButton);
			draw();
			
			playButton.addEventListener(ButtonEvent.CLICKED, onPlay);
		}
		
		public function kill():void
		{
			playButton.removeEventListener(ButtonEvent.CLICKED, onPlay);
			playButton.kill();
		}
		
		private function draw():void
		{
			var colours:Array = [0x597DA5, 0x87AAEA, 0x325EB8, 0x6699CC];
			var alphas:Array  = [0.25, 0.25, 0.25, 0.25];
			var ratios:Array  = [180 , 200 , 201 , 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, 90*(Math.PI/180), 0 , 0);
			
			graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			// go faster stripes
			graphics.beginFill(0x6699CC);
			graphics.drawRect(0, 180, 250, 5);
			graphics.drawRect(0, 190, 250, 30);
			graphics.endFill();
			
			
			menu.graphics.clear();
			menu.graphics.beginFill(0xD9FBFD);
			menu.graphics.drawRect(0, 0, 150, 250);
			menu.graphics.endFill();
		}
		
		private function onPlay(e:ButtonEvent):void
		{
			if (stage){
				stage.dispatchEvent(new MutationEvent(MutationEvent.GAME) );
			}
		}
	}

}