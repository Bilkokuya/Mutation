package mutation.ui.screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.events.MutationEvent;
	import mutation.ui.Button;

	public class PauseMenu extends Sprite
	{
		private const WIDTH:int = 150;
		private const HEIGHT:int = 250;
		private const MARGIN:int = 10;
		
		private var menu:Sprite;
		private var continueButton:Button;
		private var quitButton:Button;
		
		public function PauseMenu() 
		{
			menu = new Sprite();
			continueButton = new Button(MARGIN + 50, 50, "CONTINUE");
			quitButton = new Button(MARGIN + 50, 125, "QUIT");
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			draw();
			
			addChild(menu);
			menu.addChild(continueButton);
			menu.addChild(quitButton);
			
			menu.x = (stage.stageWidth / 2) - (WIDTH / 2);
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
		
		//	Draw the basic shapes
		private function draw():void
		{
			graphics.beginFill(0x111122, 0.85);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			menu.graphics.beginFill(0xFFFFFF, 1);
			menu.graphics.drawRect(0, 0, 150, 250);
			menu.graphics.endFill();
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
			if (stage){
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