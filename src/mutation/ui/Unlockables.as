package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Unlockables extends Sprite
	{
		public var unlockables:Array;
		
		public function Unlockables() 
		{
			unlockables = new Array();
			
			super();
			
			if (stage) onInit();
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
	}

}