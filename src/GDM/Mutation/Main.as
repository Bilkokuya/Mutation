//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Main (extends Sprite)
//		The main loop and such like

package GDM.Mutation
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.net.URLLoaderDataFormat;
	import GDM.Mutation.container.Background;
	import GDM.Mutation.container.Overlay;
	import GDM.Mutation.container.World;
	import GDM.Mutation.events.MutationEvent;
	import GDM.Mutation.objects.TestTube;
	import GDM.Mutation.ui.Button;
	import GDM.Mutation.events.ButtonEvent;
	import GDM.Mutation.util.Keys;
	
	//	Class: Main extends Sprite
	//	The main game class with main loop
	public class Main extends Sprite 
	{
		private var overlay:Overlay;
		private var world:World;
		private var tickCount:int;
		
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
			overlay = new Overlay();
			world = new World();
			
			//	Set up utilities
			Keys.init(stage);
		
			//	Variable Initialisation
			tickCount = 0;
			
			//	Add children
			addChild(world);
			addChild(overlay);
			
			
			//	Event Listener Stuff
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Listener: onTick
		//	Runs once per frame as the main loop
		private function onTick(e:Event):void
		{
			tickCount++;
			
			//	Dispatch the main game tick event
			var mutationEvent:MutationEvent = new MutationEvent(MutationEvent.TICK);
			mutationEvent.tickCount = tickCount;
			stage.dispatchEvent(mutationEvent);
		}
		
	}

}

import GDM.Mutation.enums.Enum;

//	Class: Action (extends Enum)
//		internal enum for Actions you can take when clicking the tubes
internal class Action extends Enum
{
	internal static const FOOD:Action = new Action(FOOD, 0);
	internal static const FOOD2:Action = new Action(FOOD2);
	internal static const PUNISHMENT:Action = new Action(PUNISHMENT);
	
	FOOD.setString("FOOD");
	FOOD2.setString("FOOD2");
	PUNISHMENT.setString("PUNISHMENT");
	
	public function Action(enum:Action, number:int = int.MIN_VALUE)
	{
		super(enum, number);
	}
}

