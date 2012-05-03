package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.hats.Hat;
	import mutation.entity.hats.HatDescriptor;
	import mutation.Game;
	import mutation.util.Resources;
	import mx.core.SpriteAsset;

	//	Very temporary - don't think twice before refactoring this into something more generic
	public class HatSelector extends Sprite
	{		
		private var selectedHat:Number = 0;
		private var leftArrow:Sprite;
		private var rightArrow:Sprite;
		private var hat:Hat;
		private var game:Game;
		
		public function HatSelector(game:Game) 
		{
			this.game = game;
			
			leftArrow = new Arrow(Arrow.LEFT);
			rightArrow = new Arrow(Arrow.RIGHT);
			hat = new Hat(game, Resources.HAT_TYPES[selectedHat]);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		public function getHatDescriptor():HatDescriptor
		{
			return Resources.HAT_TYPES[selectedHat];
		}
		
		private function onInit(e:Event = null):void
		{
			addChild(leftArrow);
			addChild(rightArrow);
			addChild(hat);
			
			leftArrow.x = 10;
			rightArrow.x = 100;
			
			draw();
			
			leftArrow.addEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.addEventListener(MouseEvent.CLICK, onRight);
		}
		
		private function draw():void
		{
			removeChild(hat);
			hat = new Hat(game, Resources.HAT_TYPES[selectedHat]);
			addChild(hat);
			hat.x = 60;
			hat.scaleX = 3;
			hat.scaleY = 3;
		}
		
		private function onLeft(e:MouseEvent):void
		{
			selectedHat--;
			if (selectedHat < 0) selectedHat = 0;
			draw();
		}
		
		private function onRight(e:MouseEvent):void
		{
			selectedHat++;
			if (selectedHat > (Resources.HAT_TYPES.length - 1)) selectedHat = Resources.HAT_TYPES.length - 1;
			if (!Resources.HAT_TYPES[selectedHat].isUnlocked) selectedHat--;
			draw();
		}
	}

}