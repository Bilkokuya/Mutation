package mutation.entity.hats 
{
	import mutation.util.Resources;

	public class Hats 
	{
		public static const EXPLORER:HatDescriptor 	= new HatDescriptor((Resources.getXML(Resources.XML_HATS)).hat[0]);
		public static const PIRATE:HatDescriptor 	= new HatDescriptor((Resources.getXML(Resources.XML_HATS)).hat[1]);
		public static const PRETTY:HatDescriptor 	= new HatDescriptor((Resources.getXML(Resources.XML_HATS)).hat[2]);
		
		public function Hats();
	}

}