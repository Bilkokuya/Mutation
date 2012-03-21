//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//
//	Enum
//		Base Class for enums
//		Allows Enum functionality in Flash that is typesafe

package GDM.Mutation.language 
{
	
	//	Class: Enum
	//	Base class for Enums, allows easy incrementation
	public class Enum 
	{
		private static var count:int = 0;
		protected var value:int;
		protected var string:String;
		protected var initialised:Boolean;
		
		public function Enum(enum:Enum, number:int = int.MIN_VALUE) 
		{
			if (initialised) {
				if (number == int.MIN_VALUE) {
					value = number;
					count++;
				}else {
					value = count;
					count = number++;
				}
			}else {
				if (number == int.MIN_VALUE) {
					value = count++;
					
				}else {
					count = number;
					value = count++;
					
				}
			}

		}
		
		public function setString(string:String):void
		{
			this.string = string;
		}
		
	}

}