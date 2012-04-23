package mutation.entity.pathways 
{
	/**
	 * ...
	 * @author Gordon Mckendrick
	 */
	public class cInhibitor implements cEnzyme
	{
		public var inhibitedEnzyme:cEnzyme;
		public var used:Resource;
		public var cost:Number;
		
		public function cInhibitor(enzyme:cEnzyme, used:Resource, cost:Number = 1) 
		{
			inhibitedEnzyme = enzyme;
			this.used = used;
			this.cost = cost;
		}
		
		public function update():void
		{
			if (used.amount > cost) {
				used.amount -= cost;
			}else{
				inhibitedEnzyme.update();
			};
		}
	}

}