package mutation.util 
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.ByteArray;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.hats.HatDescriptor;
	import mutation.entity.items.ItemDescriptor;
	import mutation.entity.levelling.Level;
	import mutation.entity.BaseDescriptor;

	
	//	Holds all data for the game that should not be changed after loading
	//	Includes all embedded assets, as well as references to the loaded food types etc
	public class Resources 
	{
		//////////////////////////////////////////////////////
		//	GRAPHICS EMBEDDING
		///////////////////////////////////////////////////////
		[Embed(source = "../../../resources/gfx/bacteria.png")]
		public static const GFX_BACTERIA:Class;
		
		[Embed(source = "../../../resources/gfx/bacteriagold.png")]
		public static const GFX_BACTERIA_GOLD:Class;
		
		[Embed(source = "../../../resources/gfx/bacteriahungry.png")]
		public static const GFX_BACTERIA_HUNGRY:Class;
		
		[Embed(source = "../../../resources/gfx/eyes.png")]
		public static const GFX_EYES_OPEN:Class;
		
		[Embed(source = "../../../resources/gfx/eyesblinked.png")]
		public static const GFX_EYES_BLINKED:Class;
		
		
		//	HATS
		[Embed(source="../../../resources/gfx/explorerhat.png")]
		public static const GFX_HAT_EXPLORER:Class;
		
		[Embed(source="../../../resources/gfx/piratehat.png")]
		public static const GFX_HAT_PIRATE:Class;
		
		[Embed(source="../../../resources/gfx/prettyhat.png")]
		public static const GFX_HAT_PRETTY:Class;
		
		public static const GRAPHICS_HATS:Vector.<Class> = new <Class>[
			GFX_HAT_EXPLORER,
			GFX_HAT_PIRATE,
			GFX_HAT_PRETTY,
		];
		
		//	FOODS
		[Embed(source="../../../resources/gfx/nounlocks.png")]
		public static const GFX_NO_UNLOCK:Class;
		
		[Embed(source = "../../../resources/gfx/fooddebris.png")]
		public static const GFX_FOOD_DEBRIS:Class;
		
		[Embed(source = "../../../resources/gfx/food1.png")]
		public static const GFX_FOOD_SIMPLE:Class;
		
		[Embed(source = "../../../resources/gfx/foodexplosive.png")]
		public static const GFX_FOOD_EXPLOSIVE:Class;
		
		[Embed(source = "../../../resources/gfx/foodpills.png")]
		public static const GFX_FOOD_BLUEPILLS:Class;
		
		[Embed(source = "../../../resources/gfx/foodpillsred.png")]
		public static const GFX_FOOD_REDPILLS:Class;
		
		[Embed(source = "../../../resources/gfx/foodpillsyellow.png")]
		public static const GFX_FOOD_GOLDPILLS:Class;
		
		[Embed(source = "../../../resources/gfx/foodsemerald.png")]
		public static const GFX_FOOD_EMERALD:Class;
		
		[Embed(source = "../../../resources/gfx/foodruby.png")]
		public static const GFX_FOOD_RUBY:Class;
		
		[Embed(source = "../../../resources/gfx/fooddiamond.png")]
		public static const GFX_FOOD_DIAMOND:Class;
		
		public static const GRAPHICS_FOODS:Vector.<Class> = new <Class>[
			GFX_FOOD_DEBRIS,
			GFX_FOOD_SIMPLE,
			GFX_FOOD_EXPLOSIVE,
			GFX_FOOD_BLUEPILLS,
			GFX_FOOD_REDPILLS,
			GFX_FOOD_GOLDPILLS,
			GFX_FOOD_EMERALD,
			GFX_FOOD_RUBY,
			GFX_FOOD_DIAMOND
		];
		
		//	UI
		[Embed(source = "../../../resources/gfx/arrow.png")]
		public static const GFX_UI_ARROW:Class;
		
		[Embed(source="../../../resources/gfx/contractselectionbox.png")]
		public static const GFX_UI_CONTRACT_SELECTION:Class;
		
		[Embed(source="../../../resources/gfx/introscreenmenu.png")]
		public static const GFX_UI_MENU:Class;
		
		[Embed(source = "../../../resources/gfx/button_base.png")]
		public static const GFX_UI_BUTTON_BASE:Class;
		
		[Embed(source = "../../../resources/gfx/button_spawnbacteria.png")]
		public static const GFX_UI_BUTTON_BACTERIA:Class;
		
		[Embed(source = "../../../resources/gfx/button_contract.png")]
		public static const GFX_UI_BUTTON_CONTRACT:Class;
		
		[Embed(source = "../../../resources/gfx/speaker.png")]
		public static const GFX_UI_SPEAKER:Class;
		
		[Embed(source = "../../../resources/gfx/speaker_muted.png")]
		public static const GFX_UI_SPEAKER_MUTE:Class;
		
		
		public static const GRAPHICS_ITEMS:Vector.<Class> = new <Class>[
		];
		public static const GRAPHICS_BACTERIA:Vector.<Class> = new <Class>[
		];
		
		//////////////////////////////////////////////////
		//	SOUND EMBEDDING
		//////////////////////////////////////////////////
		[Embed(source = "../../../resources/audio/bgFillerMusicOcean.mp3")]
		public static const AUDIO_BG_FILLER:Class;
		
		[Embed(source = "../../../resources/audio/bgMusic.mp3")]
		public static const AUDIO_BG_MUSIC:Class;
		
		[Embed(source = "../../../resources/audio/click.mp3")]
		public static const AUDIO_CLICK:Class;
		
		[Embed(source = "../../../resources/audio/cash.mp3")]
		public static const AUDIO_CASH:Class;
		
		[Embed(source = "../../../resources/audio/collect.mp3")]
		public static const AUDIO_COLLECT:Class;
		
		[Embed(source = "../../../resources/audio/eat.mp3")]
		public static const AUDIO_EAT:Class;
				
		[Embed(source="../../../resources/audio/feed.mp3")]
		public static const AUDIO_FEED:Class;
		
		///////////////////////////////////////////////////
		//	XML EMBEDDING
		///////////////////////////////////////////////////
		[Embed(source = "../../../resources/xml/hats.xml", mimeType="application/octet-stream")]
		public static const XML_HATS:Class;
		
		[Embed(source = "../../../resources/xml/levels.xml", mimeType="application/octet-stream")]
		public static const XML_LEVELS:Class;
		
		[Embed(source = "../../../resources/xml/foods.xml", mimeType="application/octet-stream")]
		public static const XML_FOODS:Class;
		
		[Embed(source="../../../resources/xml/items.xml", mimeType="application/octet-stream")]
		public static const XML_ITEMS:Class;
		
		[Embed(source="../../../resources/xml/contracts.xml", mimeType="application/octet-stream")]
		public static const XML_CONTRACTS:Class;
		
		//	Returns the XML from an embedded octet-stream (XML).
		//	This is a workaround to a bug in the AS3 compiler, that tries to compile XML files.
		public static function getXML(embeddedXML:Class):XML
		{
			var bytes:ByteArray = (new embeddedXML()) as ByteArray;
			var s:String = bytes.readUTFBytes(bytes.length);
			var xml:XML = new XML(s);
			return xml;
		}
		
		//////////////////////////////////////////////////
		//	END OF STATIC RESOURCES LISTING
		//////////////////////////////////////////////////
		
		//////////////////////////////////////////////////
		//	START OF DYNAMIC/ RUNTIME LOADED DATA
		//////////////////////////////////////////////////
		
		//	Data that does not change after initial loading from the XML
		public static var ITEMS:Array = new Array();
		public static var LEVELS:Array = new Array();
		
		//	Loads a non-unlockable item from xml, and puts it into the given array
		private static function loadStatic(T:Class, xmlList:XMLList, array:Array):void
		{
			for each (var xml:XML in xmlList) {
				array.push( new T(xml) );
			}
		}
		
		//////////////////////////////////////////////////////
		//	TEXT FORMATS AND FONTS
		/////////////////////////////////////////////////////
		public static var FORMAT_H1:TextFormat;
		public static var FORMAT_H2:TextFormat;
		
		
		
		public function Resources();
		
		//	Loads the resources that need set up
		//	Easily changed to use external xml
		public static function load():void
		{
			loadStatic(ItemDescriptor, getXML(XML_ITEMS).item, ITEMS);
			loadStatic(Level, getXML(XML_LEVELS).level, LEVELS);
			
			loadFormats();
		}
		
		public static function loadFormats():void
		{
			FORMAT_H1 			= new TextFormat();
			FORMAT_H1.font 	= "Century Gothic";
			FORMAT_H1.bold	= true;
			FORMAT_H1.align 	= TextFormatAlign.CENTER;
			FORMAT_H1.color	= 0x6699CC;
			FORMAT_H1.size	 	= 72;
			
			FORMAT_H2 			= new TextFormat();
			FORMAT_H2.font 	= "Century Gothic";
			FORMAT_H2.bold	= true;
			FORMAT_H2.align 	= TextFormatAlign.CENTER;
			FORMAT_H2.color	= 0xFFFFFF;
			FORMAT_H2.size	 	= 24;
		}
	}

}