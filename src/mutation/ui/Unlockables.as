package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;

	
	public class Unlockables extends Sprite
	{
		
		private var unlockFood:Sprite;
		private var unlockHat:Sprite;
		private var unlockTube:Sprite;
		
		public function Unlockables() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit():void
		{
			
		}
		
		private function draw():void
		{
			
		}
		
	}

}