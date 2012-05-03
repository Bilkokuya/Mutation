package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.Resource;
	import mutation.Game;
	import mutation.util.Resources;

	public class FoodSelector extends Sprite 
	{
		public var maxFood:int = 1;
		public var minFood:int = 1;
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
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			leftArrow.addEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.addEventListener(MouseEvent.CLICK, onRight);
		}
		
		public function getFoodDesc():FoodDescriptor
		{
			return Resources.FOOD_TYPES[game.selectedFood];
		}
		
		private function onLeft(e:MouseEvent):void
		{
			game.selectedFood--;
			if (game.selectedFood < minFood) game.selectedFood = minFood;
			draw();
		}
		
		private function onRight(e:MouseEvent):void
		{
			game.selectedFood++;
			if (game.selectedFood > maxFood) game.selectedFood = maxFood;
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
		}
		
		private function get currentFoodDescriptor():FoodDescriptor
		{
			return (Resources.FOOD_TYPES[game.selectedFood]);
		}
		private function get currentFoodGraphic():Class
		{
			return Resources.GRAPHICS[currentFoodDescriptor.graphic];
		}
		
	}

}