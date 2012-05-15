//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and initialisation of the game

package mutation
{	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.SoundMixer;
	import flash.net.SharedObject;
	import flash.ui.Keyboard;
	import mutation.events.MutationEvent;
	import mutation.ui.screens.IntroScreen;
	import mutation.util.Resources;
	
	//	Class: Main extends Sprite
	//	The main game class with main loop
	public class Main extends Sprite 
	{
		static public var isPaused:Boolean = false;
		private var tickCount:int = 0;
		public var game:Game;
		public var menu:IntroScreen;
		public var soundManager:SoundManager;
		
		//	Do not edit
		public function Main():void 
		{			 
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation once the stage is created
		private function onInit(e:Event = null):void 
		{	
			Resources.load();
			
			isPaused = true;
			
			soundManager = new SoundManager();
			
			menu = new IntroScreen();
			addChild(menu);
			addChild(soundManager);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(MutationEvent.PAUSE, onPause);
			stage.addEventListener(MutationEvent.UNPAUSE, onUnpause);
			stage.addEventListener(MutationEvent.GAME, onGame);
			stage.addEventListener(MutationEvent.NEWGAME, onNewGame);
			stage.addEventListener(MutationEvent.MENU, onMenu);
		}
		
		//	Sends the main game update event as long as the game is not paused
		private function onTick(e:Event):void
		{
			tickCount++;
			
			stage.dispatchEvent(new MutationEvent(MutationEvent.TICK, tickCount));
			
			//	Send out the main game or menu ticks if it is paused
			if (!isPaused) {
				stage.dispatchEvent(new MutationEvent(MutationEvent.TICK_MAIN, tickCount));
			}else {
				stage.dispatchEvent(new MutationEvent(MutationEvent.TICK_MENU, tickCount));
			}
		}
		
		//	Stars the game
		private function onGame(e:MutationEvent):void
		{
			var save:SharedObject = SharedObject.getLocal("MutationGDM" );
			
			game = new Game();
			addChild(game);
			addChildAt(soundManager, numChildren - 1);
			game.buildFromToken(save.data.gamedata);
			game.start();
		}
		
		//	Stars the game
		private function onNewGame(e:MutationEvent):void
		{
			var save:SharedObject = SharedObject.getLocal("MutationGDM" );
			save.clear();
			game = new Game();
			addChild(game);
			addChildAt(soundManager, numChildren - 1);
			game.start();
		}
		
		//	Opens the main menu
		private function onMenu(e:MutationEvent):void
		{
			game.kill();
			removeChild(game);
		}
		
		//	Pause the main game
		private function onPause(e:MutationEvent):void
		{
			isPaused = true;
		}
		
		//	Unpause the main game
		private function onUnpause(e:MutationEvent):void
		{
			isPaused = false;
		}
	}

}
