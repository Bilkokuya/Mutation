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
		 
		
		//	Function: onInit (Event = null)
		//	Initialisation once the stage has been created
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		
		//	Listener: onTick
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void {
			//	Ensure each bacteria is within the limits of the testtube radius
			for each (var b:Bacteria in bacterias) {
				var distance:int = Math.pow(b.x, 2) + Math.pow(b.y, 2);
				if (distance > Math.pow(radius,2)) {
					b.xSpeed *= -1;
					b.ySpeed *= -1;
				}
			}
			
		}

		
		//	Feeds the bacteria when the testTube is clicked on
		private function onClick(e:MouseEvent):void {
			for (var i:int = 0; i < 5; i++) {
				bacterias[i].feed(50);
			}
			
			//	Add a new peice of food
			// 		Ensure it is in radius of the testTube
			if ((Math.pow(mouseX,2) + Math.pow(mouseY,2)) < Math.pow(radius,2)){
				var index:int = foods.push(new Food(mouseX, mouseY));
				addChild(foods[index - 1]);
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