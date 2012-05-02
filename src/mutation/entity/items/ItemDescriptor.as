package mutation.entity.items 
{

	public class ItemDescriptor 
	{
		public var radius:Number;
		public var money:Number;
		public var startingLife:Number;
		
		public var isUnlocked:Boolean;
		public var unlockCost:Number;
		
		public function ItemDescriptor(xml:XML) 
		{
			radius = xml.radius;
			money = xml.money;
			startingLife = xml.life;
			isUnlocked = xml.unlock.unlocked;
			unlockCost = xml.unlock.cost;
			
		}
		
	}

}