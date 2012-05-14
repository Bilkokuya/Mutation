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
		[Embed(source = "../../../resources/gfx/entity/bacteria.png")]
		public static const GFX_BACTERIA:Class;
		
		[Embed(source = "../../../resources/gfx/entity/bacteriahungry.png")]
		public static const GFX_BACTERIA_HUNGRY:Class;
		
		[Embed(source = "../../../resources/gfx/entity/eyes.png")]
		public static const GFX_EYES_OPEN:Class;
		
		[Embed(source = "../../../resources/gfx/entity/testtube.png")]
		public static const GFX_TESTTUBE:Class;
		
		[Embed(source = "../../../resources/gfx/entity/testtube_shadow.png")]
		public static const GFX_TESTTUBE_SHADOW:Class;
		
		//	HATS
		[Embed(source = "../../../resources/gfx/hats/nohat.png")]
		public static const GFX_HAT_NONE:Class;
		[Embed(source = "../../../resources/gfx/hats/explorer_normal.png")]
		public static const GFX_HAT_EXPLORER:Class;
		[Embed(source = "../../../resources/gfx/hats/piratehat.png")]
		public static const GFX_HAT_PIRATE:Class;
		[Embed(source = "../../../resources/gfx/hats/tophat_leather.png")]
		public static const GFX_HAT_TOPHAT_LEATHER:Class;
		[Embed(source = "../../../resources/gfx/hats/feathercap.png")]
		public static const GFX_HAT_FEATHER:Class;
		[Embed(source = "../../../resources/gfx/hats/germanhelm.png")]
		public static const GFX_HAT_HELM:Class;
		[Embed(source = "../../../resources/gfx/hats/explorer_flags.png")]
		public static const GFX_HAT_EXPLORER_FLAGS:Class;
		[Embed(source = "../../../resources/gfx/hats/tophat_black.png")]
		public static const GFX_HAT_TOPHAT_BLACK:Class;
		[Embed(source = "../../../resources/gfx/hats/germanhelm_gold.png")]
		public static const GFX_HAT_HELM_GOLD:Class;
		[Embed(source = "../../../resources/gfx/hats/explorer_gold.png")]
		public static const GFX_HAT_EXPLORER_GOLD:Class;
		[Embed(source = "../../../resources/gfx/hats/tophat_gold.png")]
		public static const GFX_HAT_TOPHAT_GOLD:Class;
		
		public static const GRAPHICS_HATS:Vector.<Class> = new <Class>[
			GFX_HAT_NONE,
			GFX_HAT_EXPLORER,
			GFX_HAT_PIRATE,
			GFX_HAT_TOPHAT_LEATHER,
			GFX_HAT_FEATHER,
			GFX_HAT_HELM,
			GFX_HAT_EXPLORER_FLAGS,
			GFX_HAT_TOPHAT_BLACK,
			GFX_HAT_HELM_GOLD,	
			GFX_HAT_EXPLORER_GOLD,
			GFX_HAT_TOPHAT_GOLD
		];
		
		//	FOODS
		[Embed(source="../../../resources/gfx/ui/nounlocks.png")]
		public static const GFX_NO_UNLOCK:Class;
		
		[Embed(source = "../../../resources/gfx/foods/fooddebris.png")]
		public static const GFX_FOOD_DEBRIS:Class;
		
		[Embed(source = "../../../resources/gfx/foods/food1.png")]
		public static const GFX_FOOD_SIMPLE:Class;
		
		[Embed(source = "../../../resources/gfx/foods/foodexplosive.png")]
		public static const GFX_FOOD_EXPLOSIVE:Class;
		
		[Embed(source = "../../../resources/gfx/foods/foodpills.png")]
		public static const GFX_FOOD_BLUEPILLS:Class;
		
		[Embed(source = "../../../resources/gfx/foods/foodpillsred.png")]
		public static const GFX_FOOD_REDPILLS:Class;
		
		[Embed(source = "../../../resources/gfx/foods/foodpillsyellow.png")]
		public static const GFX_FOOD_GOLDPILLS:Class;
		
		[Embed(source = "../../../resources/gfx/foods/foodsemerald.png")]
		public static const GFX_FOOD_EMERALD:Class;
		
		[Embed(source = "../../../resources/gfx/foods/foodruby.png")]
		public static const GFX_FOOD_RUBY:Class;
		
		[Embed(source = "../../../resources/gfx/foods/fooddiamond.png")]
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
		[Embed(source = "../../../resources/gfx/ui/arrow.png")]
		public static const GFX_UI_ARROW:Class;
		
		[Embed(source="../../../resources/gfx/ui/introscreenmenu.png")]
		public static const GFX_UI_MENU:Class;
		
		[Embed(source = "../../../resources/gfx/ui/button_base.png")]
		public static const GFX_UI_BUTTON_BASE:Class;
		
		[Embed(source = "../../../resources/gfx/ui/button_spawnbacteria.png")]
		public static const GFX_UI_BUTTON_BACTERIA:Class;
		
		[Embed(source = "../../../resources/gfx/ui/button_contract.png")]
		public static const GFX_UI_BUTTON_CONTRACT:Class;
		
		[Embed(source = "../../../resources/gfx/ui/speaker.png")]
		public static const GFX_UI_SPEAKER:Class;
		
		[Embed(source = "../../../resources/gfx/ui/speaker_muted.png")]
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