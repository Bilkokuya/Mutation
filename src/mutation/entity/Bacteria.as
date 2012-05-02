//	Copyright 2012 Gordon D McKendrick
//	Author: Gordon D Mckendrick
//	
//	Bacteria
//		A bacteria contained in a test tube, holding various genetic informations
//		Represents a single bacteria, which can be held in a test-tube

package mutation.entity 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import mutation.entity.items.Item;
	import mutation.entity.levelling.Leveling;
	import mutation.Game;
	import mutation.util.Resources;
	
	import mutation.entity.hats.Hat;
	import mutation.entity.levelling.Level;
	import mutation.events.BacteriaEvent;
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.Main;
	import mutation.ui.BacteriaDisplay;
	import mutation.util.Util;
	
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{
		private const DIRECTION_RATE:Number = 1 / (2 * 30);
		private const HUNGRY_SPEED:Number = 2.5;
		private const HUNGER_LEVEL:Number = 80;
		private const SPEED:Number = 1.5;
		
		public var flagIsClicked:Boolean = false;
		public var flagIsAlive:Boolean = true;
		public var flagIsHungry:Boolean= false;
		private var canMove:Boolean;
		public var hat:Hat;
		
		public var radius:Number;
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		
		public var nameString:String;
		public var food:Resource;
		public var money:Resource;
		public var level:Leveling = new Leveling(Resources.getXML(Resources.XML_LEVELS));
		public var moneyType:Class;

		public var target:Sprite;
		private var popOut:BacteriaDisplay;
		
		//	Constructor: (int, int, int, int)
		public function Bacteria(x:int = 0, y:int = 0, radius:Number = 10, hat:Hat = null) {	
			//	Set values from parameters
			this.x = x;
			this.y = y;
			this.radius = radius;
			
			//	Initialise basic stats
			target = null;
			canMove = true;

			draw(0x0066FF);
			
			popOut = new BacteriaDisplay(radius, 0, 100, 50, 20, 20);
			
			if (hat != null) {
				this.hat = hat;
			}else {
				this.hat = new Hat(Game.hats[0]);
			}
			addChild(this.hat);
			
			food = new Resource(100, -0.1*this.hat.foodRateScale, 100*this.hat.foodAmountScale);
			money = new Resource(Math.random() * 50, 1*this.hat.moneyRateScale, 100*this.hat.moneyAmountScale);
			
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
			
			moveAround(true);
		}
		
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent):void {
			processHungerState();
			
			food.update();
			
			if (food.amount > 25) {
				money.update();
			}
			
			if (flagIsHungry) {
				draw(0x006611);
			}else {
				draw(0x0066FF);
			}
			
			if (money.isFilled()) {
				dispatchEvent(new ItemEvent(ItemEvent.PRODUCE, new Item(x,y, Game.items[0], money.amount), true));
				money.amount = 0;
			}
			
			if (level.hasLevelledUp()) {
				onLevelUp();
			}
			
			if (flagIsHungry && (target != null)) {
				chaseTheTarget();
			}else {
				moveAround();
			}
			
			if (food.amount < 1) kill();
			
			popOut.update(nameString ,money.amount , food.amount);
			
			//	Update position
			if (canMove){
				x += xSpeed;
				y += ySpeed;
			}
		}
		
		//	Roll-over stats display
		private function onRollOver(e:MouseEvent):void
		{
			popOut.show();
			scaleX = 1.2;
			scaleY = 1.2;
			parent.setChildIndex(this, parent.numChildren - 1);
			addChild(popOut);
			canMove = false;
		}
		
		//	Hide the stats display
		private function onRollOut(e:MouseEvent):void
		{
			popOut.hide();
			scaleX = 1;
			scaleY = 1;
			removeChild(popOut);
			canMove = true;
		}
		
		//	Feeds the bacteria, limiting to 100
		//	Must be a positive number
		public function feed(amount:Number = 100):void {
			if (amount < 0) return;
			
			food.amount += amount;
			level.update(amount);
		}
		
		//	Kills this bacteria, dispatching it's death event
		public function kill():void {
			flagIsAlive = false;
			if (stage){
				stage.removeEventListener(MutationEvent.TICK, onTick);
				dispatchEvent(new BacteriaEvent(BacteriaEvent.DEATH, this, true));
			}
		}
		
		//	Moves at the specified angle, and speed multiplier
		private function moveAt(radians:Number, factor:Number = 1):void
		{
			xSpeed = -1 * factor * SPEED * Math.cos(radians);
			ySpeed = -1 * factor * SPEED * Math.sin(radians);
		}
		
		//	Determines it if is hungry or not
		private function processHungerState():void
		{
			if (food.amount < HUNGER_LEVEL) flagIsHungry = true;
			else flagIsHungry = false;
		}
		
		//	Move towards the specified target
		private function chaseTheTarget():void
		{
			var radians:Number = Util.angleTo(x, y, target.x, target.y);
			moveAt(radians,HUNGRY_SPEED);
		}
		
		//	Moving around when there is no target
		private function moveAround(forced:Boolean = false):void
		{
			if ((Math.random() < (DIRECTION_RATE)) || (forced)) {
				var radians:Number = ((Math.random() - 0.5) * 2 * Math.PI);
				moveAt(radians);
			}
		}
		
		//	Called when the bacteria has levelled up
		private function onLevelUp():void
		{
			var l:Level = level.getLevel();
			food.scale(1, l.foodScale, 1);
			money.scale(1, l.moneyScale, l.moneyScale);
			if (l.moneyType) {
				moneyType = l.moneyType;
			}
		}
		
		//	Draws the bacteria's vector image
		private function draw(colour:Number):void
		{
			graphics.clear();
			graphics.beginFill(colour);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
		
		public function setHat(hat:Hat):void
		{
			removeChild(this.hat);
			this.hat = hat;
			this.hat.y = -radius;
			this.hat.x = 0;
			addChild(hat);
			
			food = new Resource(100, -0.1*this.hat.foodRateScale, 100*this.hat.foodAmountScale);
			money = new Resource(Math.random() * 50, 1*this.hat.moneyRateScale, 100*this.hat.moneyAmountScale);
		}
	}
}