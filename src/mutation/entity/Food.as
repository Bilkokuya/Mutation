//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Food
//		A floating food object that can be consumed by the bacteria


package mutation.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.events.FoodEvent;
	import mutation.events.MutationEvent;
	import mutation.util.Util;

	//	Class: Food
	public class Food extends BaseFood 
	{	
		private const yAccel:Number = 0.07;	//	y Acceleration downwards
		
		public var isAlive:Boolean;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var isMoving:Boolean;
		public var life:Number;
		
		//	Constructor: default
		public function Food(x:Number, y:Number, base:BaseFood)
		{
			super(base.radius, base.colour, base.foodAmount, base.debrisType, base.debrisCount);
			
			this.x = x;
			this.y = y;
			xSpeed = 0;
			ySpeed = 0;
			life = 5 * 30;
			isAlive = true;
			isMoving = true;

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
			life--;
			if(isMoving){
				ySpeed += yAccel;
				x += xSpeed;
				y += ySpeed;
			}
			
			//	force it to fade out before dying
			if (life < 30){
				this.alpha = life / 30;
				if (life < 0) {
					kill();
				}
			}
			
		}
		
		//	Kills this peice of food from the game
		public function kill():void
		{
			if (isAlive){
				isAlive = false;
				stage.removeEventListener(MutationEvent.TICK, onTick);
				stage.dispatchEvent(new FoodEvent(FoodEvent.FDEATH, this));
			}
		}
		
		//	Draw the graphics representation
		private function draw():void {
			graphics.beginFill(colour);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
	
		
	}

}