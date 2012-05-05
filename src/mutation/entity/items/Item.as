package mutation.entity.items 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.Game;
	import mutation.Main;

	public class Item extends Sprite
	{
		private var game:Game;							//	Reference to the game it's run in
		
		private const yAccel:Number = -0.07;	//	y Acceleration downwards (effectively gravity value for this)
		public var xSpeed:Number;						//	Current speed horizontally
		public var ySpeed:Number;						//	Current speed vertically (positive is down)
		
		public var life:Number;								//	Dies when life is 0
		public var amount:Number = 0;				//	Amount of money to provide the player when clicked (in addition to the base money from 'type')
		
		public var type:ItemDescriptor;				//	Type of item this is
		
		public var flagIsMoving:Boolean = true;	//	Stops it moving when speed has decreased to a certain level
		public var flagIsAlive:Boolean = true;		//	Avoids further updates once killed (while being removed from the game)
		
		//	Constructor: default
		public function Item(game:Game, x:Number, y:Number, itemType:ItemDescriptor, money:Number = 0 )
		{
			this.game = game;
			
			type = itemType;
			this.x = x;
			this.y = y;
			xSpeed = 0;
			ySpeed = 0;
			life = type.startingLife *  30;
			this.amount = money;
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			draw();
			
			stage.addEventListener(MutationEvent.TICK_MAIN, onTick);
		}
		
		//	Returns the amount of money this will provide
		public function getMoney():Number
		{
			return (type.money + amount);
		}
		
		//	OnTick Updates
		public function onTick(e:MutationEvent):void {
			
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
			if (stage) {
				stage.removeEventListener(MutationEvent.TICK_MAIN, onTick);
				dispatchEvent(new ItemEvent(ItemEvent.DEATH, this, true));
			}
		}
		
		public function getAmount():Number
		{
			return (amount + type.money);
		}
		
		//	Draw the graphics representation
		private function draw():void {
			graphics.beginFill(0xFFAA33);
			graphics.drawCircle(0, 0, type.radius * ((type.money + amount)/type.money));
			graphics.endFill();
		}
		
	}

}