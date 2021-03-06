//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	TestTube (extends Sprite)
//		The TestTube that holds each type of bacteria
//		Can be given food, cleared, etc

package mutation.entity 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.items.Item;
	import mutation.entity.foods.Food;
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.events.BacteriaEvent;
	import mutation.events.FoodEvent;
	import mutation.Game;
	import mutation.Main;
	import mutation.ui.BacteriaDisplay;
	import mutation.ui.PopupDisplay;
	import mutation.util.Resources;
	import mutation.util.Util;

	//	Class: TestTube extends Sprite
	//	Represents a single TestTube of bacteria
	public class TestTube extends Sprite
	{
		public const MAX_BACTERIA:int = 5;		//	Maximum number of bacteria that can be kept in one tube
		private const ITEM_CLICK_RANGE:int = 35;//	Maximum range the item selector will work at
		
						//	Reference to the current game
		public var bacteriaCount:int = 0;		//	Number of bacteria it contains
		
		private var game:Game;
		private var radius:int;						//	Radius of movement for the testtube
		
		private var bacterias:Array;			//	Array of Bacteria
		private var foods:Array;					//	Array of Food
		private var items:Array;					//	Array of Item
		
		private var selector:Sprite;			//	Item selector
		private var closestItem:Item = null;
		private var closestRange:Number = ITEM_CLICK_RANGE;
		private var selected:Boolean = false;
		private var bitmap:Bitmap;
		private var shadow:Bitmap;
		
		private var visual:Sprite;
		private var windowVisual:Sprite;
		private var anim:int = 1;
		private var animHeight:Number = 0;
		private var baseY:Number;
		
		//	Constructor: default
		public function TestTube(game:Game, x:Number = 200, y:Number = 200, radius:int = 50) {
			this.game = game;
			
			this.x = x;
			this.y = y;
			this.baseY = y;
			this.radius = radius;
			closestItem = null;
			
			shadow = new Resources.GFX_TESTTUBE_SHADOW();
			bitmap = new Resources.GFX_TESTTUBE_EMPTY();
			bitmap.x = -bitmap.width / 2;
			bitmap.y = -bitmap.height / 2 + 20;
			
			shadow.x = -shadow.width / 2;
			shadow.y = 150;
			
			windowVisual = new Sprite();
			bacterias = new Array();
			foods = new Array();
			items = new Array();
			selector = new Sprite();
			
			draw();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		//	Initialisation once the stage has been created
		private function onInit(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			addChild(shadow);
			addChild(bitmap);
			addChild(windowVisual);
			addChild(selector);
			
			windowVisual.visible = false;
			
			scaleX = 0.8;
			scaleY = 0.8;
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MutationEvent.TICK_MAIN, onTick);
			
			addEventListener(FoodEvent.DEATH, onFoodDeath);
			addEventListener(BacteriaEvent.DEATH, onBacteriaDeath);
			addEventListener(ItemEvent.DEATH, onItemDeath);
			addEventListener(ItemEvent.PRODUCE, onBacteriaProduce);
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			windowVisual.visible = true;
			scaleX = 1.5;
			scaleY = 1.5;
			y = baseY;
			parent.addChildAt(this, parent.numChildren - 1);
			selected = true;
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			windowVisual.visible = false;
			scaleX = 0.8;
			scaleY = 0.8;
			y = baseY - animHeight;
			selected = false;
		}
		
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void {
			updateItems();
			updateFood();
			updateBacteria();
			
			if ((e.tickCount % 30) == 0) {
				anim *= -1;
			}
			animHeight += (anim / 4);
			
			if (!selected){
				this.y = baseY - animHeight;
				shadow.y = 150  + animHeight;
			}
		}
		
		public function kill():void
		{
			removeEventListener(FoodEvent.DEATH, onFoodDeath);
			removeEventListener(BacteriaEvent.DEATH, onBacteriaDeath);
			removeEventListener(ItemEvent.DEATH, onItemDeath);
			removeEventListener(ItemEvent.PRODUCE, onBacteriaProduce);
			if (stage){
				stage.removeEventListener(MouseEvent.CLICK, onClick);
				stage.removeEventListener(MutationEvent.TICK_MAIN, onTick);
			}
			
			for each (var b:Bacteria in bacterias) b.kill();
			for each (var i:Item in items) i.kill();
			for each (var f:Food in foods) f.kill();
		}

		//	Updates all the items in the testtube
		private function updateItems():void
		{
			//	Get closest clickable item
			closestRange = ITEM_CLICK_RANGE;
			closestItem = null;
			
			for each (var i:Item in items) {
				if ( !(Util.inRadius(i.x, i.y, radius - i.type.radius)) ){
					i.ySpeed *= -0.5;
					i.xSpeed *= -0.5;
					//	Abuse the inRadius function to check if the combined speed is in range 0->1
					if (Util.inRadius(i.xSpeed, i.ySpeed, 0.2)) i.flagIsMoving = false;
				}
				
				//	Get the closest selected item
				var distance:Number = Math.sqrt(Math.pow(i.x - mouseX, 2) + Math.pow(i.y - mouseY, 2));
				if (distance < closestRange) {
					closestItem = i;
					closestRange = distance;
				}
			}
			
			selector.graphics.clear();
			if (closestItem) {
				selector.graphics.lineStyle(8, 0xFF6600,0.2);
				selector.graphics.moveTo(mouseX, mouseY);
				selector.graphics.lineTo(closestItem.x, closestItem.y);
			}
		}
		
		//	Updates all the food in the testtube
		private function updateFood():void
		{
			for each (var f:Food in foods) {
				if ( !(Util.inRadius(f.x, f.y, radius - f.type.radius)) ){
					f.ySpeed *= -0.5;
					f.xSpeed *= -0.5;
					//	Abuse the inRadius function to check if the combined speed is in range 0->1
					if (Util.inRadius(f.xSpeed, f.ySpeed, 1)) f.flagIsMoving = false;
				}
			}
		}
		
		//	Updates all bacteria in the testtube
		private function updateBacteria():void
		{
			for each (var b:Bacteria in bacterias) {	
				
				if (Main.isPaused) return;
				
				if ( !(Util.inRadius(b.x, b.y, radius)) ){
					b.xSpeed *= -1;
					b.ySpeed *= -1;
				}
				
				if (b.flagIsHungry) {
					var closestDistance:Number = 0;
					var closestFood:Food = null;
					// check each bacteria against the food
					for each (var f:Food in foods) {
						if (!f.flagIsAlive) continue;
						
							var distance:Number = Util.getDistanceSquared(b.x, b.y, f.x, f.y);
							if ((distance < closestDistance) || (!closestFood)) {
								closestDistance = distance;
								closestFood = f;
							}
							
							//	if it hits, the bacteria eats the food, which is removed
							if (Util.inRadius(b.x, b.y, (b.radius + f.type.radius), f.x, f.y)) {
								b.feed(f.type.foodAmount);
								f.kill();
								stage.dispatchEvent(new FoodEvent( FoodEvent.EAT, null));
								b.target = null;
							}
					}
					b.target = closestFood;
				}
			}
		}

		//	Called when a bacteria produces something
		private function onBacteriaProduce(e:ItemEvent):void
		{
			items.push(e.item);
			windowVisual.addChild(e.item);
		}
		
		public function spawnBacteria(bacteria:Bacteria):void
		{
			if (bacteriaCount == 0) {
				removeChild(bitmap);
				bitmap = new Resources.GFX_TESTTUBE();
				addChildAt(bitmap, 0);
				bitmap.x = -bitmap.width / 2;
				bitmap.y = -bitmap.height / 2 + 20;
			}
			
			if (bacteriaCount > MAX_BACTERIA) return;
			bacteriaCount++;
			
			bacterias.push(bacteria);
			windowVisual.addChild(bacteria);
		}
		
		//	Feeds the bacteria when the testTube is clicked on
		private function onClick(e:MouseEvent):void
		{	
			if (!selected) return;
			if (Main.isPaused) return;
			if (Util.inRadius(mouseX, mouseY, radius)) {
				//	If an item was clicked - collect it
				if (closestItem) {
					selector.graphics.clear();
					if (stage){
						stage.dispatchEvent(new ItemEvent(ItemEvent.COLLECTED, closestItem) );
					}
					closestItem.kill();
				//	Otherwise it was the test-tube, so spawn food
				}else {
					spawnFood(mouseX, mouseY)
				}
			}
		}
		
		//	Spawns a new item of food at the specified position
		private function spawnFood(x:Number, y:Number):void
		{
			//	Add a new peice of food
			// 		Ensure it is in radius of the testTube
			if (Util.inRadius(x, y, radius)) {
				
				var desc:FoodDescriptor =  game.foods.getAt(game.foodSelection) as FoodDescriptor;
				if (game.money >= desc.cost){
					var food:Food = new Food(game, x, y, desc);
					foods.push(food);
					windowVisual.addChild(food);
					game.money -= desc.cost;
					stage.dispatchEvent(new FoodEvent(FoodEvent.FEED, null));
				}
			}
		}
		
		//	Called whenever a piece of food dies
		private function onFoodDeath(e:FoodEvent):void
		{
			windowVisual.removeChild(e.food);
			foods.splice(foods.indexOf(e.food), 1);
			
			if (e.food.type.debrisType > -1) {
				for (var i:int = 0; i < e.food.type.debrisCount; ++i) {
					var debris:Food = new Food(game, e.food.x, e.food.y, game.foods.getAt(e.food.type.debrisType) as FoodDescriptor );
					debris.xSpeed = e.food.xSpeed - (Math.random() - 0.5);
					debris.ySpeed = e.food.ySpeed - 3*(Math.random());
					foods.push(debris);
					windowVisual.addChild(debris);
				}
			}
		}
		
		//	Called whenever a bacteria dies
		private function onBacteriaDeath(e:BacteriaEvent):void
		{
			windowVisual.removeChild(e.bacteria);
			bacterias.splice(bacterias.indexOf(e.bacteria), 1);
			bacteriaCount--;
			
			if (bacteriaCount == 0) {
				removeChild(bitmap);
				bitmap = new Resources.GFX_TESTTUBE_EMPTY();
				addChildAt(bitmap, 0);
				bitmap.x = -bitmap.width / 2;
				bitmap.y = -bitmap.height / 2 + 20;
			}
		}
		
		//	Called when an item dies and needs removed
		private function onItemDeath(e:ItemEvent):void 
		{
			windowVisual.removeChild(e.item);
			items.splice(items.indexOf(e.item), 1);
		}
		
		//	Draws the graphics of the testTube
		private function draw():void {
			
			windowVisual.graphics.beginFill(0xb0bbbc, 1);
			windowVisual.graphics.drawCircle(0, 0, radius+14);
			windowVisual.graphics.endFill();
			windowVisual.graphics.beginFill(0xa1f3ff, 1);
			windowVisual.graphics.drawCircle(0, 0, radius+10);
			windowVisual.graphics.endFill();
			
		}
		
		public function getToken():Object
		{
			var token:Object 	= new Object();
			var bacteriasTokens:Array = new Array();
			for each (var b:Bacteria in bacterias) {
				bacteriasTokens.push(b.getToken());
			}
			
			token.radius 			=	radius;
			token.bacterias 	= bacteriasTokens;
			token.count			=	bacteriaCount;
			
			return token;
		}
		
		public function buildFromToken(token:Object):void
		{
			radius = token.radius;
			
			for (var i:int = 0; i < token.count; ++i) {
				var b:Bacteria = new Bacteria(game);
				b.buildFromToken(token.bacterias[i]);
				spawnBacteria(b);
			}
			
			draw();
		}
		
	}

}