//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and such like

package mutation
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.Bacteria;

	import mutation.events.MutationEvent;
	import mutation.entity.TestTube;
	import mutation.util.Keys;
	
	//	Class: Main extends Sprite
	//	The main game class with main loop
	public class Main extends Sprite 
	{
		private var tickCount:int;
		private var testTube:TestTube;
		
		//	Constructor: default
		public function Main():void 
		{			 
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialisation once the stage is created
		private function onInit(e:Event = null):void 
		{	
			testTube = new TestTube(100,200,100);

			Keys.init(stage);
			
			tickCount = 0;
			
			addChild(testTube);
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Listener: onTick
		//	Runs once per frame as the main loop
		private function onTick(e:Event):void
		{
			tickCount++;
			
			//	Dispatch the main game tick event
			stage.dispatchEvent(new MutationEvent(MutationEvent.TICK, tickCount));
		}
		
	}

}
