package  
{
	import BlittingEngine.GraphicsEngine;
	
	import flash.display.Stage;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Simon
	 */
	public class Globals 
	{
		
		public static var stage:Stage;
		public static var engine:GraphicsEngine;
		public static var boardDimensions:Point;
		public static var tileDimenstions:Point;
		public static var mapCenter:Point;
		
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