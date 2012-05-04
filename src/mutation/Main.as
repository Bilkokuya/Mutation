//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and such like

package mutation
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import flash.ui.Keyboard;
	import mutation.container.Background;
	import mutation.entity.Bacteria;
	import mutation.entity.foods.Food;
	import mutation.events.BacteriaEvent;
	import mutation.ui.Button;
	import mutation.ui.FoodSelector;
	import mutation.ui.NameBacteriaDisplay;
	import mutation.util.Resources;

	import mutation.events.MutationEvent;
	import mutation.entity.TestTube;
	import mutation.events.ButtonEvent;
	
	//	Class: Main extends Sprite
	//	The main game class with main loop
	public class Main extends Sprite 
	{
		static public var isPaused:Boolean = false;
		private var tickCount:int = 0;
		public var game:Game;
		
		//	Do Not Edit
		public function Main():void 
		{			 
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation once the stage is created
		private function onInit(e:Event = null):void 
		{	
			Resources.load();
			
			game = new Game();
			addChild(game);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Sends the main game update event as long as the game is not paused
		private function onTick(e:Event):void
		{
			if (!isPaused){
				tickCount++;
				
				//	Dispatch the main game tick event
				stage.dispatchEvent(new MutationEvent(MutationEvent.TICK, tickCount));
			}
		}
	}

}
