package mutation.events 
{
	import flash.events.Event;
	import mutation.entity.Bacteria;
	
	public class BacteriaEvent extends Event 
	{
		public static const DEATH:String = "BACTERIA_DEATH";
		public static const PRODUCE:String = "BACTERIA_PRODUCE";
		
		public var bacteria:Bacteria;
		
		public function BacteriaEvent(type:String, bacteria:Bacteria, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.bacteria = bacteria;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new BacteriaEvent(type,bacteria,bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("BacteriaEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}