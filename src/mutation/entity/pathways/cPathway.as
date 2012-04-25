package mutation.entity.pathways 
{
	import mutation.entity.Food;

	public class cPathway implements cEnzyme
	{		
		//	An ordered array of component enzymes in this pathway
		//	Always updated in order 0->length
		public var pathwayEnzymes:Array;
		
		public function cPathway(enzymes:Array)
		{
			pathwayEnzymes = enzymes;
		}
		
		public function update():void
		{
			for (var i:int = 0; i < pathwayEnzymes.length; ++i) {
				var enzyme:cEnzyme = pathwayEnzymes[i];
				enzyme.update();
			}
		}
		
		public function mutate(storage:cStorage, DNA:Number):cEnzyme
		{
			
			var array:Array = new Array();
			for each ( var e:cEnzyme in pathwayEnzymes) {
				array.push(e.mutate(storage, DNA));
			}
			return new cPathway(array);
			
		}
		
	}

}