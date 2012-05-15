package mutation.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
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
		private var backing:Sprite;
		private var buttonBacking:Bitmap;
		private var statsOut:TextField;
		
		public function HatSelector(game:Game) 
		{
			this.game = game;
			
			backing = new Sprite();
			buttonBacking = new Resources.GFX_UI_BUTTON_BASE;
			leftArrow = new Arrow(Arrow.LEFT);
			rightArrow = new Arrow(Arrow.RIGHT);
			
			hat = new Hat( game, game.hats.getAt(selectedHat) as HatDescriptor );
			statsOut = new TextField();
			statsOut.defaultTextFormat = new TextFormat("Century Gothic", 12, 0xFFFFFF, true);
			statsOut.autoSize = TextFieldAutoSize.LEFT;
			statsOut.multiline = true;
			statsOut.selectable = false;
			statsOut.x = 5;
			statsOut.y = 92;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addChild(backing);
			addChild(buttonBacking);
			addChild(leftArrow);
			addChild(rightArrow);
			addChild(hat);
			addChild(statsOut);
			
			leftArrow.x = 40;
			leftArrow.y = 0;
			rightArrow.x = 90;
			rightArrow.y = 0;
			
			backing.x = 0;
			backing.y = 95;
			draw();
			
			leftArrow.addEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.addEventListener(MouseEvent.CLICK, onRight);
			stage.addEventListener(UnlockEvent.HAT, onUnlock);
		}
		
		public function kill():void
		{
			leftArrow.removeEventListener(MouseEvent.CLICK, onLeft);
			rightArrow.removeEventListener(MouseEvent.CLICK, onRight);
			if (stage){
				stage.removeEventListener(UnlockEvent.HAT, onUnlock);
			}
		}
		
		//	Redraws the bitmap to show the next hat
		private function draw():void
		{
			removeChild(hat);
			hat = new Hat( game, getHatDescriptor() );
			addChild(hat);
			hat.x = 65;
			hat.y = 50;
			buttonBacking.x  = 25;
			buttonBacking.y = 0;
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
			
			backing.graphics.beginFill(0x838383);
			backing.graphics.drawRect(1, 1, 140, 80);
			backing.graphics.endFill();
			backing.graphics.beginFill(0x97b9f3);
			backing.graphics.drawRect(0, 0, 140, 80);
			backing.graphics.endFill();
			
			var fScale:int 		= (1 - hat.type.foodRateScale) * 100;
			var mScale:int 		= (hat.type.moneyRateScale - 1) * 100;
			var faScale:int		= (hat.type.foodAmountScale - 1) * 100;
			var maScale:int	= (hat.type.moneyAmountScale - 1) * 100;
			statsOut.text = 	"\t Hat Bonuses \n" +
											"Hunger:   \t" + fScale + " % \n" +
											"Appetite:  \t" + faScale + " % \n" +
											"Prod. Rate:\t" + mScale + " % \n" +
											"Prod. Size:\t" + maScale + " % \n";
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