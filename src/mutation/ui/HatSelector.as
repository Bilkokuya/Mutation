package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.hats.Hat;
	import mutation.entity.hats.HatDescriptor;
	import mutation.Game;
	import mx.core.SpriteAsset;

	//	Very temporary - don't think twice before refactoring this into something more generic
	public class HatSelector extends Sprite
	{		
		private var selectedHat:Number = 0;
		private var leftArrow:Sprite;
		private var rightArrow:Sprite;
		private var hat:Hat;
		
		public function HatSelector() 
		{
			super();
			leftArrow = new Sprite();
			rightArrow = new Sprite();
			hat = new Hat(Game.hats[selectedHat]);
			
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function getHatDescriptor():HatDescriptor
		{
			return Game.hats[selectedHat];
		}
		
		private function onInit(e:Event = null):void
		{
			addChild(leftArrow);
			addChild(rightArrow);
			addChild(hat);
			draw();
			drawHat();
			
			leftArrow.addEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.addEventListener(MouseEvent.CLICK, onRight);
		}
		
		private function draw():void
		{
			leftArrow.graphics.beginFill(0xFF0000);
			leftArrow.graphics.drawRect(0, -20, 20, 40);
			leftArrow.graphics.endFill();
			
			rightArrow.graphics.beginFill(0xFFFF00);
			rightArrow.graphics.drawRect(100, -20, 20, 40);
			rightArrow.graphics.endFill();
		}
		
		private function onLeft(e:MouseEvent):void
		{
			selectedHat--;
			if (selectedHat < 0) {
				selectedHat = Game.hats.length-1;
			}
			drawHat();
		}
		
		private function onRight(e:MouseEvent):void
		{
			selectedHat++;
			if (selectedHat > (Game.hats.length - 1)) {
				selectedHat = 0;
			}
			drawHat();
		}
		
		private function drawHat():void
		{
			removeChild(hat);
			hat = new Hat(Game.hats[selectedHat]);
			addChild(hat);
			hat.x = 50;
			hat.scaleX = 3;
			hat.scaleY = 3;
		}
	}

}