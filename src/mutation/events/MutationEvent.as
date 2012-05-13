package mutation.events 
{
	import flash.events.Event;

	//	Class: MutationEvent
	public class MutationEvent extends Event
	{
		//	Event Types
		public static const TICK:String 					= "MUTATION_TICK";					//	Every tick after the game starts running (for any constant updates)
		public static const TICK_MAIN:String		= "MUTATION_TICK_MAIN";		//	The main game ticks	(for any playable, pausable updates; e.g. test tubes)
		public static const TICK_MENU:String	= "MUTATION_TICK_MENU";		//	Overlay menu ticks		(for any overlay menus that run while the game is paused)
		public static const PAUSE:String				= "MUTATION_PAUSE";				//	Pause the game
		public static const UNPAUSE:String		= "MUTATION_UNPAUSE";			//	Unpause the game
		public static const GAME:String				= "MUTATION_GAME";				//	Signals continue of an existing game
		public static const NEWGAME:String	=	"MUTATION_NEWGAME";		//	Signals a new game, not continues from save
		public static const MENU:String				= "MUTATION_MENU";				//	Signals a return to the main menu
		public static const QUIT:String					=	"MUTATION_QUIT";					//	Signals the game being closed (via menus, not via red-crossing)
		
		//	Event data
		public var tickCount:int;
		
		public function MutationEvent(type:String, tickCount:int = 0, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			this.tickCount = tickCount;
			super(type, bubbles, cancelable);
		}
		
	}

}