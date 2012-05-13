package mutation.events 
{
	import flash.events.Event;

	public class MoneyEvent extends Event 
	{
		public static const CHANGED:String = "MONEY_CHANGED";
		
		public var money:Number;
		
		public function MoneyEvent(type:String, money:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.money = money;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new MoneyEvent(type, money, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MoneyEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}