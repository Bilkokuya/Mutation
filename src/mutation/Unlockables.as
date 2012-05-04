package mutation 
{
	import asunit.runner.BaseTestRunner;
	import mutation.entity.BaseDescriptor;

	public class Unlockables 
	{
		
		public var unlocked:Vector.<BaseDescriptor> = new Vector.<BaseDescriptor>();
		public var locked:Vector.<BaseDescriptor> = new Vector.<BaseDescriptor>();
		
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
		
		public function getAt(index:int):BaseDescriptor
		{
			return unlocked[index];
		}
		
		public function getNextLocked():BaseDescriptor
		{
			return locked[locked.length - 1];
		}
		
		public function unlockNext():void
		{
			if (locked.length > 0)
				unlocked.push( locked.pop() );
		}
		
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
		
		public function hasLocked():Boolean
		{
			return (locked.length > 0);
		}
	}

}