package mutation.entity 
{

	//	Holds shared data that all item descriptors require
	//	Allows use of polymorphism of descriptors, due to limitations of flash not having templates/generics.
	//		NB: Could be refactored into an interface, but that involves duplication of these shared variables and the getters/setters for them
	public class BaseDescriptor 
	{
		public var graphic:int						=	0;			//	Where the bitmap for this will be found in the Resources graphics array
		public var isUnlocked:Boolean	=	true;		//	True if it is unlocked/useable by default
		public var unlockCost:Number	=	0;			//	Cost to unlock it (if it is not unlocked)
		public var names:String 				=	"";			//	The name of the item, avoiding conflic with Flash's "name" parameter
		
		//	No constructor operations, this class is effectively an interface+variables
		public function BaseDescriptor();
		
	}

}