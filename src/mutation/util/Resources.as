package mutation.util 
{
	import flash.utils.ByteArray;

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
		//	END OF RESOURCES LISTING
		////////////////////////////////////////////////
		public function Resources();
		
		
	}

}