package mutation.entity.hats 
{
	import mutation.util.Resources;

	//	Static, temporary holding for the different types of Hat available
	//	Should be replaced with a runtime array of hats available; allowing easy changes by changing the XML
	public class Hats 
	{
		public static const EXPLORER:HatDescriptor 	= new HatDescriptor((Resources.getXML(Resources.XML_HATS)).hat[0]);
		public static const PIRATE:HatDescriptor 	= new HatDescriptor((Resources.getXML(Resources.XML_HATS)).hat[1]);
		public static const PRETTY:HatDescriptor 	= new HatDescriptor((Resources.getXML(Resources.XML_HATS)).hat[2]);
		
		public function Hats();
	}

}