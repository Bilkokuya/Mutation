//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	TestTube (extends Sprite)
//		The TestTube that holds each type of bacteria
//		Can be given food, cleared, etc

package GDM.Mutation.objects 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import GDM.Mutation.events.MutationEvent;
	import GDM.Mutation.enums.ActionState;
	import GDM.Mutation.enums.HealthState;

	//	Class: TestTube extends Sprite
	//	Represents a single TestTube of bacteria
	public class TestTube extends Sprite
	{
		
		private var animCount:int;		//	Animation variables
		private var isAnim:Boolean;
		private var originaly:int;
		private var tickCount:int;
		
		private var tubeShape:Sprite;	//	Graphics objects
		private var tubeInner:Shape;
		private var tubeWindow:Sprite;
		private var tubeShadow:Shape;
		
		private var bacteria:Array;		//	Array of Bacteria
		private var items:Array;			//	Array of Food
		
		//	Constructor: default
		public function TestTube() 
		{
			super();
			if (stage) {
				onInit();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		//	Function: onInit (Event = null)
		//	Initialisation once the stage has been created
		private function onInit(e:Event = null):void
		{
			//	Memory Allocations
			tubeShape = new Sprite();
			tubeInner = new Shape();
			tubeWindow = new Sprite();
			tubeShadow = new Shape();
			bacteria = new Array();
			items = new Array();
			
			//	Setup the graphics
			initGraphics();
			
			//	Variable Initialisation
			animCount = 0;
			isAnim = false;
			originaly = tubeShape.y;
			tickCount = 0;
			
			tubeWindow.visible = false;
			
			//	Add childres
			addChild(tubeShape);
			addChild(tubeWindow);
			tubeShape.addChild(tubeInner);
			addChild(tubeShadow);
			
			for (var i:int = 0; i < 5; i++) {
				var b:Bacteria = new Bacteria();
				tubeWindow.addChild(b);
				bacteria.push(b);
			}
			
			//	Event Listeners
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			tubeWindow.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(MutationEvent.TICK, onTick);
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Listner: onRollOver
		//	Zooms in and shows closeup view when hovering over this
		private function onRollOver(e:MouseEvent):void
		{
			this.scaleX = 1.25;
			this.scaleY = 1.25;
			if (!isAnim) {
				originaly = tubeShape.y;
				isAnim = true;
				tubeWindow.visible = true;
			}
			
		}
		
		//	Listener: onRollOut
		//	Unzoom and stop animation when not hovering anymore
		private function onRollOut(e:MouseEvent):void
		{
			this.scaleX = 1;
			this.scaleY = 1;
			if (isAnim) {
				tubeShape.y = originaly;
				tubeShadow.scaleX =1;
				tubeShadow.scaleY =1;
				animCount = 0;
			}
			tubeWindow.visible = false;
			isAnim = false;
			
		}
		
		//	Listener: onClick
		//	Adds food when it's clicked on
		private function onClick(e:MouseEvent):void
		{
			for (var i:int = 0; i < 5; i++) {
				bacteria[i].food += 100;
			}
			var food:Food = new Food();
			food.x = e.localX;
			food.y = e.localY;
			tubeWindow.addChild(food);
			items.push(food);
		}
		
		
		//	Listener: onTick
		//	Every frame, process the actions of this TestTube
		private function onTick(e:MutationEvent):void
		{
			//	Animate the floating tube if it's to be animated
			if (isAnim) updateAnimation(e.tickCount);
			
			//	Test bacteria - bacteria collisions
			//		Test every bacteria against every other bacteria
			for each (var b:Bacteria in bacteria) {
				for each (var b2:Bacteria in bacteria) {
					var distance:int = Math.sqrt((b.x - b2.x) * (b.x - b2.x) + (b.y - b2.y) * (b.y - b2.y));
					if (distance < 5) {
						b.xSpeed *= -1;
						b.ySpeed *= -1;
						b.x -= 5;
						b.y -= 5;
						b2.xSpeed *= -1;
						b2.ySpeed *= -1;
						b2.x += 5;
						b2.y += 5;
					}
				}
			}
			
			//	Move bacteria towards food when it's present
			for each( var b:Bacteria in bacteria) {
				if (b.actionState == ActionState.IDLE) {
					var distance:int = 1000;
					for each (var f:Food in items) {
						var newDistance:int = Math.sqrt((b.x - f.x) * (b.x - f.x) + (b.y - f.y) * (b.y - f.y));
						if (newDistance < distance) {
							distance = newDistance;
							b.moveToFood(f.x, f.y);
						}
					}
				}
				if (items.length < 1) {
					b.actionState = ActionState.IDLE;
				}
			}

			
			//	Check collisions of bacteria with food they are after
			for each (var b:Bacteria in bacteria) {
				for each (var f:Food in items) {
					var distance:int = Math.sqrt((b.x - f.x) * (b.x - f.x) + (b.y - f.y) * (b.y - f.y));
					if (distance < 5) {
						b.food += 100;
						tubeWindow.removeChild(f);
						items.pop();	//	!!!! NEEDS FIXED, CURRENTLY CAUSES ISSUE WHEN MULTIPLE PEICES OF FOOD EXIST
						
					}
				}
			}
		}
		
		
		//	Function: initGraphics
		//	Initialises the graphics for this testtube
		private function initGraphics():void
		{
			//	The outer Grey Tube
			//		Draw the main rectangle body
			tubeShape.graphics.beginFill(0xCCCCCC);
			tubeShape.graphics.drawRect( -30, -135, 60, 250);
			tubeShape.graphics.endFill();
			
			//		The round base
			tubeShape.graphics.beginFill(0xCCCCCC);
			tubeShape.graphics.drawCircle( 0, 110, 30);
			tubeShape.graphics.endFill();
			
			//		The round top
			tubeShape.graphics.beginFill(0xCCCCCC);
			tubeShape.graphics.drawEllipse( -30, -142.5, 60, 15);
			tubeShape.graphics.endFill();
			
			//	The Inner Tube Colours
			//		Draw the main rectangle body
			tubeInner.graphics.beginFill(0x66CCCC);
			tubeInner.graphics.drawRect( -30, -135, 60, 250);
			tubeInner.graphics.endFill();
			
			//		The round base
			tubeInner.graphics.beginFill(0x66CCCC);
			tubeInner.graphics.drawCircle( 0, 110, 30);
			tubeInner.graphics.endFill();
			
			//		The round top
			tubeInner.graphics.beginFill(0x66CCCC);
			tubeInner.graphics.drawEllipse( -30, -142.5, 60, 15);
			tubeInner.graphics.endFill();
			tubeInner.scaleX = 0.8;
			tubeInner.scaleY = 0.97;
			
			//	Zoomed Window
			tubeWindow.graphics.beginFill(0xCCCCCC);
			tubeWindow.graphics.drawCircle(0, 0, 72);
			tubeWindow.graphics.endFill();
			
			tubeWindow.graphics.beginFill(0x66CCCC);
			tubeWindow.graphics.drawCircle(0, 0, 65);
			tubeWindow.graphics.endFill();
			tubeWindow.y = -10;
			
			//	Tube as a Whole
			//		The shadow as a separate shape, for floating
			tubeShadow.graphics.beginFill(0x000000, 0.2);
			tubeShadow.graphics.drawEllipse( -30, -7.5, 60, 15);
			tubeShadow.graphics.endFill();
			tubeShadow.y = 155;
		}
		
		
		//	Function: updateAnimation
		//	Runs the floating animation
		private function updateAnimation(tickCount:int):void
		{
			if ((tickCount%3) == 0)animCount++;
			if (animCount < 30) {
				tubeShape.y -= 0.1;
				tubeWindow.y -= 0.1;
				tubeShadow.scaleX -= 0.001;
				tubeShadow.scaleY -= 0.001;
			}else if (animCount < 45) {
				
			}else if (animCount < 75) {
				tubeShape.y += 0.1;
				tubeWindow.y += 0.1;
				tubeShadow.scaleX += 0.001;
				tubeShadow.scaleY += 0.001;
			}else if (animCount < 90) {
				
			}else {
				animCount = 0;
				tubeShape.y = originaly;
				tubeShadow.scaleX =1;
				tubeShadow.scaleY =1;
			}
		}
		
	}

}