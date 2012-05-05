package mutation.entity 
{
	import mutation.entity.BaseDescriptor;

	//	Simple container for lists of items that can be unlocked, e.g. hats
	public class Unlockables 
	{
		
		public var unlocked:Vector.<BaseDescriptor> = new Vector.<BaseDescriptor>();	//	Contains the currently unlocked items
		public var locked:Vector.<BaseDescriptor> = new Vector.<BaseDescriptor>();		//	Contains all of the currently locked items
		
		//	Constructs using fake Template <T> and an xmlList of the objects to instantiate
		public function Unlockables(T:Class, xmlList:XMLList) 
		{
			for each (var xml:XML in xmlList) {
				
				var loadedItem:BaseDescriptor = new T(xml);
				
				if (loadedItem.isUnlocked) {
					unlocked.push(loadedItem);
				}else {
					locked.push(loadedItem);
				}
			}
			
			locked.reverse();
		}
		
		//	Returns the descriptor at the unlocked index
		public function getAt(index:int):BaseDescriptor
		{
			return unlocked[index];
		}
		
		//	Gets the next locked item; does not check for index safety
		public function getNextLocked():BaseDescriptor
		{
			return locked[locked.length - 1];
		}
		
		//	Unlocks the next item in the locked list -> sending it to the unlocks
		public function unlockNext():void
		{
			if (locked.length > 0)
				unlocked.push( locked.pop() );
		}
		
		//	Checks if the index given exists as an unlocked item
		public function hasUnlocked(index:int):Boolean
		{
			if ((unlocked.length-1) < index) {
				return false;
			}else if (index < 0) {
				return false
			}else {
				return true;
			}
		}
		
		//	Returns if there is another locked item still there
		public function hasLocked():Boolean
		{
			return (locked.length > 0);
		}
	}

}