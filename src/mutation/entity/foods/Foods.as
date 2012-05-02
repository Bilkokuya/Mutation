package mutation.entity.foods 
{
	import mutation.util.Resources;
	
	//	Static, temporary holding for the different types of Food types available
	//	Should be replaced with a runtime array of hats available; allowing easy changes by changing the XML
	public class Foods 
	{
		public static const DEBRIS:FoodDescriptor = new FoodDescriptor((Resources.getXML(Resources.XML_FOODS).food[0]));
		public static const BASIC:FoodDescriptor = new FoodDescriptor((Resources.getXML(Resources.XML_FOODS).food[1]));
		public static const DOUBLE:FoodDescriptor = new FoodDescriptor((Resources.getXML(Resources.XML_FOODS).food[2]));

		public static var selectedFood:int = 1;
		
		public static const foods:Vector.<FoodDescriptor> = new <FoodDescriptor>[
			DEBRIS,
			BASIC,
			DOUBLE
		];
		
		public function Foods();
	}

}