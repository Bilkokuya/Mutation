package mutation.ui 
{
	import flash.display.Stage;
	import mutation.entity.items.Item;
	import mutation.events.ContractEvent;
	import mutation.events.ItemEvent;

	//	A simple contract that details how much needs collected to complete the game
	public class Contract
	{
		public var stage:Stage;
		public var boxesShipped:int;				//	Number of boxes shipped so far
		private var collected_:int;					//	Amount of collected items in the box to be "shipped" for money
		
		public var collectionNeeded:int;		//	Amount of collected items needed before it can be shipped
		public var boxesNeeded:int;				//	Number of boxes needed to be shipped to complete the contract
		public var payPerBox:int;						//	Amount of money to be paid for each box shippe
		public var bonus:int;								//	Bonus pay for completion of the contract
		
		//	Construct the contract from XML
		public function Contract(stage:Stage,  xml:XML) 
		{
			this.stage = stage;
			
			this.collectionNeeded 	= xml.collectionNeeded;
			this.boxesNeeded 			= xml.boxesNeeded;
			this.payPerBox 					= xml.payPerBox;
			this.bonus 							= xml.bonusPay;
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
			}else if (collected > collectionNeeded) {
				collected = collectionNeeded;
			}
		}
		
		//	Returns true if it is filled
		public function isFilled():Boolean
		{
				return (collected_ >= collectionNeeded);
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