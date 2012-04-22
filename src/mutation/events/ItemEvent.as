package mutation.events 
{
	import flash.events.Event;
	import mutation.entity.Item;
	
	public class ItemEvent extends Event 
	{
		public static const DEATH:String = "ITEM_DEATH";
		public var item:Item;
		
		public function ItemEvent(type:String, item:Item, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			this.item = item;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ItemEvent(type, item, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ItemEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}