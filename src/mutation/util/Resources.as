package mutation.util 
{
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
		[Embed(source="../../../resources/gfx/explorerhat.png")]
		public static const GFX_HAT_EXPLORER:Class;
		
		[Embed(source="../../../resources/gfx/piratehat.png")]
		public static const GFX_HAT_PIRATE:Class;
		
		[Embed(source="../../../resources/gfx/prettyhat.png")]
		public static const GFX_HAT_PRETTY:Class;
		
		[Embed(source = "../../../resources/gfx/cookie.jpg")]
		public static const GFX_FOOD_COOKIE:Class;
		
		[Embed(source="../../../resources/gfx/grapefruit.jpg")]
		public static const GFX_FOOD_GRAPEFRUIT:Class;
		
		[Embed(source="../../../resources/gfx/nounlocks.jpg")]
		public static const GFX_NO_UNLOCK:Class;
		
		[Embed(source = "../../../resources/gfx/arrow.png")]
		public static const GFX_UI_ARROW:Class;
		
		public static const GRAPHICS_HATS:Vector.<Class> = new <Class>[
			GFX_HAT_EXPLORER,
			GFX_HAT_PIRATE,
			GFX_HAT_PRETTY,
		];
		public static const GRAPHICS_FOODS:Vector.<Class> = new <Class>[
			GFX_FOOD_GRAPEFRUIT,
			GFX_FOOD_COOKIE	
		];
		public static const GRAPHICS_ITEMS:Vector.<Class> = new <Class>[
		];
		public static const GRAPHICS_BACTERIA:Vector.<Class> = new <Class>[
		];
		
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

		//	Loads in the basic data from the embedded XML
		//	Easily changed to use external xml
		public static function load():void
		{
			loadStatic(ItemDescriptor, getXML(XML_ITEMS).item, ITEMS);
			loadStatic(Level, getXML(XML_LEVELS).level, LEVELS);
		}
		
		//	Loads a non-unlockable item from xml, and puts it into the given array
		private static function loadStatic(T:Class, xmlList:XMLList, array:Array):void
		{
			for each (var xml:XML in xmlList) {
				array.push( new T(xml) );
			}
		}
		
		public function Resources();
		
	}

}