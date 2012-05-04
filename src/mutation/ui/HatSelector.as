package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mutation.entity.hats.Hat;
	import mutation.entity.hats.HatDescriptor;
	import mutation.events.UnlockEvent;
	import mutation.Game;
	import mutation.util.Resources;
	import mx.core.SpriteAsset;

	//	Very temporary - don't think twice before refactoring this into something more generic
	public class HatSelector extends Sprite
	{		
		private var selectedHat:Number = 0;
		private var leftArrow:Arrow;
		private var rightArrow:Arrow;
		private var hat:Hat;
		private var game:Game;
		
		public function HatSelector(game:Game) 
		{
			this.game = game;
			
			leftArrow = new Arrow(Arrow.LEFT);
			rightArrow = new Arrow(Arrow.RIGHT);
			hat = new Hat( game, game.hats.getAt(selectedHat) as HatDescriptor );
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
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
			stage.addEventListener(UnlockEvent.HAT, onUnlock);
		}
		
		//	Redraws the bitmap to show the next hat
		private function draw():void
		{
			removeChild(hat);
			hat = new Hat( game, getHatDescriptor() );
			addChild(hat);
			hat.x = 60;
			hat.scaleX = 3;
			hat.scaleY = 3;
			
			if (!game.hats.hasUnlocked(selectedHat - 1)) {
				leftArrow.setUnselectable();
			}else {
				leftArrow.setSelectable();
			}
			if (!game.hats.hasUnlocked(selectedHat + 1)) {
				rightArrow.setUnselectable();
			}else {
				rightArrow.setSelectable();
			}
		}
		
		//	Gets the hatDescriptor for the current selected hat
		public function getHatDescriptor():HatDescriptor
		{
			return ( game.hats.getAt(selectedHat) as HatDescriptor );
		}
		
		private function onUnlock(e:UnlockEvent):void
		{
			draw();
		}
		
		//	Gets the next hat when the left button is clicked
		private function onLeft(e:MouseEvent):void
		{
			selectedHat--;
			if (selectedHat < 0) selectedHat = 0;
			draw();
		}
		
		//	Gets the previous hat when the right button is clicked
		private function onRight(e:MouseEvent):void
		{
			selectedHat++;
			if (!game.hats.hasUnlocked(selectedHat)) selectedHat--;
			draw();
		}
	}

}