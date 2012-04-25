package mutation.entity.pathways 
{
	
	public interface cEnzyme 
	{	
		public function cEnzyme();
		
		function update():void;
		
		function mutate(storage:cStorage, DNA:Number):cEnzyme;
		
	}

}