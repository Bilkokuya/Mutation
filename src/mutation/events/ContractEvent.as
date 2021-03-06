package mutation.events 
{
	import flash.events.Event;
	import mutation.ui.contracts.Contract;
	
	public class ContractEvent extends Event
	{
		public static const SHIPPED:String			=	"CONTRACT_SHIPPED";
		public static const CHANGED:String 		= "CONTRACT_CHANGED";	//	Called when a contract has been changed
		public static const COMPLETED:String 	= "CONTRACT_COMPLETED";
		public static const SELECTED:String		= "CONTRACT_SELECTED";
		
		public var contract:Contract;	//	Amount of collected stuff
		
		
		public function ContractEvent(type:String, contract:Contract, bubbles:Boolean = false, cancellable:Boolean = false) 
		{
			this.contract = contract;
			super(type,  bubbles, cancelable);
		}
		
	}

}