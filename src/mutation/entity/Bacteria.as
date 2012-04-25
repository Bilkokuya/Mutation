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
	import mutation.entity.pathways.cConverter;
	import mutation.entity.pathways.cCreator;
	import mutation.entity.pathways.cEnzyme;
	import mutation.entity.pathways.cInhibitor;
	import mutation.entity.pathways.cPathway;
	import mutation.entity.pathways.cStorage;
	import mutation.entity.pathways.Resource;
	import mutation.events.BacteriaEvent;
	import mutation.events.MutationEvent;
	import mutation.ui.BacteriaDisplay;
	import mutation.util.Util;
	
	
	//	Class: bacteria
	public class Bacteria extends Sprite
	{
		[Embed(source = "../../../resouces/gfx/bacteria.png")]
		private var bacteriaGFX:Class;
	
		private const SPEED:Number = 1;
		private const HUNGRY_SPEED:Number = 3;
		private const HUNGER_RATE:Number = 0.05;
		private const DIRECTION_RATE:Number = 1 / 30;
		private const HUNGER_LEVEL:Number = 100;
		
		public var flagIsClicked:Boolean = false;
		public var flagIsAlive:Boolean = true;
		public var flagIsHungry:Boolean= false;
		private var canMove:Boolean;
		
		public var radius:Number;
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		
		public var bName:String = "Basic Bacteria";
		
		public var geneStability:Number = 1;
		
		public var target:Sprite;
		
		public var visual:Sprite;
		public var bitmap:Bitmap;
		public var speed:Number;
		public var animation:int;

		private var ani:int;
		private var popOut:BacteriaDisplay;
		
		public var storage:cStorage;
		public var pathway:cEnzyme;
		public var generation:int;
		
		//	Constructor: (int, int, int, int)
		public function Bacteria(x:int = 0, y:int = 0, generation:int = 0, enzyme:cEnzyme = null, store:cStorage = null, radius:Number = 5) {	
			//	Set values from parameters
			this.x = x;
			this.y = y;
			this.radius = radius;
			this.generation = generation;
			
			//	Initialise basic stats
			
			target = null;
			canMove = true;
			animation = 0;
			ani = 1;
			
			/*
			bitmap = new bacteriaGFX();
			visual = new Sprite();
			addChild(visual);
			visual.addChild(bitmap);
			bitmap.width = 2 * radius;
			bitmap.height = 2 * radius;
			bitmap.x = -bitmap.width/2;
			bitmap.y = -bitmap.height/2;
			*/
			
			graphics.beginFill(0x0066FF);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
			
			popOut = new BacteriaDisplay(radius, 0, 100, 50, 20, 20);
			
			if (store != null) {
				storage = store;
			}else {
				storage = new cStorage();
			}
			
			if (enzyme != null) {
				pathway = enzyme;
			}else{
				pathway = new cPathway([
					new cConverter(storage, cStorage.FOOD, cStorage.APS, 	5, 	2.0, 100),		//	Food to APS
					new cConverter(storage, cStorage.APS,  cStorage.PAPS, 	30, 0.9, 100),	
					new cConverter(storage, cStorage.PAPS, cStorage.MONEY,	1, 0.1, 5),		//	PAPS to Money
					new cConverter(storage, cStorage.PAPS, cStorage.LOVE, 	5, 	0.2, 1),		//	PAPS to Love
					new cConverter(storage, cStorage.PAPS, cStorage.APS,  	1, 	0.8, 10),	//	PAPS to APS
					
					new cCreator(storage, cStorage.DNA, -1, 100, false),	//	DNA damage over time
					new cInhibitor(storage, new cConverter(storage, cStorage.APS, cStorage.DNA, 1, 1, 100), cStorage.PAPS, 50, 1),	//	PAPS inhibts DNA repair
				]);
			}
			
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
			
		}
		
		//	Updates the logic of this each frame, needs to be called by it's container
		public function onTick(e:MutationEvent):void {
			processHungerState();
			
			if (storage.resources[cStorage.MONEY] > 500) {
				storage.resources[cStorage.MONEY] -= 500;
				dispatchEvent(new BacteriaEvent(BacteriaEvent.PRODUCE, this, true));
			}
			
			if (storage.resources[cStorage.LOVE] > 50) {
				storage.resources[cStorage.LOVE] -= 50;
				dispatchEvent(new BacteriaEvent(BacteriaEvent.BREED, this, true));
			}
			
			if (flagIsHungry && (target != null)) {
				chaseTheTarget();
			}else {
				moveAround();
			}
			
			if (storage.resources[cStorage.DNA] < 0) kill();
			
			if (!popOut.visible){
				if (speed > 1) {
					animation += 8*ani;
				}else {
					animation += 2*ani;
				}
				
				if (animation > 15) ani = -1;
				if (animation < 0) ani = 1;
				
				scaleY = 1 - ((animation) / 90);
			}
			
			popOut.update(storage.resources[cStorage.DNA], generation, storage.resources[cStorage.PAPS]);
			pathway.update();
			
			//	Update position
			if (canMove){
				x += xSpeed;
				y += ySpeed;
			}
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			popOut.show();
			scaleX = 1.2;
			scaleY = 1.2;
			parent.setChildIndex(this, parent.numChildren - 1);
			addChild(popOut);
			canMove = false;
		}
		
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
			
			storage.resources[cStorage.FOOD] += amount;
		}
		
		//	Kills this bacteria, dispatching it's death event
		public function kill():void {
			flagIsAlive = false;
			if (stage){
				stage.removeEventListener(MutationEvent.TICK, onTick);
				dispatchEvent(new BacteriaEvent(BacteriaEvent.DEATH, this, true));
			}
		}
		
		public function chaseTheTarget():void
		{
			var radians:Number = Util.angleTo(x, y, target.x, target.y);
			moveAt(radians,HUNGRY_SPEED);
		}
		
		private function moveAt(radians:Number, factor:Number = 1):void
		{
			xSpeed = -1 * factor * SPEED * Math.cos(radians);
			ySpeed = -1 * factor * SPEED * Math.sin(radians);
		}
		
		private function processHungerState():void
		{
			if (storage.resources[cStorage.FOOD] < HUNGER_LEVEL) flagIsHungry = true;
			else flagIsHungry = false;
		}
		
		private function moveAround():void
		{
			//	Change direction every 2 seconds (2*30 ticks), to a random diretion
			if (Math.random() < (DIRECTION_RATE)) {
				var radians:Number = ((Math.random() - 0.5) * 2 * Math.PI);
				moveAt(radians);
			}
		}
		
	}
}