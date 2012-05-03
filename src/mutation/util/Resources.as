package mutation.util 
{
	import flash.utils.ByteArray;
	import mutation.entity.foods.FoodDescriptor;
	import mutation.entity.hats.HatDescriptor;
	import mutation.entity.items.ItemDescriptor;
	import mutation.entity.levelling.Level;

	
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
		
		public static const GRAPHICS:Vector.<Class> = new <Class>[
			GFX_HAT_EXPLORER,
			GFX_HAT_PIRATE,
			GFX_HAT_PRETTY
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
		
		//	Data for the hats etc that have been loaded
		//	Will not change after the game has been loaded
		public static var HAT_TYPES:Vector.<HatDescriptor> = new Vector.<HatDescriptor>();
		public static var FOOD_TYPES:Vector.<FoodDescriptor> = new Vector.<FoodDescriptor>();
		public static var ITEM_TYPES:Vector.<ItemDescriptor> = new Vector.<ItemDescriptor>();
		public static var LEVEL_TYPES:Vector.<Level> = new Vector.<Level>();
		
		public function Resources();
		
		//	Loads in the basic data from the embedded XML
		//	Easily changed to use external xml
		public static function load():void
		{
			initHats(getXML(XML_HATS));
			initFoods(getXML(XML_FOODS));
			initItems(getXML(XML_ITEMS));
			initLevels(getXML(XML_LEVELS));
		}
		
		//	Loads the Hats data from XML
		//	Would be more generic, but no template support in AS3
		private static function initHats(xml:XML):void
		{
			var hatList:XMLList = xml.hat;
			for each (var hatXML:XML in hatList) {
				HAT_TYPES.push( new HatDescriptor(hatXML) );
			}
		}
		
		//	Loads the Food data from XML
		private static function initFoods(xml:XML):void
		{
			var foodList:XMLList = xml.food;
			for each (var foodXML:XML in foodList) {
				FOOD_TYPES.push( new FoodDescriptor(foodXML) );
			}
		}
		
		//	Loads the Items data from XML
		private static function initItems(xml:XML):void
		{
			var itemList:XMLList = xml.item;
			for each (var itemXML:XML in itemList) {
				ITEM_TYPES.push( new ItemDescriptor(itemXML) );
			}
		}
		
		//	Loads the level (experience level) data from XML
		private static function initLevels(xml:XML):void
		{
			var levelList:XMLList = xml.level;
			for each (var levelXML:XML in levelList) {
				LEVEL_TYPES.push( new Level(levelXML) );
			}
		}
		
		
	}

}