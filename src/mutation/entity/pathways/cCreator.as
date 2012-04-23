package mutation.entity.pathways 
{
	
	public class cCreator implements cEnzyme
	{
		public var to:Resource;
		public var rate:Number;
		
		public function cCreator(to:Resource, rate:Number = 1) 
		{
			this.to = to;
			this.rate = rate;
		}
		
		public function update():void
		{
			to.amount += rate;
		}
	}

}