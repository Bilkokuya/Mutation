package GDM.Mutation.events 
{
	import flash.events.Event;

	//	Class: MutationEvent
	public class MutationEvent extends Event
	{
		//	Event Types
		public static const TICK:String = "TICK";
		
		//	Event data
		public var tickCount:int;
		
		public function MutationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			tickCount = 0;
			super(type, bubbles, cancelable);
		}
		
	}

}