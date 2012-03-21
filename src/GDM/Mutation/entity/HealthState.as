package GDM.Mutation.entity 
{
	
	import GDM.Mutation.language.Enum;

	//	Class: HealthState (extends Enum)
	//		internal enum for the overall State of the Bacteria
	public class HealthState extends Enum
	{
		public static const HAPPY:HealthState		= new HealthState(HAPPY, 0);
		public static const HUNGRY:HealthState 		= new HealthState(HUNGRY);
		public static const DYING:HealthState		= new HealthState(DYING);
		
		public function HealthState(enum:HealthState, number:int = int.MIN_VALUE)
		{
			super(enum, number);
		}
	}

}