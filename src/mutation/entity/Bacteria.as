//	Copyright 2012 Gordon D McKendrick
//	Author: Gordon D Mckendrick
//	
//	Bacteria
//		A bacteria contained in a test tube, holding various genetic informations
//		Represents a single bacteria, which can be held in a test-tube

package mutation.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import mutation.events.BacteriaEvent;
	import mutation.events.MutationEvent;
	import mutation.util.Util;
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{
		private const SPEED:Number = -1;
		
		public var radius:Number;
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		public var food:Number;			//	Currently food level for this bacteria
		private var foodOut:TextField;	//	DEBUGGING!!! Shows food level for this bacteria as a text field.
		public var itsHungry:Boolean;
		public var itsAlive:Boolean;
		public var target:Sprite;
		
		//	Constructor: (int, int, int, int)
		public function Bacteria(x:int = 0, y:int = 0, xSpeed:Number = 0, ySpeed:Number = 0, radius:Number = 5) {	
			//	Set values from parameters
			this.x = x;
			this.y = y;
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			this.radius = radius;
			
			//	Initialise basic stats
			food = 100;
			itsAlive = true;
			itsHungry = false;
			target = null;
			
			foodOut = new TextField();
			addChild(foodOut);
			
			//	Draw the graphics
			draw();

			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after stage
		public function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent):void {
			if (!itsAlive) return;
			
			//	Update food amount, ever nth frame
			food -= 0.5;
			
			processHunger();
			
			if (itsHungry && (target != null)) {
				chaseTheTarget();
			}else {
				moveAround();
			}
			
			//	Update food DEBUGGING OUTPUT !!!!!
			foodOut.text = food.toFixed(0).toString();
			
			//	Update position
			x += xSpeed;
			y += ySpeed;
		}
		
		
		//	Feeds the bacteria, limiting to 100
		//	Must be a positive number
		public function feed(amount:int = 100):void {
			if (amount < 0) return;
			
			food += amount;
			if (food > 100) {
				food = 100;
			}
		}
		
		//	Kills this bacteria, dispatching it's death event
		public function kill():void {
			if (stage) {
				itsAlive = false;
				stage.removeEventListener(MutationEvent.TICK, onTick);
				stage.dispatchEvent(new BacteriaEvent(BacteriaEvent.DEATH, this));
			}
		}
		
		public function chaseTheTarget():void
		{
			var radians:Number = Util.angleTo(x, y, target.x, target.y);
			moveAt(radians);
		}
		
		private function moveAt(radians:Number):void
		{
			xSpeed = SPEED * Math.cos(radians);
			ySpeed = SPEED * Math.sin(radians);
		}
		
		private function processHunger():void
		{
			if (food < 75) itsHungry = true;
			else itsHungry = false;
			
			if (food < 0) kill();
		}
		
		private function moveAround():void
		{
			if (Math.random() < (1 / (4 * 30))) {
				var radians:Number = ((Math.random() - 0.5) * 2 * Math.PI);
				moveAt(radians);
			}
		}
		
		//	Draws the graphics representation for this
		private function draw():void{
			graphics.clear();
			graphics.beginFill(0x0066FF);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
	}
}