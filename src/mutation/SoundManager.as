package mutation 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import mutation.events.ButtonEvent;
	import mutation.events.ContractEvent;
	import mutation.events.FoodEvent;
	import mutation.events.ItemEvent;
	import mutation.events.MutationEvent;
	import mutation.util.Resources;

	
	public class SoundManager extends Sprite
	{
		private const DELAY_BG:int = 0;
		private const DELAY_FILLER:int = 1;
		
		private var delayLength:int = Math.random() * (60) * 30;
		private var delay:int = 0;
		private var isDelaying:Boolean = false
		private var delayType:int = 0;
		private var bgChan:SoundChannel;
		private var bgSound:Sound;
		
		public function SoundManager() 
		{
			bgChan = new SoundChannel();
			bgSound = new Resources.AUDIO_BG_MUSIC;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			bgChan = bgSound.play(3500, 0, new SoundTransform(0.6) );
			
			bgChan.addEventListener(Event.SOUND_COMPLETE, onCompleteMusic);
			
			stage.addEventListener(MutationEvent.TICK, onTick);
			stage.addEventListener(ButtonEvent.CLICKED, onButtonClick);
			stage.addEventListener(FoodEvent.FEED, onFeed);
			stage.addEventListener(ItemEvent.COLLECTED, onCollect);
			stage.addEventListener(FoodEvent.EAT, onEat);
			stage.addEventListener(ContractEvent.SHIPPED, onShip);
		}
		
		private function onTick(e:MutationEvent = null):void
		{
				if (isDelaying) {
						delay++;
						
						if (delay > delayLength) {
							delayType++;
							if (delayType > 1) {
								delayType = 0;
							}
							
							if (delayType == DELAY_BG) {
								bgSound = new Resources.AUDIO_BG_MUSIC;
								bgChan = bgSound.play(0, 0, new SoundTransform(0.5) );;
								bgChan.addEventListener(Event.SOUND_COMPLETE, onCompleteMusic);
								
							}else if (delayType == DELAY_FILLER) {
								bgSound = new Resources.AUDIO_BG_FILLER;
								bgChan = bgSound.play(0, 0, new SoundTransform(0.3) );
								bgChan.addEventListener(Event.SOUND_COMPLETE, onCompleteFiller);
							}
							isDelaying = false;
							delay = 0;
						}
				}
		}
		
		private function onCollect(e:ItemEvent):void
		{
			var sound:Sound = new Resources.AUDIO_COLLECT;
			sound.play();
		}
		
		private function onFeed(e:FoodEvent):void
		{
			var sound:Sound = new Resources.AUDIO_FEED;
			sound.play(0,0, new SoundTransform(0.25));
		}
		
		private function onEat(e:FoodEvent):void
		{
			var sound:Sound = new Resources.AUDIO_EAT;
			sound.play(0,0, new SoundTransform(0.3));
		}
		
		private function onShip(e:ContractEvent):void
		{
			var sound:Sound = new Resources.AUDIO_CASH;
			sound.play(0,0, new SoundTransform(1.2));
		}
		
		private function onButtonClick(e:ButtonEvent):void
		{
				var sound:Sound = new Resources.AUDIO_CLICK;
				sound.play(0,0, new SoundTransform(1));
		}
		
		private function onCompleteMusic(e:Event):void
		{
			isDelaying = true;
			delayLength = Math.random() * 60 * 15;
		}
		
		private function onCompleteFiller(e:Event):void
		{
			isDelaying = true;
			delayLength = Math.random() * 60 * 15;
		}
	}

}