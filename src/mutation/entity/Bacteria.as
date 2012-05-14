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
	import mutation.entity.hats.HatDescriptor;
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
	
	
	//	A single bacteria that resides in the test tubes
	public class Bacteria extends Sprite
	{
		private const DIRECTION_RATE:Number = 1 / (2 * 30);	//	Frequency it will change direction
		private const HUNGER_LEVEL:Number = 40;					//	Level of food before it becomes "hungry"
		private const HUNGRY_SPEED:Number = 2.5;					//	Factor of speed it moves at when hungry
		private const SPEED:Number = 1.5;										//	Base speed for movement
		
		private var game:Game;														//	Reference back to the game this is being run within
		
		public var flagIsAlive:Boolean = true;								//	True if it hasn't been Killed yet
		public var flagIsHungry:Boolean= false;							//	True if it is seeking food
		private var canMove:Boolean;											//	Stops it moving when the player hovers over it
		
		public var radius:Number;			//	Radius for collisions and drawing
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		
		public var nameString:String;	//	Name of this bacteria, given by the player
		public var food:Resource;			//	Food keeps it alive, and decreases over time
		public var money:Resource;		//	Produced by the bacteria; released as an "Item" when it reaches the limit
		public var moneyType:Class;	//	Type of money that it will produce

		public var target:Sprite;							//	Current object it is moving towards to eat
		private var popOut:BacteriaDisplay;	//	onHover display for showing the basic stats
		public var hat:Hat;										//	Current hat it is wearing
		
		private var lastFrame:Boolean = false; 
		private var bitmapBase:Bitmap;
		private var bitmapEyes:Bitmap;
		private var blinkStart:int =( Math.random() * 15);
		
		public var level:Leveling = new Leveling();			//	Levelling system, keeps track of it's exp etc
		
		//	Constructor: (int, int, int, int)
		public function Bacteria(game:Game, x:int = 0, y:int = 0, hat:Hat = null) {	
			
			this.game = game;
			nameString = new String();
			
			bitmapBase = new Resources.GFX_BACTERIA();
			bitmapEyes = new Resources.GFX_EYES_OPEN();
			
			this.x = x;
			this.y = y;
			this.radius = 7;
			
			bitmapEyes.width = 2* radius;
			bitmapEyes.height = 2* radius;
			bitmapEyes.x = -radius;
			bitmapEyes.y = -radius;
			
			bitmapBase.width = 2* radius;
			bitmapBase.height = 2* radius;
			bitmapBase.x = -radius;
			bitmapBase.y = -radius;
			
			target = null;
			canMove = true;
			
			popOut = new BacteriaDisplay(game,radius, 0, 100, 50, 20, 20);
			
			if (hat != null) {
				this.hat = hat;
			}else {
				this.hat = new Hat(game, game.hats.getAt(0) as HatDescriptor );
			}
			
			addChild(bitmapBase);
			addChild(bitmapEyes);
			addChild(this.hat);
			
			food = new Resource(100, -0.05*this.hat.foodRateScale, 100*this.hat.foodAmountScale);
			money = new Resource(Math.random() * 50, 0.1*this.hat.moneyRateScale, 100*this.hat.moneyAmountScale);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		//	Initialisation after stage
		public function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MutationEvent.TICK_MAIN, onTick);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			moveAround(true);
		}
		
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent):void
		{
			processHungerState();
			
			food.update();
			
			if (food.amount > 25) {
				money.update();
			}
			
			// temporary and terrible - please refactor
			//	will require change of flagIsHungry to an event. makes more sense
			if (flagIsHungry) {
				if (!lastFrame){
					removeChild(bitmapBase);
					bitmapBase = new Resources.GFX_BACTERIA_HUNGRY();
					addChildAt(bitmapBase,0);
					bitmapBase.width = 2*radius;
					bitmapBase.height = 2 * radius;
					bitmapBase.x = -radius;
					bitmapBase.y = -radius;
			
					lastFrame = flagIsHungry;
				}
			}else {
				if (lastFrame){
					removeChild(bitmapBase);
					bitmapBase = new Resources.GFX_BACTERIA();
					addChildAt(bitmapBase, 0);
					bitmapBase.width = 2*radius;
					bitmapBase.height = 2*radius;
					bitmapBase.x = -radius;
					bitmapBase.y = -radius;
					
					lastFrame = flagIsHungry;
				}
			}
			
			//	visual change when going a different direction
			if (!popOut.visible){
				if (xSpeed > 0) {
					scaleX = 1;
				}else {
					scaleX = -1;
				}
			}
			
			//	visul change when moving up or down, alters the eyes
			if (ySpeed < 0) {
				bitmapEyes.scaleY = Math.abs(bitmapEyes.scaleY);
				bitmapEyes.y= -radius-1;
			}else {
				bitmapEyes.scaleY = -1 * Math.abs(bitmapEyes.scaleY);
				bitmapEyes.y = radius + 2;
			}
			
			if (money.isFilled()) {
				dispatchEvent(new ItemEvent(ItemEvent.PRODUCE, new Item(game, x,y, Resources.ITEMS[0], money.amount), true));
				money.amount = 0;
			}
			
			//	Change to an event
			if (level.hasLevelledUp()) {
				onLevelUp();
			}
			
			if (flagIsHungry && (target != null)) {
				chaseTheTarget();
			}else {
				moveAround();
			}
			
			if (food.amount < 1) kill();
			
			popOut.update(nameString , food.amount, level.level);
			
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
			popOut.scaleX = 0.8;
			popOut.scaleY = 0.8;
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
			popOut.scaleX = 1;
			popOut.scaleY = 1;
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
				stage.removeEventListener(MutationEvent.TICK_MAIN, onTick);
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
		
		public function setHat(hat:Hat):void
		{
			removeChild(this.hat);
			this.hat = hat;
			this.hat.y = -radius + 2;
			this.hat.x = 0;
			addChild(hat);
			
			food = new Resource(100, -0.05*this.hat.foodRateScale, 100*this.hat.foodAmountScale);
			money = new Resource(0, 0.1*this.hat.moneyRateScale, 25*this.hat.moneyAmountScale);
		}
		
		public function getToken():Object
		{
			var token:Object = new Object();
			token.nameString		=	nameString;
			token.money				=	money.getToken();
			token.hat						=	hat.type.arrayListing;
			token.x							=	x;
			token.y							=	y;
			token.radius				= radius;

			return token;
		}
		
		public function buildFromToken(token:Object):void
		{
			nameString = token.nameString;
			x						=	token.x;
			y						=	token.y;
			radius			=	token.radius;
			money.buildFromToken(token.money);
			setHat(new Hat(game, game.hats.getAt(token.hat) as HatDescriptor));
		}
	}
}