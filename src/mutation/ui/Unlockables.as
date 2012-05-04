package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.hats.Hat;
	import mutation.entity.Resource;
	import mutation.Game;
	import mutation.util.Resources;

	
	public class Unlockables extends Sprite
	{
		
		private var unlockFood:Unlock;
		private var unlockHat:Unlock;
		private var game:Game;
		
		public function Unlockables(game:Game) 
		{
			this.game = game;

			if (game.hats.hasLocked()){
				unlockHat = new Unlock(new Resources.GRAPHICS[game.hats.getNextLocked().graphic], 0);
			}else {
				unlockHat = new Unlock(new Resources.GRAPHICS[0], 0);
			}
			
			if (game.foods.hasLocked()){
				unlockFood = new Unlock(new Resources.GRAPHICS[game.foods.getNextLocked().graphic], 0);
			}else {
				unlockFood = new Unlock(new Resources.GRAPHICS[0], 0);	
			}
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(unlockFood);
			addChild(unlockHat);
			
			unlockFood.x = 0;
			unlockHat.x = 55;
			
			unlockFood.addEventListener(MouseEvent.CLICK, onFoodClick);
			unlockHat.addEventListener(MouseEvent.CLICK, onHatClick);
		}
		
		private function onFoodClick(e:MouseEvent):void
		{
			trace("food upgrade clicked");
			game.foods.unlockNext();
		}
		
		private function onHatClick(e:MouseEvent):void
		{
			trace("hat upgrade clicked");
			game.hats.unlockNext();
		}
		
	}

}