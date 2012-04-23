package mutation.entity.pathways 
{

	public class Resource 
	{
		public var amount:Number;
		
		public function Resource(amount:Number) 
		{
			this.amount = amount;
		}
		
		public function add(resource:Resource):void
		{
			amount += resource.amount;
		}
		
		public function combineWith(resource:Resource):Resource
		{
			return Resource(amount += resource.amount);
		}
		
	}

}