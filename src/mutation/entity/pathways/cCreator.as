package mutation.entity.pathways 
{
	
	public class cCreator implements cEnzyme
	{
		public var isMutatable:Boolean;
		public var dnaResistance:Number;
		public var storage:cStorage;
		public var to:int;
		public var rate:Number;
		
		
		public function cCreator(storage:cStorage,to:int, rate:Number = 1, dnaResistance:Number = 1, mutatable:Boolean = false) 
		{
			this.storage = storage;
			this.to = to;
			this.rate = rate;
			this.isMutatable = mutatable;
			this.dnaResistance = dnaResistance;
		}
		
		public function update():void
		{
			storage.resources[to] += rate;
		}
		
		public function mutate(storage:cStorage, DNA:Number):cEnzyme
		{
			
			var m:Number = ((Math.random() - 0.5)/(DNA+0.2))/ dnaResistance;
			if (!isMutatable) m = 0;
			return (new cCreator(storage, to, rate + m, dnaResistance, isMutatable));
		}
	}

}