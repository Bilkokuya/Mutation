//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D MCkendrick
//
//	ButtonEvent (extends Event)
//		Fires when a button is clicked

package GDM.Mutation.events 
{
	import flash.events.Event;

	//	Class: ButtonEvent extends Event
	public class ButtonEvent extends Event
	{
		//	Event types as Strings
		public static const CLICKED:String = "CLICKED";	//	When the button is clicked

		//	Member variables
		public var buttonName:String;	//	Name of this button
		public var identifier:String;	//	Identifier
		public var value:int;			//	Integer value, for buttons that do such
		
		//	Constructor: default
		public function ButtonEvent(type:String, name:String = null, identifier:String = null, value:int = 0, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.buttonName = name;
			this.identifier = identifier;
			this.value = value;
		}
		
	}

}