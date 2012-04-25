package mutation.entity.pathways 
{

	public class cConverter implements cEnzyme
	{
		public var storage:cStorage;
		public var from:int;
		public var to:int;
		public var rate:Number;
		public var efficiency:Number;
		public var dnaResistance:Number;
		
		public function cConverter(storage:cStorage, from:int, to:int, rate:Number = 1, efficiency:Number = 1, dnaResistance:Number = 1 ) 
		{
			this.storage = storage;
			this.from = from;
			this.to = to;
			this.rate = rate;
			this.efficiency = efficiency;
			this.dnaResistance = dnaResistance;
		}
		
		public function update():void
		{
			if (storage.resources[from] > rate) {
				storage.resources[from] -= rate;
				storage.resources[to] += rate * efficiency;
				
			}else {
				storage.resources[to] += storage.resources[from] * efficiency;
				storage.resources[from] = 0;
			}
		}
		
		public function mutate(storage:cStorage, DNA:Number):cEnzyme
		{
			var m:Number = ((Math.random() - 0.5)/(DNA+0.2))/dnaResistance;
			var m2:Number = ((Math.random() - 0.5)/(DNA+0.2))/dnaResistance;
			
			return (new cConverter(storage, from, to, rate+m, efficiency+m2, dnaResistance));
		}
		
		
	}

}