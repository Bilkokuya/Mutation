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
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.events.BacteriaEvent;
	import mutation.events.FoodEvent;
	import mutation.Main;
	import mutation.ui.BacteriaDisplay;
	import mutation.ui.NameBacteriaDisplay;
	import mutation.ui.PopupDisplay;
	import mutation.util.Keys;
	import mutation.util.Util;

	//	Class: TestTube extends Sprite
	//	Represents a single TestTube of bacteria
	public class TestTube extends Sprite
	{
		//	TEMPORARY
		public var bacteriaCount:int = 0;
		public const MAX_BACTERIA:int = 50;
		
		private var bacterias:Array;	//	Array of Bacteria
		private var foods:Array;		//	Array of Food
		private var items:Array;
		private var radius:int;			//	Radius of movement for the testtube
		
		private var flagIsClicked:Boolean = false;
		private var popup:NameBacteriaDisplay;
		
		//	Constructor: default
		public function TestTube(x:Number = 200, y:Number = 200, radius:int = 50) {
			this.x = x;
			this.y = y;
			this.radius = radius;

			bacterias = new Array();
			foods = new Array();
			items = new Array();
			popup = new NameBacteriaDisplay(-3*radius/4, 0);
			
			addChild(popup);
			
			draw();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		 

		//	Initialisation once the stage has been created
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MutationEvent.TICK, onTick);
			
			addEventListener(FoodEvent.DEATH, onFoodDeath);
			addEventListener(BacteriaEvent.DEATH, onBacteriaDeath);
			addEventListener(ItemEvent.DEATH, onItemDeath);
			addEventListener(ItemEvent.PRODUCE, onBacteriaProduce);
			addEventListener(BacteriaEvent.BREED, onBacteriaBreed);
			popup.addEventListener(BacteriaEvent.COMPLETE, onBacteriaNamed);
			
			popup.display(new Bacteria(0,0,5));
			Main.isPaused = true;
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void {
			updateItems();
			updateFood();
			updateBacteria();
			
			if (flagIsClicked) spawnFood(mouseX, mouseY);
			
			flagIsClicked = false;
		}

		//	Updates all the items in the testtube
		private function updateItems():void
		{
			for each (var i:Item in items) {
				if ( !(Util.inRadius(i.x, i.y, radius)) ){
					i.ySpeed *= -0.5;
					i.xSpeed *= -0.5;
					//	Abuse the inRadius function to check if the combined speed is in range 0->1
					if (Util.inRadius(i.xSpeed, i.ySpeed, 1)) i.flagIsMoving = false;
				}
				
				if (i.flagIsClicked) {
					this.flagIsClicked = false;
					Main.money += i.money;
					i.kill();
				}
				i.flagIsClicked = false;
			}
		}
		
		//	Updates all the food in the testtube
		private function updateFood():void
		{
			for each (var f:Food in foods) {
				if ( !(Util.inRadius(f.x, f.y, radius)) ){
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
							if (Util.inRadius(b.x, b.y, (b.radius + f.radius), f.x, f.y)) {
								b.feed(f.foodAmount);
								f.kill();
								b.target = null;
							}
					}
					b.target = closestFood;
				}
			}
		}
		
		private function onBacteriaNamed(e:BacteriaEvent):void
		{
			popup.hide();
			Main.isPaused = false;
			addEventListener(MouseEvent.CLICK, onClick);
			spawnBacteria(e.bacteria);
		}
		
		//	Called when a bacteria produces something
		private function onBacteriaProduce(e:ItemEvent):void
		{
			items.push(e.item);
			addChild(e.item);
		}
		
		//	Bacteria created/ mutated function
		private function onBacteriaBreed(e:BacteriaEvent):void
		{
			addChildAt(popup, numChildren - 1);
			popup.display(new Bacteria(e.bacteria.x, e.bacteria.y,e.bacteria.radius));
			Main.isPaused = true;
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function spawnBacteria(bacteria:Bacteria):void
		{
			if (bacteriaCount > MAX_BACTERIA) return;
			bacteriaCount++;
			
			bacterias.push(bacteria);
			addChild(bacteria);
		}
		
		//	Feeds the bacteria when the testTube is clicked on
		private function onClick(e:MouseEvent):void
		{			
			flagIsClicked = true;
		}
		
		//	Spawns a new item of food at the specified position
		private function spawnFood(x:Number, y:Number, cost:int = 10):void
		{
			//	Add a new peice of food
			// 		Ensure it is in radius of the testTube
			if (Util.inRadius(x, y, radius)) {
				if (Main.money >= cost){
					var food:Food = new Food(x, y, Foods.getFood());
					foods.push(food);
					addChild(food);
					Main.money -= cost;
				}
			}
		}
		
		//	Called whenever a piece of food dies
		private function onFoodDeath(e:FoodEvent):void
		{
			removeChild(e.food);
			foods.splice(foods.indexOf(e.food), 1);
			
			if (e.food.debrisType) {
				for (var i:int = 0; i < e.food.debrisCount; ++i) {
					var debris:Food = new Food(e.food.x, e.food.y, e.food.debrisType);
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