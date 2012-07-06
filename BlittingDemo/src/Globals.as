package  
{
	import IsoGameEngine.GameBoard.BaseTerrain;
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
		/**  Size of the Tile Board in X and Y pixels not transformed. */
		public static var boardSize:Point;
		/**  Size of the Tile Board in X and Y amount tiles. */
		public static var gridSize:Point;
		/**  Size of Tile in X and Y pixels. */
		public static var tileSize:Point;
		/**  Center of the tile map in pixels */
		public static var mapCenter:Point;
		/** Reference to the current terrain */
		public static var terrain:BaseTerrain;
		
		
		/**  Main Graphics Layer Grid Objects */
		public static var backgroundLayerGraphicsA:Array;// = new Array(new Array());
		public static var mainLayerGraphicsA:Array;// = new Array(new Array());
		public static var foregroundLayerGraphicsA:Array;// = new Array(new Array());
		public static var allGraphicLayersA:Array = new Array();
		
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