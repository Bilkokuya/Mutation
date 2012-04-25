package mutation.entity.pathways 
{

	public class cStorage 
	{
		//	Indexes to find these resources in the resources vector
		public static const DNA:int = 0;
		public static const FOOD:int = 1;
		public static const APS:int = 2;
		public static const PAPS:int = 3;
		public static const MONEY:int = 4;
		public static const LOVE:int = 5;
		
		public var resources:Array = new Array(
			50, 100, 1000, 0, 0, 0
		);
				
		public function cStorage() 
		{
		}
		
	}

}