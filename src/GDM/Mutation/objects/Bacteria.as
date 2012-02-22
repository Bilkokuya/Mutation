//	Copyright 2012 Gordon D McKendrick
//	Author: Gordon D Mckendrick
//	
//	Bacteria
//		A bacteria contained in a test tube, holding various genetic informations
//		Represents a single bacteria, which can be held in a test-tube

package GDM.Mutation.objects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import GDM.Mutation.events.ButtonEvent;
	import GDM.Mutation.events.MutationEvent;
	import GDM.Mutation.enums.ActionState;
	import GDM.Mutation.enums.HealthState;
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{		
		public var food:Number;			//	Currently food level for this colony
		public var production:int;		//	Percent towards next production
		private var xDest:Number;		//	x position to move towards
		private var yDest:Number;		//	y position to move towards
		public var healthState:HealthState;
		public var actionState:ActionState;
		
		private var timeOffset:int;
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		//	Constructor: default
		public function Bacteria() 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Function: onInit
		//	Initialises this bacteria once added to the stage correctly
		public function onInit(e:Event = null):void
		{
			food = 100;
			production = 0;
			
			healthState = HealthState.HAPPY;
			actionState = ActionState.IDLE;
			timeOffset = Math.random() * 20;
			
			draw();
			xSpeed = (Math.random() - 0.5) * 5;
			ySpeed = (Math.random() - 0.5) * 5;
			x = (Math.random() - 0.5) * 50;
			y = (Math.random() - 0.5) * 50;
			
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		//	Function: update
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent = null):void
		{
			//	Process the food etc (move to FSM)
			if (e.tickCount%5 == 0){
				if (food > 75) {
					production += 2;
					food--;
				}else if ( food > 50) {
					production++;
					food--;
				}else if (food < 0) {
					kill();
				}else {
					food--;
				}
				
				if (food > 100) food = 100;
				
				updateColour();
			}
			
			//	Set a new random movement destination
			if ((actionState == ActionState.IDLE) && (e.tickCount%(60+timeOffset) == 0)) {
				xDest = (Math.random() - 0.5) * 110;
				yDest = (Math.random() - 0.5) * 110;
				xSpeed = (xDest - x) / 30;
				ySpeed = (yDest - y) / 30;
			}
			
			x += xSpeed;
			y += ySpeed;
		}
		
		//	Function: moveToFood
		//	Sets movement towards a food source
		public function moveToFood(xDest:Number, yDest:Number):void
		{
			actionState = ActionState.MOVING_TO_FOOD;
			this.xDest = xDest;
			this.yDest = yDest;
			xSpeed = (xDest - x) / 30;
			ySpeed = (yDest - y) / 30;
		}
		
		//	Function: draw
		//	Clears and draws the graphics of this sprite
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x0066FF, 0.3);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
		
		//	Function: updateColour
		//	Colour transforms based on the current food level - becoming red as food decreases
		private function updateColour():void
		{
			var factor:Number = food * 5;
			if ( factor > 100) factor = 100;
			factor = factor / 100;
			
			this.transform.colorTransform = new ColorTransform(1, factor, factor, 1, 0xFF*(1-factor) );
		}
		
		
		//	Function: kill
		//	Kills this bacteria, dispatching it's death event
		public function kill():void
		{
			this.visible = false;
		}
		
		//	Function: processState
		//	Works out the Bacteria's new state based on food etc
		private function processState():void
		{
			if (food > 50) {
				healthState = HealthState.HAPPY;
			}else if (food > 20) {
				healthState = HealthState.HUNGRY;
			}else {
				healthState = HealthState.DYING;
			}
		}
	}
}