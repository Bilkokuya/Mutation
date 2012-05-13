package mutation.events 
{
	import flash.events.Event;
	
	public class UnlockEvent extends Event 
	{
		public static const HAT:String = "UNLOCK_HAT";
		public static const FOOD:String = "UNLOCK_FOOD";
		
		public function UnlockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new UnlockEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UnlockEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}