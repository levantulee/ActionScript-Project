package IsoEngine
{
	public class IsoProjection
	{
		import flash.geom.Matrix;
		import flash.geom.Point;
		
		private var projection:Matrix;
		private var projectionInverse:Matrix;
		private var pt:Point;
		
		public function IsoProjection(tileWidth:Number, tileHeight:Number)
		{
			pt = new Point();
			projection = new Matrix();
			
			var scale:Number = 1;
			
			
			projection.rotate(45 * (Math.PI / 180) );
			//scale = 1.4;
			scale = 1.4142137000082988; // not sure why this magic number is needed- now working on a "real" solution
			projection.scale(scale * 1, scale * .5);
			//projection.scale(1, 0.5);
			
			projectionInverse = (projection.clone());
			projectionInverse.invert();
			projection.translate(-tileWidth, tileHeight);
			
		}
		
		public function ISOToScreen(isoPt:Point):Point {
			return projection.transformPoint(isoPt);
		}
		
		public function screenToISO(pt:Point):Point {
			var pt:Point = projectionInverse.transformPoint(pt);
			//trace("s", pt);
			return new Point(pt.x, pt.y);
		}
	}
}