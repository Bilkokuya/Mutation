package mutation.entity 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.Main;

	public class Item extends Sprite
	{
		
		private const yAccel:Number = -0.07;	//	y Acceleration downwards
		public var xSpeed:Number;
		public var ySpeed:Number;
		
		public var life:Number;
		public var radius:Number;
		public var money:Number;
		
		public var flagIsMoving:Boolean = true;
		public var flagIsClicked:Boolean = false;
		public var flagIsAlive:Boolean = true;
		
		//	Constructor: default
		public function Item(x:Number, y:Number, amount:Number = 100)
		{
			this.x = x;
			this.y = y;
			xSpeed = 0;
			ySpeed = 0;
			life = 8 * 30;
			radius =  4 * (amount/100);
			money = amount;

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
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
		
	}

}