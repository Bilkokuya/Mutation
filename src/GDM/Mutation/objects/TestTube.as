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
		private var tubeShadow:Shape;
		
		private var bacteria:Bacteria;	//	Output objects
		private var outFood:TextField;
		private var outProd:TextField;
		
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
			tubeShadow = new Shape();
			bacteria = new Bacteria();
			outFood = new TextField();
			outProd = new TextField();
			
			//	Setup the graphics
			initGraphics();
			
			//	Variable Initialisation
			outFood.text = bacteria.food.toString();
			outProd.text = bacteria.production.toString();

			outFood.y = -75;
			outProd.y = -50;
			
			animCount = 0;
			isAnim = false;
			originaly = tubeShape.y;
			tickCount = 0;
			
			//	Add childres
			addChild(tubeShape);
			tubeShape.addChild(tubeInner);
			addChild(tubeShadow);
			addChild(outFood);
			addChild(outProd);
			
			//	Event Listeners
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, onTick);
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
			isAnim = false;
			
		}
		
		//	Listener: onClick
		//	Adds food when it's clicked on
		private function onClick(e:MouseEvent):void
		{
			bacteria.food += 100;
		}
		
		
		//	Listener: onTick
		//	Every frame, process the actions of this TestTube
		private function onTick(e:Event):void
		{
			tickCount++;

			//	Update outputs
			outFood.text = bacteria.food.toString();
			outProd.text = bacteria.production.toString();
			bacteria.update();
			
			//	Animate the floating tube if it's to be animated
			if (!isAnim) updateAnimation();
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
			
			
			//	Tube as a Whole
			//		The shadow as a separate shape, for floating
			tubeShadow.graphics.beginFill(0x000000, 0.2);
			tubeShadow.graphics.drawEllipse( -30, -7.5, 60, 15);
			tubeShadow.graphics.endFill();
			tubeShadow.y = 155;
		}
		
		
		//	Function: updateAnimation
		//	Runs the floating animation
		private function updateAnimation():void
		{
			if ((tickCount%3) == 0)animCount++;
			if (animCount < 30) {
				tubeShape.y -= 0.1;
				tubeShadow.scaleX -= 0.001;
				tubeShadow.scaleY -= 0.001;
			}else if (animCount < 45) {
				
			}else if (animCount < 75) {
				tubeShape.y += 0.1;
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