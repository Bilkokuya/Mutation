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
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import mutation.events.BacteriaEvent;
	import mutation.events.MutationEvent;
	import mutation.ui.BacteriaDisplay;
	import mutation.util.Util;
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{
		private const SPEED:Number = 1;
		private const HUNGRY_SPEED:Number = 3;
		private const HUNGER_RATE:Number = 0.05;
		private const DIRECTION_RATE:Number = 1 / 30;
		private const HUNGER_LEVEL:Number = 95;
		
		public var radius:Number;
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		public var food:Number;			//	Currently food level for this bacteria
		public var isHungry:Boolean;
		public var isAlive:Boolean;
		public var target:Sprite;
		
		private var canMove:Boolean;
		private var popOut:BacteriaDisplay;
		
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
			isAlive = true;
			isHungry = false;
			target = null;
			canMove = true;
			
			popOut = new BacteriaDisplay(radius,0,100,50,20,20);
			
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
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent):void {
			if (!isAlive) return;
			
			food -= HUNGER_RATE;
			processHunger();
			
			if (isHungry && (target != null)) {
				chaseTheTarget();
			}else {
				moveAround();
			}
			
			popOut.update("Basic Bacteria", food, isHungry);
			
			//	Update position
			if (canMove){
				x += xSpeed;
				y += ySpeed;
			}
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			popOut.show();
			addChild(popOut);
			canMove = false;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			popOut.hide();
			removeChild(popOut);
			canMove = true;
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
				isAlive = false;
				stage.removeEventListener(MutationEvent.TICK, onTick);
				stage.dispatchEvent(new BacteriaEvent(BacteriaEvent.DEATH, this));
			}
		}
		
		public function chaseTheTarget():void
		{
			var radians:Number = Util.angleTo(x, y, target.x, target.y);
			moveAt(radians,HUNGRY_SPEED);
		}
		
		private function moveAt(radians:Number, factor:Number = 1):void
		{
			if (canMove){
				xSpeed = -1 * factor * SPEED * Math.cos(radians);
				ySpeed = -1 * factor * SPEED * Math.sin(radians);
			}
		}
		
		private function processHunger():void
		{
			if (food < HUNGER_LEVEL) isHungry = true;
			else isHungry = false;
			
			if (food < 0) kill();
		}
		
		private function moveAround():void
		{
			//	Change direction every 2 seconds (2*30 ticks), to a random diretion
			if (Math.random() < (DIRECTION_RATE)) {
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