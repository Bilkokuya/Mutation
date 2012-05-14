package mutation 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		private var volume:Number = 1;
		private var isMuted:Boolean = false;
		private var speaker:Sprite
		private var speakerBMP:Bitmap;
		
		public function SoundManager() 
		{
			bgChan = new SoundChannel();
			bgSound = new Resources.AUDIO_BG_MUSIC;
			speaker = new Sprite();
			speakerBMP = new Resources.GFX_UI_SPEAKER;
			
			speaker.x = 15;
			speaker.y = 350;
			addChild(speaker);
			speaker.addChild(speakerBMP);
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			bgChan = bgSound.play(3500, 0, new SoundTransform(0.1 * volume) );
			
			bgChan.addEventListener(Event.SOUND_COMPLETE, onCompleteMusic);
			
			stage.addEventListener(MutationEvent.TICK, onTick);
			stage.addEventListener(ButtonEvent.CLICKED, onButtonClick);
			stage.addEventListener(FoodEvent.FEED, onFeed);
			stage.addEventListener(ItemEvent.COLLECTED, onCollect);
			stage.addEventListener(FoodEvent.EAT, onEat);
			stage.addEventListener(ContractEvent.SHIPPED, onShip);
			speaker.addEventListener(MouseEvent.CLICK, onMute);
		}
		
		private function onMute(e:MouseEvent):void
		{
			if (isMuted) {
				isMuted = false;
				volume = 1;
				bgChan.soundTransform = new SoundTransform(0.1 * volume);
				speaker.removeChild(speakerBMP);
				speakerBMP = new Resources.GFX_UI_SPEAKER;
				speaker.addChild(speakerBMP);
				
			}else {
				isMuted = true;
				volume = 0;
				bgChan.soundTransform = new SoundTransform(0.1 * volume);
				speaker.removeChild(speakerBMP);
				speakerBMP = new Resources.GFX_UI_SPEAKER_MUTE;
				speaker.addChild(speakerBMP);
			}
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
								bgChan = bgSound.play(0, 0, new SoundTransform(0.2 * volume) );;
								bgChan.addEventListener(Event.SOUND_COMPLETE, onCompleteMusic);
								
							}else if (delayType == DELAY_FILLER) {
								bgSound = new Resources.AUDIO_BG_FILLER;
								bgChan = bgSound.play(0, 0, new SoundTransform(0.1 * volume) );
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
			sound.play(0,0, new SoundTransform(0.5 * volume));
		}
		
		private function onFeed(e:FoodEvent):void
		{
			var sound:Sound = new Resources.AUDIO_FEED;
			sound.play(0,0, new SoundTransform(0.25 * volume));
		}
		
		private function onEat(e:FoodEvent):void
		{
			var sound:Sound = new Resources.AUDIO_EAT;
			sound.play(0,0, new SoundTransform(0.3 * volume));
		}
		
		private function onShip(e:ContractEvent):void
		{
			var sound:Sound = new Resources.AUDIO_CASH;
			sound.play(0,0, new SoundTransform(1.2 * volume));
		}
		
		private function onButtonClick(e:ButtonEvent):void
		{
				var sound:Sound = new Resources.AUDIO_CLICK;
				sound.play(0,0, new SoundTransform(1 * volume));
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