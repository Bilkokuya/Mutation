package mutation.entity.pathways 
{
	import flash.events.Event;

	public class cProducer implements cEnzyme
	{
		public var from:Resource;
		public var needed:Number;
		public var event:Event;
		
		public function cProducer(from:Resource, needed:Number, event:Event) 
		{
			this.from = from;
			this.needed = needed;
			this.event = event;
		}
		
		override public function update()
		{
			if (from.amount > needed) {
				//send event...somehow
			}
		}
		
	}

}