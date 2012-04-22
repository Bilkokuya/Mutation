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
	import mutation.util.Keys;
	import mutation.util.Util;

	//	Class: TestTube extends Sprite
	//	Represents a single TestTube of bacteria
	public class TestTube extends Sprite
	{
		private var bacterias:Array;	//	Array of Bacteria
		private var foods:Array;		//	Array of Food
		private var items:Array;
		private var radius:int;			//	Radius of movement for the testtube
		
		private var flagIsClicked:Boolean = false;
		
		//	Constructor: default
		public function TestTube(x:Number = 200, y:Number = 200, radius:int = 50) {
			this.x = x;
			this.y = y;
			this.radius = radius;

			bacterias = new Array();
			foods = new Array();
			items = new Array();
			
			//	Temporay set up the bacteria to test
			for (var i:int = 0; i < 5; i++) {
				var xSpeed:Number = (Math.random() - 0.5) * 5;
				var ySpeed:Number = (Math.random() - 0.5) * 5;
				var b:Bacteria = new Bacteria(0, 0, xSpeed, ySpeed, 8);
				bacterias.push(b);
				addChild(b);
			}
			
			//	Temporary draw the circle
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
			addEventListener(BacteriaEvent.PRODUCE, onBacteriaProduce);
		}
		
		
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void {
			updateItems();
			updateFood();
			updateBacteria();
			
			if (flagIsClicked) spawnFood();
			flagIsClicked = false;
		}

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
		
		private function onBacteriaProduce(e:BacteriaEvent):void
		{
			var item:Item = new Item(e.bacteria.x, e.bacteria.y);
			items.push(item);
			addChild(item);
		}
		//	Feeds the bacteria when the testTube is clicked on
		private function onClick(e:MouseEvent):void {
			
			flagIsClicked = true;
		}
		
		private function spawnFood():void
		{
			//	Add a new peice of food
			// 		Ensure it is in radius of the testTube
			if (Util.inRadius(mouseX, mouseY, radius)) {
				//if (Main.money >= 10){
					var food:Food = new Food(mouseX, mouseY, Foods.getFood());
					foods.push(food);
					addChild(food);
					Main.money -= 10;
			//	}
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
		}
		
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