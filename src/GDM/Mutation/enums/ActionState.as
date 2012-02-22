package GDM.Mutation.enums 
{

	//	Class: ActionState (extends Enum)
	//		internal enum for the action the bacteria is performing
	public class ActionState extends Enum
	{
		public static const IDLE:ActionState 			= new ActionState(IDLE, 0);
		public static const MOVING_TO_FOOD:ActionState 	= new ActionState(MOVING_TO_FOOD);
		
		IDLE.setString("IDLE");
		MOVING_TO_FOOD.setString("MOVING_TO_FOOD");

		
		public function ActionState(enum:ActionState, number:int = int.MIN_VALUE)
		{
			super(enum, number);
		}
	}


}