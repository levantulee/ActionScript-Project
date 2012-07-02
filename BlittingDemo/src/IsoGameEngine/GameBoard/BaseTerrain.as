package IsoGameEngine.GameBoard 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Simon
	 */
	
	public class BaseTerrain 
	{
		private var gridWidth:uint; //in X tiles
		private var gridHeight:uint;// in Y tiles
		private var tileWidth:uint;
		private var tileHeight:uint;
		
		private var mapHeight:uint;//in X tiles
		private var mapWidth:uint;// in Y tiles
		
		private var boardA:Array;
		
		public function BaseTerrain(_gridWidth:uint, _gridHeight:uint, _tileHeight:uint, _tileWidth:uint, _mapHeight:uint, _mapWidth:uint) 
		{
			gridWidth = _gridWidth;
			gridHeight = _gridHeight;
			tileWidth = _tileWidth;
			tileHeight = _tileHeight;
			
			mapWidth = gridWidth * tileWidth;
			mapHeight = gridHeight * tileHeight;
			
			//mapHeight = Math.ceil(gridWidth / 10) + 1;
			//mapWidth = Math.ceil(gridHeight / 10) + 1;
			
			
			init();
		}
		
		private function init():void
		{
			SetFieldDimensions();
			
			/*for ( var i:int = 0; i < Math.ceil(mapWidth/10); i++) {
				for ( var j:int = 0; j < Math.ceil(mapHeight/10); j++) {
					var background:_BG_Grass10x10 = new _BG_Grass10x10();
					//make base map art
					Globals.engine._AddToBackground(background);
					
					background.x = background.width * i;
					background.y = background.height * j;
				}
			}*/
			
			//Graphics Holder Array for All Graphics Objects placed in main graphics layer
			boardA = new Array();
			for ( var width:int = 0; width < mapWidth; width++) {
				
				boardA.push(new Array(mapHeight));
			}
			Globals.mainLayerGraphicsA = boardA;
			
			//TO center the grid onf the overall map
			var startPosXShift:Number = tileWidth/2;
			var startPosYShift:Number = 0;
			
			for ( var i:int = 0; i < gridWidth; i++) {
				for ( var j:int = 0; j < gridHeight; j++) {
					var newTile:_TilesOutline = new _TilesOutline();
					
					newTile.x +=  i * tileWidth / 2 + j * tileWidth / 2 + startPosXShift;
					newTile.y -=  i * tileHeight / 2 + j * tileHeight / 2 - startPosYShift - gridHeight*tileHeight/2;

					Globals.engine._AddToBackground(newTile);
				}
				startPosYShift +=  tileHeight;
			}
			
			
			
			
			//add trees to each corner
			/*var tree1:_Item_Tree_01 = new _Item_Tree_01();
			Globals.engine._AddToScene(tree1);
			var tree2:_Item_Tree_01 = new _Item_Tree_01();
			tree2.x = (mapWidth-1)*background.width;
			Globals.engine._AddToScene(tree2);
			var tree3:_Item_Tree_01 = new _Item_Tree_01();
			tree3.y = (mapHeight-1)*background.height;
			Globals.engine._AddToScene(tree3);
			var tree4:_Item_Tree_01 = new _Item_Tree_01();
			tree4.x = (mapWidth-1)*background.width;
			tree4.y = (mapHeight-1)*background.height;
			Globals.engine._AddToScene(tree4);*/
		}
		
		private var boardDimensions:Point = new Point();
		private function SetFieldDimensions():void
		{
			
			
			//boardDimensions.x = tilesX * tileWidth;
			//boardDimensions.y = tilesY * tileHeight;
			
			boardDimensions.x = mapWidth + tileWidth;
			boardDimensions.y = mapHeight + tileHeight;
			
			Globals.boardDimensions = boardDimensions;
			
			Globals.gridDimensions = new Point(gridWidth,gridHeight);

			Globals.mapCenter = new Point(mapWidth/2,mapHeight/2);
			
			var tileDimensions:Point = new Point(tileWidth,tileHeight);
			Globals.tileDimenstions = tileDimensions;
		}
		
		
		
		
		
		
		
	}
}