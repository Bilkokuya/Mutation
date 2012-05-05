package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mutation.events.BacteriaEvent;
	import mutation.events.ButtonEvent;
	import mutation.events.MutationEvent;

	public class IntroScreen extends Sprite
	{
		private var menu:Sprite;
		private var playButton:Button;
		
		public function IntroScreen() 
		{
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			menu = new Sprite();
			playButton = new Button(70, 50, "PLAY!");
			
			addChild(menu);
			menu.x = 175;
			menu.y = 50;
			
			menu.addChild(playButton);
			draw();
			
			playButton.addEventListener(ButtonEvent.CLICKED, onPlay);
		}
		
		public function kill():void
		{
			playButton.removeEventListener(ButtonEvent.CLICKED, onPlay);
			playButton.kill();
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x111122, 0.85);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			menu.graphics.clear();
			menu.graphics.beginFill(0xFFFFFF);
			menu.graphics.drawRect(0, 0, 150, 250);
			menu.graphics.endFill();
		}
		
		private function onPlay(e:ButtonEvent):void
		{
			if (stage){
				stage.dispatchEvent(new MutationEvent(MutationEvent.GAME) );
			}
		}
	}

}