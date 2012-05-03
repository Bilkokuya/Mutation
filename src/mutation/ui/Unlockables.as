package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.hats.Hat;
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
			
			var foodBitmap:Bitmap = null;
			
			var index:int = -1;
			for (var i:int = 0; i < Resources.HAT_TYPES.length; ++i){
				if (!Resources.HAT_TYPES[i].isUnlocked) {
					index = i;
					break;
				}
			}
			unlockHat = new Unlock(new Resources.GRAPHICS[Resources.HAT_TYPES[index].bitmapIndex], index);
			
			index = 0;
			for (var i:int = 0; i < Resources.FOOD_TYPES.length; ++i){
				if (!Resources.FOOD_TYPES[i].isUnlocked) {
					index = i;
					break;
				}
			}
			unlockFood = new Unlock(new Resources.GRAPHICS[Resources.FOOD_TYPES[index].graphic], index);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(unlockFood);
			addChild(unlockHat);
			
			draw();
			
			unlockFood.x = 0;
			unlockHat.x = 55;
			
			unlockFood.addEventListener(MouseEvent.CLICK, onFoodClick);
			unlockHat.addEventListener(MouseEvent.CLICK, onHatClick);
		}
		
		private function draw():void
		{
			unlockFood.graphics.beginFill(0xFF0000);
			unlockFood.graphics.drawRect(0, 0, 50, 50);
			unlockFood.graphics.endFill();
			
			unlockHat.graphics.beginFill(0x00FF00);
			unlockHat.graphics.drawRect(0, 0, 50, 50);
			unlockHat.graphics.endFill();
		}
		
		private function onFoodClick(e:MouseEvent):void
		{
			trace("food upgraded");
		}
		
		private function onHatClick(e:MouseEvent):void
		{
			trace("hat upgraded");
			if (game.money > Resources.HAT_TYPES[unlockHat.index].unlockCost) {
				game.money -= Resources.HAT_TYPES[unlockHat.index].unlockCost;
				Resources.HAT_TYPES[unlockHat.index].isUnlocked = true;
				
				//update hat graphic
				unlockHat.setBitmap(new Resources.GRAPHICS[Resources.HAT_TYPES[unlockHat.index].bitmapIndex]);
				unlockHat.index++;
			}
		}
		
	}

}