//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	TestTube (extends Sprite)
//		The TestTube that holds each type of bacteria
//		Can be given food, cleared, etc

package mutation.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import mutation.events.MutationEvent;
	import mutation.events.BacteriaEvent;
	import mutation.events.FoodEvent;
	import mutation.util.Keys;
	import mutation.util.Util;

	//	Class: TestTube extends Sprite
	//	Represents a single TestTube of bacteria
	public class TestTube extends Sprite
	{
		private var bacterias:Array;	//	Array of Bacteria
		private var foods:Array;		//	Array of Food
		private var radius:int;			//	Radius of movement for the testtube
		
		//	Constructor: default
		public function TestTube(x:Number = 200, y:Number = 200, radius:int = 50) {
			this.x = x;
			this.y = y;
			this.radius = radius;
			
			bacterias = new Array();
			foods = new Array();
			
			//	Set up the 5 bacteria in this tube
			//	Remove this in future when extending the test tube to being a generic container
			//		i.e. once the "buying" bacteria functionality is added
			for (var i:int = 0; i < 5; i++) {
				var xSpeed:Number = (Math.random() - 0.5) * 5;
				var ySpeed:Number = (Math.random() - 0.5) * 5;
				var b:Bacteria = new Bacteria(0, 0, xSpeed, ySpeed);
				bacterias.push(b);
				addChild(b);
			}
			
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
			stage.addEventListener(BacteriaEvent.DEATH, onBacteriaDeath); 
			stage.addEventListener(FoodEvent.FDEATH, onFoodDeath);	
		}
		
		
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void {
			testBoundaries();
			testCollisions();
			
			if (Keys.isDown(Keys.Q)) {
				Foods.nextFood();
			}else if (Keys.isDown(Keys.E)) {
				Foods.lastFood();
			}
		}

	
		//	Checks that all bacteria are in the boundary of the test tube
		private function testBoundaries():void {
			//	Ensure each bacteria is within the limits of the testtube radius
			for each (var b:Bacteria in bacterias) {
				if ( !(Util.inRadius(b.x, b.y, radius)) ){
					b.xSpeed *= -1;
					b.ySpeed *= -1;
				}
			}
			for each (var f:Food in foods) {
				if ( !(Util.inRadius(f.x, f.y, radius)) ){
					f.ySpeed *= -0.5;
					f.xSpeed *= -0.5;
					//	Abuse the inRadius function to check if the combined speed is in range 0->1
					if (Util.inRadius(f.xSpeed, f.ySpeed, 1)) f.isMoving = false;
				}
			}
		}
		
		//	Checks collisions between the Bacteria, and between the food
		private function testCollisions():void
		{
			for each (var b:Bacteria in bacterias) {
				if (!b.isAlive) continue;
				// check each bacteria against other bacteria
				for each (var b2:Bacteria in bacterias) {
					//	if it hits, knock them back in opposite directions and put space between them
				}
				
				if (b.isHungry) {
					var closestDistance:Number = 0;
					var closestFood:Food = null;
					// check each bacteria against the food
					for each (var f:Food in foods) {
						if (!f.isAlive) continue;
						
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
		
		//	Feeds the bacteria when the testTube is clicked on
		private function onClick(e:MouseEvent):void {
			
			//	Add a new peice of food
			// 		Ensure it is in radius of the testTube
			if (Util.inRadius(mouseX, mouseY, radius)) {
				var food:Food = new Food(mouseX, mouseY, Foods.getFood());
				foods.push(food);
				addChild(food);
			}
		}
		
		//	Called whenever a piece of food dies
		private function onFoodDeath(e:FoodEvent):void
		{
			//	Terrible temporary method of removing an element from the array
			if (Util.removeFrom(foods, e.food)){
				removeChild(e.food);
				
				if (e.food.debrisType) {
					trace("not null debris");
					for (var i:int = 0; i < e.food.debrisCount; ++i) {
						var food:Food = new Food(e.food.x, e.food.y, e.food.debrisType);
						food.xSpeed = e.food.xSpeed - (Math.random() - 0.5);
						food.ySpeed = e.food.ySpeed - 3*(Math.random());
						foods.push(food);
						addChild(food);
					}
				}
			}
			
		}
		
		//	Called whenever a bacteria dies
		private function onBacteriaDeath(e:BacteriaEvent):void
		{
			//	Terrible temporary method of removing an element from the array
			if (Util.removeFrom(bacterias, e.bacteria)){
				removeChild(e.bacteria);
			}
		}
		
		//	Draws the graphics of the testTube
		private function draw():void {
			graphics.beginFill(0xFF6600, 0.5);
			graphics.drawCircle(0, 0, radius+10);
			graphics.endFill();
		}
		
	}

}