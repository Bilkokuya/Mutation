package mutation.entity.behaviours 
{

	public class Leveling 
	{
		private var expNeeded:Array = null;	//	The amount of exp needed to progress for each level
		public var level:Number = 1;		//	The current level
		public var experience:Number = 0;	//	The current amount of experience, resets each level
		private var hasLevelledThisTick:Boolean = false;
		
		//	Base class constructor
		public function Leveling(expNeeded:Array) 
		{
			this.expNeeded = expNeeded;
		}
		
		//	Updates the levelling system with the given amount of exp
		public function update(exp:Number):void
		{
			hasLevelledThisTick = false;
			experience += exp;
			if (experience > expNeeded[level]) {
				nextLevel();
			}
		}
		
		//	Called whenever the object gets to the next level
		private function nextLevel():void
		{
			hasLevelledThisTick = true;
			level++;
			experience = 0;
		}
		
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