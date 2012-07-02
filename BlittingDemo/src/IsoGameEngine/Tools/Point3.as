package IsoGameEngine.Tools 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Point3 extends Point 
	{
		public var z:Number;
		
		public function Point3(_x:Number, _y:Number, _z:Number) 
		{
			z = _z;
			super(_x, _y);
		}
		
	}

}