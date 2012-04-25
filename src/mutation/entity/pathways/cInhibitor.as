package mutation.entity.pathways 
{
	/**
	 * ...
	 * @author Gordon Mckendrick
	 */
	public class cInhibitor implements cEnzyme
	{
		public var storage:cStorage;
		public var inhibitedEnzyme:cEnzyme;
		public var used:int;
		public var cost:Number;
		public var dnaResistance:Number;
		
		public function cInhibitor(storage:cStorage, enzyme:cEnzyme, used:int, cost:Number = 1, dnaResistance:Number = 1) 
		{
			this.storage = storage;
			inhibitedEnzyme = enzyme;
			this.used = used;
			this.cost = cost;
			this.dnaResistance = dnaResistance;
		}
		
		public function update():void
		{
			if (storage.resources[used] > cost) {
				storage.resources[used] -= cost;
			}else{
				inhibitedEnzyme.update();
			};
		}
		
		public function mutate(storage:cStorage, DNA:Number):cEnzyme
		{
			var enzyme:cEnzyme = inhibitedEnzyme.mutate(storage, DNA);
			
			var m:Number = ((Math.random() - 0.5)/(DNA+0.2))/dnaResistance;
			
			return (new cInhibitor(storage, enzyme, used, cost + m, dnaResistance));
		}
	}

}