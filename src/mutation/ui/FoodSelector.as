package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.Resource;
	import mutation.events.FoodEvent;
	import mutation.events.UnlockEvent;
	import mutation.Game;
	import mutation.util.Resources;

	public class FoodSelector extends Sprite 
	{
		private var leftArrow:Arrow;
		private var rightArrow:Arrow;
		private var foodBMP:Bitmap;
		private var foodNameOut:TextField;
		private var game:Game;
		
		public function FoodSelector(game:Game) 
		{
			this.game = game;
			
			leftArrow = new Arrow(Arrow.LEFT);
			rightArrow = new Arrow(Arrow.RIGHT);
			foodBMP = new currentFoodGraphic();
			foodNameOut = new TextField();
			foodNameOut.selectable = false;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			addChild(leftArrow);
			addChild(rightArrow);
			addChild(foodBMP);
			addChild(foodNameOut);
			
			leftArrow.x = 10;
			rightArrow.x = 100;
			
			foodBMP.x = 50;
			foodBMP.width = 35;
			foodBMP.height = 35;
			foodBMP.y = -foodBMP.height / 2;
			
			foodNameOut.text = currentFoodDescriptor.names;
			foodNameOut.x = 10;
			foodNameOut.y = 25;
			
			draw();
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			leftArrow.addEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.addEventListener(MouseEvent.CLICK, onRight);
			stage.addEventListener(UnlockEvent.FOOD, onUnlock);
		}
		
		private function onLeft(e:MouseEvent):void
		{
			game.foodSelection--;
			if (game.foodSelection < 1) game.foodSelection = 1;
			draw();
		}
		
		private function onRight(e:MouseEvent):void
		{
			game.foodSelection++;
			if (!game.foods.hasUnlocked(game.foodSelection)) game.foodSelection--;
			draw();
		}
		
		private function draw():void
		{
			removeChild(foodBMP);
			foodBMP = new currentFoodGraphic();
			foodBMP.x = 50;
			foodBMP.width = 35;
			foodBMP.height = 35;
			foodBMP.y = -foodBMP.height / 2;
			addChild(foodBMP);
			foodNameOut.text = currentFoodDescriptor.names;
			
			if (!game.foods.hasUnlocked(game.foodSelection - 2)) {
				leftArrow.setUnselectable();
			}else{
				leftArrow.setSelectable();
			}
			if (!game.foods.hasUnlocked(game.foodSelection + 1)) {
				rightArrow.setUnselectable();
			}else{
				rightArrow.setSelectable();
			}
		}
		
		private function onUnlock(e:UnlockEvent):void
		{
			draw();
		}
		
		private function get currentFoodDescriptor():FoodDescriptor
		{
			return ( game.foods.getAt(game.foodSelection) as FoodDescriptor);
		}
		
		private function get currentFoodGraphic():Class
		{
			return Resources.GRAPHICS[currentFoodDescriptor.graphic];
		}
		
	}

}