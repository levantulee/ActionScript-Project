package  
{
	import IsoGameEngine.GraphicsEngine;
	
	import flash.display.Stage;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Simon
	 */
	public class Globals 
	{
		/**  Stage Reference. */
		public static var stage:Stage;
		/**  Render Engine Reference. */
		public static var engine:GraphicsEngine;
		/**  Dimension of the Tile Board in X and Y pixels not transformed. */
		public static var boardDimensions:Point;
		/**  Dimension of the Tile Board in X and Y amount tiles. */
		public static var gridDimensions:Point;
		/**  Dimension of Tile in X and Y pixels. */
		public static var tileDimenstions:Point;
		/**  Center of the tile map in pixels */
		public static var mapCenter:Point;
		
		/**  Main Graphics Layer Grid Objects */
		public static var mainLayerGraphicsA:Array = new Array();
		
		public static var gameObjects:Array = new Array();
		public static var gameObjectNoCol:Array = new Array();
				
		public function Globals() 
		{
			
		}
		
		public static function deleteObject(whatObject:*):void
		{
			whatObject = null;
		}
		
	}

}