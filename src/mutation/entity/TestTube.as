//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	TestTube (extends Sprite)
//		The TestTube that holds each type of bacteria
//		Can be given food, cleared, etc

package mutation.entity 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import mutation.entity.items.Item;
	import mutation.entity.foods.Food;
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.events.BacteriaEvent;
	import mutation.events.FoodEvent;
	import mutation.Game;
	import mutation.Main;
	import mutation.ui.BacteriaDisplay;
	import mutation.ui.NameBacteriaDisplay;
	import mutation.ui.PopupDisplay;
	import mutation.util.Keys;
	import mutation.util.Resources;
	import mutation.util.Util;

	//	Class: TestTube extends Sprite
	//	Represents a single TestTube of bacteria
	public class TestTube extends Sprite
	{
		//	TEMPORARY
		public var bacteriaCount:int = 0;
		public const MAX_BACTERIA:int = 50;
		private const ITEM_CLICK_RANGE:int = 50;
		
		private var bacterias:Array;	//	Array of Bacteria
		private var foods:Array;		//	Array of Food
		private var items:Array;
		private var radius:int;			//	Radius of movement for the testtube
		
		private var flagIsClicked:Boolean = false;
		private var game:Game;
		private var selector:Sprite;
		private var closestItem:Item = null;
		private var closestRange:Number = ITEM_CLICK_RANGE;
		
		//	Constructor: default
		public function TestTube(game:Game, x:Number = 200, y:Number = 200, radius:int = 50) {
			this.game = game;
			
			this.x = x;
			this.y = y;
			this.radius = radius;
			closestItem = null;
			

			bacterias = new Array();
			foods = new Array();
			items = new Array();
			selector = new Sprite();
			
			draw();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		//	Initialisation once the stage has been created
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MutationEvent.TICK, onTick);
			
			addChild(selector);
			
			addEventListener(FoodEvent.DEATH, onFoodDeath);
			addEventListener(BacteriaEvent.DEATH, onBacteriaDeath);
			addEventListener(ItemEvent.DEATH, onItemDeath);
			addEventListener(ItemEvent.PRODUCE, onBacteriaProduce);
		}
		
		
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void {
			updateItems();
			updateFood();
			updateBacteria();
		}

		//	Updates all the items in the testtube
		private function updateItems():void
		{
			//	Get closest clickable item
			closestRange = ITEM_CLICK_RANGE;
			closestItem = null;
			
			for each (var i:Item in items) {
				if ( !(Util.inRadius(i.x, i.y, radius - i.type.radius)) ){
					i.ySpeed *= -0.5;
					i.xSpeed *= -0.5;
					//	Abuse the inRadius function to check if the combined speed is in range 0->1
					if (Util.inRadius(i.xSpeed, i.ySpeed, 0.2)) i.flagIsMoving = false;
				}
				
				//	Get the closest selected item
				var distance:Number = Math.sqrt(Math.pow(i.x - mouseX, 2) + Math.pow(i.y - mouseY, 2));
				if (distance < closestRange) {
					closestItem = i;
					closestRange = distance;
				}
			}
			
			selector.graphics.clear();
			if (closestItem) {
				selector.graphics.lineStyle(10, 0xFF6600,0.2);
				selector.graphics.moveTo(mouseX, mouseY);
				selector.graphics.lineTo(closestItem.x, closestItem.y);
			}
		}
		
		//	Updates all the food in the testtube
		private function updateFood():void
		{
			for each (var f:Food in foods) {
				if ( !(Util.inRadius(f.x, f.y, radius - f.type.radius)) ){
					f.ySpeed *= -0.5;
					f.xSpeed *= -0.5;
					//	Abuse the inRadius function to check if the combined speed is in range 0->1
					if (Util.inRadius(f.xSpeed, f.ySpeed, 1)) f.flagIsMoving = false;
				}
			}
		}
		
		//	Updates all bacteria in the testtube
		private function updateBacteria():void
		{
			for each (var b:Bacteria in bacterias) {	
				
				if (Main.isPaused) return;
				
				if ( !(Util.inRadius(b.x, b.y, radius)) ){
					b.xSpeed *= -1;
					b.ySpeed *= -1;
				}
				
				if (b.flagIsHungry) {
					var closestDistance:Number = 0;
					var closestFood:Food = null;
					// check each bacteria against the food
					for each (var f:Food in foods) {
						if (!f.flagIsAlive) continue;
						
							var distance:Number = Util.getDistanceSquared(b.x, b.y, f.x, f.y);
							if ((distance < closestDistance) || (!closestFood)) {
								closestDistance = distance;
								closestFood = f;
							}
							
							//	if it hits, the bacteria eats the food, which is removed
							if (Util.inRadius(b.x, b.y, (b.radius + f.type.radius), f.x, f.y)) {
								b.feed(f.type.foodAmount);
								f.kill();
								b.target = null;
							}
					}
					b.target = closestFood;
				}
			}
		}

		//	Called when a bacteria produces something
		private function onBacteriaProduce(e:ItemEvent):void
		{
			items.push(e.item);
			addChild(e.item);
		}
		
		public function spawnBacteria(bacteria:Bacteria):void
		{
			if (bacteriaCount > MAX_BACTERIA) return;
			bacteriaCount++;
			
			bacterias.push(bacteria);
			addChild(bacteria);
		}
		
		//	Feeds the bacteria when the testTube is clicked on
		private function onClick(e:MouseEvent):void
		{	
			if (Main.isPaused) return;
			if (Util.inRadius(mouseX, mouseY, radius)) {
				//	If an item was clicked - collect it
				if (closestItem) {
					selector.graphics.clear();
					game.collect(closestItem.getMoney());
					closestItem.kill();
				//	Otherwise it was the test-tube, so spawn food
				}else {
					spawnFood(mouseX, mouseY)
				}
			}
		}
		
		//	Spawns a new item of food at the specified position
		private function spawnFood(x:Number, y:Number, cost:int = 10):void
		{
			//	Add a new peice of food
			// 		Ensure it is in radius of the testTube
			if (Util.inRadius(x, y, radius)) {
				if (game.money >= cost){
					var food:Food = new Food(game, x, y, Resources.FOOD_TYPES[game.selectedFood]);
					foods.push(food);
					addChild(food);
					game.money -= cost;
				}
			}
		}
		
		//	Called whenever a piece of food dies
		private function onFoodDeath(e:FoodEvent):void
		{
			removeChild(e.food);
			foods.splice(foods.indexOf(e.food), 1);
			
			if (e.food.type.debrisType > -1) {
				for (var i:int = 0; i < e.food.type.debrisCount; ++i) {
					var debris:Food = new Food(game, e.food.x, e.food.y, Resources.FOOD_TYPES[e.food.type.debrisType]);
					debris.xSpeed = e.food.xSpeed - (Math.random() - 0.5);
					debris.ySpeed = e.food.ySpeed - 3*(Math.random());
					foods.push(debris);
					addChild(debris);
				}
			}
		}
		
		//	Called whenever a bacteria dies
		private function onBacteriaDeath(e:BacteriaEvent):void
		{
			removeChild(e.bacteria);
			bacterias.splice(bacterias.indexOf(e.bacteria), 1);
			bacteriaCount--;
		}
		
		//	Called when an item dies and needs removed
		private function onItemDeath(e:ItemEvent):void 
		{
			removeChild(e.item);
			items.splice(items.indexOf(e.item), 1);
		}
		
		//	Draws the graphics of the testTube
		private function draw():void {
			graphics.beginFill(0x777777, 0.5);
			graphics.drawCircle(0, 0, radius+10);
			graphics.endFill();
		}
		
	}

}