package mutation.ui.contracts 
{
	import flash.display.Stage;
	import mutation.entity.BaseDescriptor;
	import mutation.entity.items.Item;
	import mutation.events.ContractEvent;
	import mutation.events.ItemEvent;

	//	A simple contract that details how much needs collected to complete the game
	public class Contract
	{
		public var stage:Stage;
		public var boxesShipped:int;				//	Number of boxes shipped so far
		private var collected_:int;					//	Amount of collected items in the box to be "shipped" for money
		public var type:ContractDescriptor;

		//	Construct the contract from XML
		public function Contract(stage:Stage,  descriptor:ContractDescriptor ) 
		{
			this.stage = stage;

			this.type = descriptor;
			this.boxesShipped 			= 0;
			this.collected_ 					= 0;
			
			stage.addEventListener(ItemEvent.COLLECTED, onCollect);
		}
		
		public function kill():void
		{
			if (stage){
				stage.removeEventListener(ItemEvent.COLLECTED, onCollect);
			}
		}
		
		//	Listens for any items dying and collects their amounts
		public function onCollect(e:ItemEvent):void
		{
			collected += e.item.getAmount();
			
			if (collected < 0) {
				collected = 0;
			}else if (collected > type.collectionNeeded) {
				collected = type.collectionNeeded;
			}
		}
		
		public function ship():void
		{
			collected = 0;
			boxesShipped++;
			if (boxesShipped > type.boxesNeeded) {
				stage.dispatchEvent(new ContractEvent( ContractEvent.COMPLETED, this) );
			}
		}
		
		//	Returns true if it is filled
		public function isFilled():Boolean
		{
				return (collected_ >= type.collectionNeeded);
		}
		
		//	Accessor for the collected property
		public function get collected():int
		{
			return collected_;
		}
		
		//	Setter for the collected property - dispatches a changed event to alert any UI dependancy
		public function set collected(amount:int):void
		{
			collected_ = amount;
			if (stage){
				stage.dispatchEvent(new ContractEvent( ContractEvent.CHANGED, this) );
			}
		}

	}

}