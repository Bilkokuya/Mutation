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
		private const HUNGER_LEVEL:Number = 1000;
		
		public var flagIsClicked:Boolean = false;
		public var flagIsAlive:Boolean = true;
		public var flagIsHungry:Boolean= false;
		private var canMove:Boolean;
		
		public var radius:Number;
		public var xSpeed:Number;		//	Current speed in the x Direction
		public var ySpeed:Number;		//	Current speed in the y Direction
		
		public var bName:String = "Basic Bacteria";
		
		public var production:Number = 0;
		public var productionRate:Number = 1;
		public var productionHungerLimit:Number = 50;
		public var productionNeeded:Number = 100;
		
		public var geneStability:Number = 1;
		
		public var target:Sprite;
		
		public var visual:Sprite;
		public var bitmap:Bitmap;
		public var speed:Number;
		public var animation:int;

		private var ani:int;
		private var popOut:BacteriaDisplay;
		
		//	Resources for use in the pathways etc
		/*
		public var food:Resource = new Resource(1000);
		public var aps:Resource = new Resource(1000);
		public var paps:Resource = new Resource(0);
		public var money:Resource = new Resource(0);
		public var love:Resource = new Resource(0);
		public var DNA:Resource = new Resource(1000);
		*/
		
		public var storage:cStorage;
		public var pathway:cPathway;
		
		//	Constructor: (int, int, int, int)
		public function Bacteria(x:int = 0, y:int = 0, enzyme:cPathway = null, store:cStorage = null, xSpeed:Number = 0, ySpeed:Number = 0, radius:Number = 5) {	
			//	Set values from parameters
			this.x = x;
			this.y = y;
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			this.radius = radius;
			
			//	Initialise basic stats
			
			target = null;
			canMove = true;
			animation = 0;
			ani = 1;
			production = 0;
			
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
			
			if (store) {
				this.storage = store;
			}else {
				this.storage = new cStorage();
			}
			
			if (enzyme) {
				pathway = enzyme;
			}else{
				pathway = new cPathway([
					new cConverter(storage.resources[cStorage.FOOD], storage.resources[cStorage.APS],  5, 2),		//	Food to APS
					new cConverter(storage.resources[cStorage.APS],  storage.resources[cStorage.PAPS],  30, 0.9),	
					new cConverter(storage.resources[cStorage.PAPS], storage.resources[cStorage.MONEY],1, 0.1),		//	PAPS to Money
					new cConverter(storage.resources[cStorage.PAPS], storage.resources[cStorage.LOVE], 5, 0.2),		//	PAPS to Love
					new cConverter(storage.resources[cStorage.PAPS], storage.resources[cStorage.APS],  1, 0.8),	//	PAPS to APS
					
					new cCreator(storage.resources[cStorage.DNA], -1),	//	DNA damage over time
					new cInhibitor(new cConverter(storage.resources[cStorage.APS], storage.resources[cStorage.DNA], 1, 1), storage.resources[cStorage.PAPS], 50),	//	PAPS inhibts DNA repair
				]);
			}
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function mutatedEnzyme(s:cStorage):cPathway
		{	
			var enzyme:cPathway = new cPathway([
				new cConverter(s.resources[cStorage.APS],  s.resources[cStorage.PAPS],  30, 0.9),	
				new cConverter(s.resources[cStorage.PAPS], s.resources[cStorage.MONEY],1, 0.1),		//	PAPS to Money
				new cConverter(s.resources[cStorage.PAPS], s.resources[cStorage.LOVE], 5, 0.2),		//	PAPS to Love
				new cConverter(s.resources[cStorage.PAPS], s.resources[cStorage.APS],  1, 0.8),	//	PAPS to APS
					
				new cCreator(s.resources[cStorage.DNA], -1),	//	DNA damage over time
				new cInhibitor(new cConverter(s.resources[cStorage.APS], storage.resources[cStorage.DNA], 1, 1), storage.resources[cStorage.PAPS], 50),	//	PAPS inhibts DNA repair
			]);
			
			for (var i:int = 0; i < enzyme.pathwayEnzymes.length; ++i ) {
				var mutation:Number = (storage.resources[cStorage.DNA].amount/1000) * Math.random();
				if (mutation > 0.2) continue;
				
				var e:cEnzyme = enzyme.pathwayEnzymes[i];
				var b:cEnzyme = pathway.pathwayEnzymes[i];
				
				if (e is cConverter) {
					mutation = (storage.resources[cStorage.DNA].amount/1000) * ((Math.random()-0.5)/2);
					(e as cConverter).rate = (b as cConverter).rate * mutation;
					
					mutation = (storage.resources[cStorage.DNA].amount/1000) * ((Math.random()-0.5)/2);
					(e as cConverter).efficiency = (b as cConverter).efficiency * mutation;
				
				}else if (e is cInhibitor) {
					mutation = (storage.resources[cStorage.DNA].amount/1000) * ((Math.random()-0.5)/2);
					(e as cInhibitor).cost = (b as cInhibitor).cost * mutation;
					
					
				}else if (e is cCreator) {
					mutation = (storage.resources[cStorage.DNA].amount/1000) * ((Math.random()-0.5)/2);
					(e as cCreator).rate = (b as cCreator).rate * mutation;
				}
			}
			
			return enzyme;
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
			
			if (storage.resources[cStorage.MONEY].amount > productionNeeded) {
				storage.resources[cStorage.MONEY].amount -= productionNeeded;
				dispatchEvent(new BacteriaEvent(BacteriaEvent.PRODUCE, this, true));
			}
			
			if (storage.resources[cStorage.LOVE].amount > 500) {
				storage.resources[cStorage.LOVE].amount -= 500;
				dispatchEvent(new BacteriaEvent(BacteriaEvent.BREED, this, true));
			}
			
			if (flagIsHungry && (target != null)) {
				chaseTheTarget();
			}else {
				moveAround();
			}
			
			if (storage.resources[cStorage.DNA].amount < 0) kill();
			
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
			
			popOut.update(storage.resources[cStorage.DNA].amount, storage.resources[cStorage.APS].amount, storage.resources[cStorage.PAPS].amount);
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
			
			storage.resources[cStorage.FOOD].amount += amount;
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
			if (storage.resources[cStorage.FOOD].amount < HUNGER_LEVEL) flagIsHungry = true;
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