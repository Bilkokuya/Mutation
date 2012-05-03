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
		
		private const yAccel:Number = -0.07;	//	y Acceleration downwards
		public var xSpeed:Number;
		public var ySpeed:Number;
		private var game:Game;
		
		public var life:Number;
		public var amount:Number = 0;
		
		public var type:ItemDescriptor;
		
		public var flagIsMoving:Boolean = true;
		public var flagIsClicked:Boolean = false;
		public var flagIsAlive:Boolean = true;
		
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

			draw();
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after Stage
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK, onTick);
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
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
		
		private function onClick(e:MouseEvent):void
		{
			flagIsClicked = true;
		}
		
		//	Kills this peice of food from the game
		public function kill():void
		{
			flagIsAlive = false;
			flagIsMoving = false;
			if (stage) {
				stage.removeEventListener(MutationEvent.TICK, onTick);
				removeEventListener(MouseEvent.CLICK, onClick);
				dispatchEvent(new ItemEvent(ItemEvent.DEATH, this, true));
			}
		}
		
		//	Draw the graphics representation
		private function draw():void {
			graphics.beginFill(0xFFAA33);
			graphics.drawCircle(0, 0, type.radius * ((type.money + amount)/type.money));
			graphics.endFill();
		}
		
	}

}