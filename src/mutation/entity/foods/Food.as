//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Food
//		A floating food object that can be consumed by the bacteria


package mutation.entity.foods 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.events.FoodEvent;
	import mutation.events.MutationEvent;
	import mutation.Game;
	import mutation.util.Resources;
	import mutation.util.Util;

	//	Class: Food
	public class Food extends Sprite
	{	
		private const yAccel:Number = 0.07;	//	y Acceleration downwards
		
		private var game:Game;				//	Reference to the current game
		
		public var xSpeed:Number;			//	Speed horizontally
		public var ySpeed:Number;			//	Speed vertically downwards
		public var type:FoodDescriptor;	//	Type of this food
		
		public var life:Number;									//	Dies when life is 0
		public var flagIsMoving:Boolean = true;	//	Avoids movement when speed has reached a low threshhold
		public var flagIsAlive:Boolean = true;		//	Prevents updates when killed and still being removed from the game
		
		private var bitmap:Bitmap;
		
		//	Constructor: default
		public function Food(game:Game, x:Number, y:Number, foodType:FoodDescriptor)
		{
			this.game = game;
			
			super();
			type = foodType;
			this.x = x;
			this.y = y;
			xSpeed = 0;
			ySpeed = 0;
			life = type.startingLife * 30;
			flagIsMoving = true;
			
			bitmap = new (Resources.GRAPHICS_FOODS[type.graphic])();
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(bitmap);
			bitmap.width = type.radius * 2;
			bitmap.height = type.radius * 2;
			
			stage.addEventListener(MutationEvent.TICK_MAIN, onTick);
		}
		
		//	OnTick Updates
		private function onTick(e:MutationEvent):void {
			if (flagIsMoving) {
				rotation++;
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
				stage.removeEventListener(MutationEvent.TICK_MAIN, onTick);
				dispatchEvent(new FoodEvent(FoodEvent.DEATH, this, true));
			}
		}
		
	}

}