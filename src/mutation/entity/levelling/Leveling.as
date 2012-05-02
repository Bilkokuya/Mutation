package mutation.entity.levelling 
{

	//	Levelling component for bacteria experience 
	public class Leveling 
	{
		private var levels:Vector.<Level> = null;			//	The amount of exp needed to progress for each level
		public var level:Number = 1;						//	The current level
		public var experience:Number = 0;					//	The current amount of experience, resets each level
		private var hasLevelledThisTick:Boolean = false;	//	True if it has levelled in this tick
		
		//	Base class constructor
		public function Leveling(levelsVector:Vector.<Level>) 
		{
			this.levels = levelsVector;
		}
		
		//	Updates the levelling system with the given amount of exp
		public function update(exp:Number):void
		{
			hasLevelledThisTick = false;
			experience += exp;
			if (levels[level].canLevel(experience)) {
				nextLevel();
			}
		}
		
		//	Returns the current level for the bacteria to update with
		public function getLevel():Level
		{
			return (levels[level]);
		}
		
		//	Called whenever the object gets to the next level
		private function nextLevel():void
		{
			hasLevelledThisTick = true;
			level++;
			experience = 0;
		}
		
		//	Returns tue if it has levelled up this tick
		public function hasLevelledUp():Boolean
		{
			if (hasLevelledThisTick) {
				hasLevelledThisTick = false;
				return true;
			}else {
				return false;
			}
		}
		
	}

}