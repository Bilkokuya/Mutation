package mutation.entity 
{

	public class BaseDescriptor 
	{
		public var graphic:int;
		public var isUnlocked:Boolean;		//	True if it is unlocked/useable by default
		public var unlockCost:Number;		//	Cost to unlock it (if it is not unlocked)
		public var names:String;
		
		public function BaseDescriptor() 
		{
			graphic = 0;
			isUnlocked = true;
			unlockCost = 0;
			names = "";
		}
		
	}

}