package mutation.ui.contracts 
{
	import mutation.entity.BaseDescriptor;

	//	Hacky implementation of something that shouldn't be done this way
	//	But abusing existing code allowed for faster implementation that was tested
	//	If there is time, go back and re-write the entire 'Contract' system
	public class ContractDescriptor extends BaseDescriptor
	{
		public var background:int;
		public var group:int;
		public var collectionNeeded:int;		//	Amount of collected items needed before it can be shipped
		public var boxesNeeded:int;				//	Number of boxes needed to be shipped to complete the contract
		public var payPerBox:int;						//	Amount of money to be paid for each box shippe
		public var bonus:int;								//	Bonus pay for completion of the contract
		public var description:String;				//	Text description for use visually when selecting the contract
		public var hasRequirement:Boolean;
		public var requirement:int;
		public var next:int;
		public var isComplete:Boolean;
		
		//	Loads the contract descriptor from the given contract node
		public function ContractDescriptor(xml:XML) 
		{
			super();
			
			this.group 							= xml.id;
			this.collectionNeeded 				= xml.collectionNeeded;
			this.boxesNeeded 					= xml.boxesNeeded;
			this.payPerBox 						= xml.payPerBox;
			this.bonus 							= xml.bonusPay;
			this.description 					= xml.description;
			this.next							= xml.next;
			
			(xml.hasRequirement == "true") ? hasRequirement = true : hasRequirement = false;
			this.requirement 				=	xml.required;
			
			isComplete = false;
			
		}
		
	}

}