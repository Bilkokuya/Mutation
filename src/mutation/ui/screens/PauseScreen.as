package mutation.ui.screens 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import mutation.events.MutationEvent;
	import mutation.Game;
	import mutation.ui.Button;
	import mutation.util.Resources;

	public class PauseScreen extends Screen
	{	
		private var game:Game;
		private var menu:Sprite;
		private var menuBack:Bitmap;
		private var continueButton:Button;
		private var quitButton:Button;
		
		public function PauseScreen(game:Game) 
		{
			this.game = game;
			
			menu 					= new Sprite();
			menuBack 			= new Resources.GFX_UI_MENU();
			continueButton = new Button(15, 15, "CONTINUE"	, 140, 50, 0x97b9f3, 0xc0d4f8);
			quitButton 			= new Button(15, 80, "QUIT"			, 140, 50, 0xb4b4b4, 0xd4d4d4);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(menu);
			menu.addChild(menuBack);
			menu.addChild(continueButton);
			menu.addChild(quitButton);
			
			menu.x = (stage.stageWidth - 150)/2;
			menu.y = 50;
			
			continueButton.addEventListener(MouseEvent.CLICK, onContinue);
			quitButton.addEventListener(MouseEvent.CLICK, onQuit);
			
			stage.addEventListener(MutationEvent.PAUSE, onPause);
			stage.addEventListener(MutationEvent.UNPAUSE, onUnpause);
			
		}
		
		public function kill():void
		{
			continueButton.removeEventListener(MouseEvent.CLICK, onContinue);
			quitButton.removeEventListener(MouseEvent.CLICK, onQuit);
			
			if (stage){
				stage.removeEventListener(MutationEvent.PAUSE, onPause);
				stage.removeEventListener(MutationEvent.UNPAUSE, onUnpause);
			}
			
			continueButton.kill();
			quitButton.kill();
		}
		
		//	Unpause the game when the "continue" button is pressed
		private function onContinue(e:MouseEvent):void
		{
			if (stage){
				stage.dispatchEvent(new MutationEvent(MutationEvent.UNPAUSE) );
			}
		}
		
		//	Quit the game
		private function onQuit(e:MouseEvent):void
		{
			var save:SharedObject = SharedObject.getLocal("MutationGDM");
			
			save.data.isSaved = true;
			save.data.gamedata = game.getToken();
			save.flush();
			
			if (stage) {
				stage.dispatchEvent(new MutationEvent(MutationEvent.UNPAUSE) );
				stage.dispatchEvent(new MutationEvent(MutationEvent.MENU) );
			}
		}
		
		//	Appear when game is paused
		private function onPause(e:MutationEvent):void
		{
			visible = true;
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
		}
		
		//	Disappear when the game is unpaused
		private function onUnpause(e:MutationEvent):void
		{
			visible = false;
		}
		
	}

}