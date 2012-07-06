package IsoGameEngine.GameBoard 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Simon
	 */
	
	public class BaseTerrain 
	{
		public var gridWidth:uint; //in X tiles
		public var gridHeight:uint;// in Y tiles
		public var tileWidth:uint;
		public var tileHeight:uint;
		
		
		public var mapWidth:uint;// in Pixels
		public var mapHeight:uint;//in Pixels
		
		
		public function BaseTerrain(_gridWidth:uint, _gridHeight:uint, _tileHeight:uint, _tileWidth:uint, _mapHeight:uint, _mapWidth:uint) 
		{
			gridWidth = _gridWidth;
			gridHeight = _gridHeight;
			tileWidth = _tileWidth;
			tileHeight = _tileHeight;
			
			mapWidth = gridWidth * tileWidth;
			mapHeight = gridHeight * tileHeight;
			
			init();
		}
		
		private function SetFieldDimensions():void
		{
			Globals.boardSize = new Point(mapWidth,mapHeight);
			
			Globals.gridSize = new Point(gridWidth,gridHeight);
			
			Globals.mapCenter = new Point(mapWidth/2,mapHeight/2);
			
			Globals.tileSize = new Point(tileWidth,tileHeight);
		}
		
		private function init():void
		{
			SetFieldDimensions();
			
			//A 2D Array of Grid Height and Width
			var gridA:Array = new Array();
			for ( var width:int = 0; width < gridWidth; width++) {
				var heightA:Array = new Array();
				gridA.push(heightA);
				for ( var height:int = 0; height < gridHeight; height++) {
					gridA[width].push(null);
				}				
			}
			Globals.backgroundLayerGraphicsA = clone(gridA);
			Globals.mainLayerGraphicsA = clone(gridA);
			Globals.foregroundLayerGraphicsA = clone(gridA);
			Globals.allGraphicLayersA.push(Globals.backgroundLayerGraphicsA,Globals.mainLayerGraphicsA,Globals.foregroundLayerGraphicsA);
			
			import flash.utils.ByteArray;
			function clone(source:Object):*
			{
				var myBA:ByteArray = new ByteArray();
				myBA.writeObject(source);
				myBA.position = 0;
				return(myBA.readObject());
			}
			
			var startPosXShift:Number = 0;
			var startPosYShift:Number = 0;
			
			for ( var i:int = 0; i < gridWidth; i++) {
				for ( var j:int = 0; j < gridHeight; j++) {
					var newTile:_TilesOutline = new _TilesOutline();
					
					newTile.x +=  i * tileWidth / 2 + j * tileWidth / 2 + startPosXShift;
					newTile.y -=  i * tileHeight / 2 + j * tileHeight / 2 - startPosYShift;
					
					Globals.backgroundLayerGraphicsA[i].push(newTile);
					Globals.engine._AddToBackground(newTile);
				}
				startPosYShift +=  tileHeight;
			}
		}
		
		private function makeBackground():void
		{
			
		}
		
		
		
		public function clearMap():void
		{
			for ( var i:int = 0; i < Globals.backgroundLayerGraphicsA.length; i++) {
				for ( var j:int = 0; j < Globals.backgroundLayerGraphicsA[i].length; j++) {
					if(Globals.backgroundLayerGraphicsA[i][j] is _TilesOutline){
						Globals.engine._RemoveFromBackground(Globals.backgroundLayerGraphicsA[i][j]);
						Globals.backgroundLayerGraphicsA[i][j].pop;
					}
				}
			}
		}
		
		
		
		
		
		
		
	}
}