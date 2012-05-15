package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
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
		private var foodCostOut:TextField;
		private var buttonBacking:Bitmap;
		private var game:Game;
		
		public function FoodSelector(game:Game) 
		{
			this.game = game;
			
			buttonBacking = new Resources.GFX_UI_BUTTON_BASE;
			leftArrow = new Arrow(Arrow.LEFT);
			rightArrow = new Arrow(Arrow.RIGHT);
			foodBMP = new currentFoodGraphic();
			
			foodCostOut = new TextField();
			foodCostOut.defaultTextFormat = new TextFormat("Century Gothic", 24, 0x7C2C00, true);
			foodCostOut.selectable = false;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(buttonBacking);
			addChild(leftArrow);
			addChild(rightArrow);
			addChild(foodBMP);
			addChild(foodCostOut);
			
			leftArrow.x = 15;
			leftArrow.y = 0;
			rightArrow.x = 65;
			rightArrow.y = 0;
			
			buttonBacking.y = 0;
			foodBMP.y = 50;
			
			foodBMP.x = 50;
			foodBMP.width = 35;
			foodBMP.height = 35;
			foodBMP.y = -foodBMP.height / 2;
			
			foodCostOut.text ="菌" + currentFoodDescriptor.cost;
			foodCostOut.x = 5;
			foodCostOut.y = 50;
			
			draw();
			
			leftArrow.addEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.addEventListener(MouseEvent.CLICK, onRight);
			stage.addEventListener(UnlockEvent.FOOD, onUnlock);
		}
		
		public function kill():void
		{
			leftArrow.removeEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.removeEventListener(MouseEvent.CLICK, onRight);
			if (stage){
				stage.removeEventListener(UnlockEvent.HAT, onUnlock);
			}
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
		
		public function update():void
		{
			draw();
		}

		private function draw():void
		{
			removeChild(foodBMP);
			foodBMP = new currentFoodGraphic();
			foodBMP.x = 25;
			foodBMP.width = 35;
			foodBMP.height = 35;
			foodBMP.y = 25;
			addChild(foodBMP);
			addChildAt(foodCostOut, numChildren - 1);
			foodCostOut.text = "菌" + currentFoodDescriptor.cost;
			
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
			return Resources.GRAPHICS_FOODS[currentFoodDescriptor.graphic];
		}
		
	}

}