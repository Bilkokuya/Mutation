package mutation.ui.screens 
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.SharedObject;
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
		private var menuBacking:Bitmap;
		private var playButton:Button;
		private var continueButton:Button;
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
			menuBacking = new Resources.GFX_UI_MENU;
			playButton = new Button(15, 15, "PLAY", 140, 50, 0x97b9f3, 0xc0d4f8);
			
			var save:SharedObject = SharedObject.getLocal("MutationGDM" );
			if (save.data.isSaved){
				continueButton = new Button(15, 80, "CONTINUE", 140, 50, 0xb4b4b4, 0xd4d4d4);
			}else {
				continueButton = new Button(15, 80, "CONT..", 140, 50, 0x141414, 0x141414);
			}
			if (save.data.isSaved){
				continueButton.addEventListener(ButtonEvent.CLICKED, onContinue);
			}
			
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
			
			menu.addChild(menuBacking);
			menu.addChild(playButton);
			menu.addChild(continueButton);
			draw();
			
			playButton.addEventListener(ButtonEvent.CLICKED, onPlay);
			stage.addEventListener(MutationEvent.MENU, onMenu);
			stage.addEventListener(MutationEvent.GAME, onGame);
			stage.addEventListener(MutationEvent.NEWGAME, onGame);
		}
		
		public function kill():void
		{
			playButton.removeEventListener(ButtonEvent.CLICKED, onPlay);
			playButton.kill();
		}
		
		private function draw():void
		{
			var colours:Array = [0x597DA5, 0x325EB8,  0x87AAEA, 0x6699CC];
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
			graphics.drawRect(0, 193, 250, 30);
			graphics.endFill();
		}
		
		private function onPlay(e:ButtonEvent):void
		{
			if (stage){
				stage.dispatchEvent(new MutationEvent(MutationEvent.NEWGAME) );
			}
		}
		
		private function onContinue(e:ButtonEvent):void
		{
			if (stage){
				stage.dispatchEvent(new MutationEvent(MutationEvent.GAME) );
			}
		}
		
		private function onMenu(e:MutationEvent):void
		{
			visible = true;
			continueButton.kill();
			menu.removeChild(continueButton);
			var save:SharedObject = SharedObject.getLocal("MutationGDM" );
			if (save.data.isSaved){
				continueButton = new Button(15, 80, "CONTINUE", 140, 50, 0xb4b4b4, 0xd4d4d4);
			}else {
				continueButton = new Button(15, 80, "CONT..", 140, 50, 0x141414, 0x141414);
			}
			
			menu.addChild(continueButton);
			
			if (save.data.isSaved){
				continueButton.addEventListener(ButtonEvent.CLICKED, onContinue);
			}
		}
		
		private function onGame(e:MutationEvent):void
		{
			visible = false;
		}
	}

}