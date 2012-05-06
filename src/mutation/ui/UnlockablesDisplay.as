package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.hats.Hat;
	import mutation.entity.Resource;
	import mutation.events.UnlockEvent;
	import mutation.Game;
	import mutation.util.Resources;

	
	public class UnlockablesDisplay extends Sprite
	{
		
		private var unlockFood:UnlockableDisplayElement;
		private var unlockHat:UnlockableDisplayElement;
		private var game:Game;
		
		public function UnlockablesDisplay(game:Game) 
		{
			this.game = game;

			if (game.hats.hasLocked()){
				unlockHat = new UnlockableDisplayElement(new Resources.GRAPHICS_HATS[game.hats.getNextLocked().graphic], 0);
			}else {
				unlockHat = new UnlockableDisplayElement(new Resources.GRAPHICS_HATS[0], 0);
			}
			
			if (game.foods.hasLocked()){
				unlockFood = new UnlockableDisplayElement(new Resources.GRAPHICS_FOODS[game.foods.getNextLocked().graphic], 0);
			}else {
				unlockFood = new UnlockableDisplayElement(new Resources.GRAPHICS_FOODS[0], 0);	
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
		
		public function kill():void
		{
			unlockFood.removeEventListener(MouseEvent.CLICK, onFoodClick);
			unlockHat.removeEventListener(MouseEvent.CLICK, onHatClick);
		}
		
		private function onFoodClick(e:MouseEvent):void
		{
			if (game.foods.hasLocked()) {
				var unlockCost:Number = game.foods.getNextLocked().unlockCost;
				if (game.money < unlockCost) return;
				game.money -= unlockCost;
				
				game.foods.unlockNext();
				if (game.foods.hasLocked()){
					unlockFood.setBitmap( new Resources.GRAPHICS_FOODS[ game.foods.getNextLocked().graphic ]);
				}else{
					unlockFood.setBitmap( new Resources.GFX_NO_UNLOCK);
				}
				if (stage){
					stage.dispatchEvent(new UnlockEvent(UnlockEvent.FOOD));
				}
			}
		}
		
		private function onHatClick(e:MouseEvent):void
		{
			if (game.hats.hasLocked()) {
				var unlockCost:Number = game.hats.getNextLocked().unlockCost;
				if (game.money < unlockCost) return;
				game.money -= unlockCost;
				
				game.hats.unlockNext();
				if (game.hats.hasLocked()){
					unlockHat.setBitmap( new Resources.GRAPHICS_HATS[ game.hats.getNextLocked().graphic ]);
				}else{
					unlockHat.setBitmap( new Resources.GFX_NO_UNLOCK);
				}
			}
			if (stage){
				stage.dispatchEvent(new UnlockEvent(UnlockEvent.HAT));
			}
		}
		
	}

}