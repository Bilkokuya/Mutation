//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and initialisation of the game

package mutation
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
		
			menu = new IntroScreen();
			addChild(menu);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(Event.ENTER_FRAME, onTick);
			stage.addEventListener(MutationEvent.PAUSE, onPause);
			stage.addEventListener(MutationEvent.UNPAUSE, onUnpause);
			stage.addEventListener(MutationEvent.GAME, onGame);
			stage.addEventListener(MutationEvent.MENU, onMenu);
		}
		
		//	Sends the main game update event as long as the game is not paused
		private function onTick(e:Event):void
		{
			tickCount++;
			
			stage.dispatchEvent(new MutationEvent(MutationEvent.TICK, tickCount));
			
			//	Send out the main game or menu ticks if it is paused
			if (!isPaused){
				stage.dispatchEvent(new MutationEvent(MutationEvent.TICK_MAIN, tickCount));
			}else {
				stage.dispatchEvent(new MutationEvent(MutationEvent.TICK_MENU, tickCount));
			}
		}
		
		//	Stars the game
		private function onGame(e:MutationEvent):void
		{
			menu.visible = false;
			game = new Game();
			addChild(game);
		}
		
		//	Opens the main menu
		private function onMenu(e:MutationEvent):void
		{
			game.kill();
			removeChild(game);
			menu.visible = true;
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
