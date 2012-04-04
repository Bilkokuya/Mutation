package mutation.util 
{
	public class Util 
	{
		
		public function Util() 
		{
		}
		
		//	Returns if a point is within the radius specified
		//	Using pythagorus theorem
		//	x2 and y2 default as 0; as many uses of this function are relative to the origin of their parent object
		public static function inRadius(x1:int, y1:int, radius:int, x2:int = 0, y2:int = 0):Boolean
		{
			return ( getDistanceSquared(x1, y1, x2, y2) < Math.pow(radius, 2) );
		}
		
		//	Returns the distance squared between two points
		public static function getDistanceSquared(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return ( Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2) );
		}
		
		//	Returns the distance between two points
		public static function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return ( Math.sqrt(getDistanceSquared(x1, y1, x2, y2)) );
		}
		
		
		public static function angleTo(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			
			return (Math.atan2(dy, dx));
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
			
			//	will be null if "obj" wasn't found in "array"
			if (tempObj) {
				return true;
			}else {
				return false;
			}
		}
		
	}

}