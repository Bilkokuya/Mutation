//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	World
//		A scalable world, that contains everything scalable in the scene


package GDM.Mutation.container 
{
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import GDM.Mutation.util.Keys;
	
	import GDM.Mutation.objects.TestTube;

	//	Class: Sprite
	public class World extends Sprite
	{
		private var background:Background;
		private var testTubes:Array;	//	Array of TestTubes
		private var zoomingIn:Boolean;
		private var zoomingOut:Boolean;
		private var farX:int;
		private var farY:int;
		
		//	Constructor: default
		public function World() {
			super();
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
			
		}
		
		
		//	Function: onInit (Event = null)
		//	Initialises the object once it has a reference to the stage
		private function onInit(e:Event = null):void
		{
			testTubes = new Array();
			background = new Background();
			addChild(background);
			
			farX = -stage.stageWidth;
			farY = -stage.stageHeight;
			
			//	initialise the test tubes in the testTubes array
			for (var i:int = 0; i < 4; i++) {
				var tube:TestTube = new TestTube();
				addChild(tube);
				tube.x = farX + (stage.stageWidth/2) + 100 + i*((stage.stageWidth-100)/4);
				tube.y = farY + (stage.stageHeight/2) + 200
				testTubes.push(tube);
			}
			
			//	draw the background of this object
			draw();
			
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;

			
			//	listeners
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			addEventListener(Event.ENTER_FRAME, onTick);
		}
		
		//	Listener: onTick
		//	Runs once per frame
		public function onTick(e:Event):void
		{
			//	Moving left
			if (Keys.isDown(Keys.A)) {
				if (x < (3*stage.stageWidth/2)) {
					x += 5;
				}
			}
			//	Moving right
			if (Keys.isDown(Keys.D)){
				if (x > (-3*stage.stageWidth / 2)) {
					x -= 5;
				}
			}
		}
		
		//	Listener: onWheel
		//	When the mousewheel is moved, zoom the view
		public function onWheel(e:MouseEvent):void
		{
			if(e.delta < 0){
				setZoom(0.5);
			}else {
				setZoom(1);
			}
		}
		
		
		//	Accessor: zoom (Number)
		//	Zooms (in) by the given factor. Decimals zoom out.
		//		e.g. 2, will zoom in by twice the current amount
		public function zoom(factor:Number):void
		{
			this.scaleX *= factor;
			this.scaleY *= factor;
		}
		
		
		//	Function: setZoom (Number)
		//	Sets the zoom to the given value
		public function setZoom(amount:Number):void
		{
			this.scaleX = amount;
			this.scaleY = amount;
		}
		
		
		//	Accessor: resetZoom
		//	Resets the zoom to the original level
		public function resetZoom():void
		{
			this.scaleX = 1;
			this.scaleY = 1;
		}
		
		//	Function: draw
		//	Helper function that draws the graphics of this object.
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x000000, 0.0);
			graphics.drawRect( -stage.stageWidth, -stage.stageHeight, 2 * stage.stageWidth, 2 * stage.stageHeight);
			graphics.endFill();
		}
		
	}

}