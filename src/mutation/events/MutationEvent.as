package mutation.events 
{
	import flash.events.Event;

	//	Class: MutationEvent
	public class MutationEvent extends Event
	{
		//	Event Types
		public static const TICK:String = "TICK";
		
		//	Event data
		public var tickCount:int;
		
		public function MutationEvent(type:String, tickCount:int, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			this.tickCount = tickCount;
			super(type, bubbles, cancelable);
		}
		
	}

}