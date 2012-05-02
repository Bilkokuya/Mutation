//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Food
//		A floating food object that can be consumed by the bacteria


package mutation.entity.foods 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.events.FoodEvent;
	import mutation.events.MutationEvent;
	import mutation.util.Util;

	//	Class: Food
	public class Food extends Sprite
	{	
		private const yAccel:Number = 0.07;	//	y Acceleration downwards
		
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var type:FoodDescriptor;
		
		public var life:Number;
		public var flagIsMoving:Boolean = true;
		public var flagIsAlive:Boolean = true;
		
		//	Constructor: default
		public function Food(x:Number, y:Number, foodType:FoodDescriptor)
		{
			super();
			
			this.x = x;
			this.y = y;
			xSpeed = 0;
			ySpeed = 0;
			life = 5 * 30;
			flagIsMoving = true;

			type = foodType;
			draw();
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK, onTick);
		}
		
		//	OnTick Updates
		private function onTick(e:MutationEvent):void {
			if(flagIsMoving){
				ySpeed += yAccel;
				x += xSpeed;
				y += ySpeed;
			}
			
			if (flagIsAlive){
				life--;
				if ( life < 0) {
					kill();
				}
			}
			
		}
		
		//	Kills this peice of food from the game
		public function kill():void
		{
			flagIsAlive = false;
			flagIsMoving = false;
			if (stage){
				stage.removeEventListener(MutationEvent.TICK, onTick);
				dispatchEvent(new FoodEvent(FoodEvent.DEATH, this, true));
			}
		}
		
		//	Draw the graphics representation
		private function draw():void {
			graphics.beginFill(0xFF6600);
			graphics.drawCircle(0, 0, type.radius);
			graphics.endFill();
		}
	
		
	}

}