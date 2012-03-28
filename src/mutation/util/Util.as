package mutation.util 
{
	public class Util 
	{
		
		public function Util() 
		{
		}
		
		//	Returns if a point is within the radius specified
		//	Using pythagorus theorem
		//	x2 and y2 are default 0 as many examples of this function are relative to the origin of their parent object
		public static function inRadius(x1:int, y1:int, radius:int, x2:int = 0, y2:int = 0):Boolean
		{
			return ( (Math.pow((x1- x2), 2) + Math.pow((y1 - y2), 2)) < Math.pow(radius, 2) );
		}
		
		//	Removes the given object from the specified array, returns true if successful
		public static function removeFrom(array:Array, obj:Object):Boolean
		{
			var tempArray:Array = new Array();
			var tempObj:Object;
			while(tempObj != obj){
				tempObj = array.pop();
				tempArray.push(tempObj);
			}
			while (tempArray.length) {
				array.push( tempArray.pop() );
			}
			if (tempObj) {
				return true;
			}else {
				return false;
			}
		}
		
	}

}