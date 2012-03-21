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
	import mutation.events.MutationEvent;
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{	
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		public var food:int;			//	Currently food level for this bacteria
		private var foodOut:TextField;	//	DEBUGGING!!! Shows food level for this bacteria as a text field.
		
		
		//	Constructor: (int, int, int, int)
		public function Bacteria(x:int = 0, y:int = 0, xSpeed:Number = 0, ySpeed:Number = 0) {	
			//	Set values from parameters
			this.x = x;
			this.y = y;
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			
			//	Initialise basic stats
			food = 100;
			
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
			//	Update food amount, ever nth frame
			if ((e.tickCount % 1) == 0) food--;
			if (food < 0) kill();
			
			//	Update food DEBUGGING OUTPUT !!!!!
			foodOut.text = food.toString();
			
			//	Update position
			x += xSpeed;
			y += ySpeed;
		}
		
		
		//	Feeds the bacteria, limiting to 100
		public function feed(amount:int = 100):void {
			food += amount;
			if (food > 100) {
				food = 100;
			}
		}
		
		//	Kills this bacteria, dispatching it's death event
		public function kill():void {
			this.visible = false;
		}
		
		
		//	Draws the graphics representation for this
		private function draw():void{
			graphics.clear();
			graphics.beginFill(0x0066FF);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
	}
}