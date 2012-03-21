//	Copyright 2012 Gordon D Mckendrick
//	Author: Gordon D Mckendrick
//	Keys
//		A Key handler for abstracting key presses
//		Makes development far easier

package mutation.util 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	//	Final Class: Key
	public final class Keys 
	{
		//	Public constants for easy access to keyCodes (uint)s
		public static const A:uint = 65;
		public static const B:uint = 66;
		public static const C:uint = 67;
		public static const D:uint = 68;
		public static const E:uint = 69;
		public static const F:uint = 70;
		public static const G:uint = 71;
		public static const H:uint = 72;
		public static const I:uint = 73;
		public static const J:uint = 74;
		public static const K:uint = 75;
		public static const L:uint = 76;
		public static const M:uint = 77;
		public static const N:uint = 78;
		public static const O:uint = 79;
		public static const P:uint = 80;
		public static const Q:uint = 81;
		public static const R:uint = 82;
		public static const S:uint = 83;
		public static const T:uint = 84;
		public static const U:uint = 85;
		public static const V:uint = 86;
		public static const W:uint = 87;
		public static const X:uint = 88;
		public static const Y:uint = 89;
		public static const Z:uint = 90;
		
		
		private static var keys:Array = new Array();		//	Array of Booleans, each index is the keycode
		private static var stageRef:Stage;	//	Reference to the stage for events
		
		//	Constructor: default and NOT TO BE USED
		public function Keys();
		
		//	Function: init
		//	initialises the utility
		//		Use this instead of the constructor
		//		As no instances of this class should be made
		public static function init(stage:Stage):void
		{
			keys = new Array();
			stageRef = stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		//	Function: isDown (uint)
		//	Returns true if the specified key is pressed down
		public static function isDown(keyCode:uint):Boolean
		{
			return (keys[keyCode]);
		}
		
		//	Listener: onKeyDown
		//	When the key is pressed, set it true in the array
		private static function onKeyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		//	Listener: onKeyUp
		//	When the key is liften, set it false in the array
		private static function onKeyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
	}
}
