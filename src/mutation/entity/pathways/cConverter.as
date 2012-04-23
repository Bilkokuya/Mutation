package mutation.entity.pathways 
{

	public class cConverter implements cEnzyme
	{
		public var from:Resource;
		public var to:Resource;
		public var rate:Number;
		public var efficiency:Number;
		
		public function cConverter(from:Resource, to:Resource, rate:Number = 1, efficiency:Number = 1 ) 
		{
			this.from = from;
			this.to = to;
			this.rate = rate;
			this.efficiency = efficiency;
		}
		
		public function update():void
		{
			if (from.amount > rate) {
				from.amount -= rate;
				to.amount += rate * efficiency;
				
			}else {
				to.amount += from.amount * efficiency;
				from.amount = 0;
			}
		}
		
		
	}

}