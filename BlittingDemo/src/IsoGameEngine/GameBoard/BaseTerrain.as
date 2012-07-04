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
			
			//mapHeight = Math.ceil(gridWidth / 10) + 1;
			//mapWidth = Math.ceil(gridHeight / 10) + 1;
			
			
			init();
		}
		
		private function SetFieldDimensions():void
		{
			
			
			//boardDimensions.x = tilesX * tileWidth;
			//boardDimensions.y = tilesY * tileHeight;
			
			
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
			Globals.backgroundLayerGraphicsA = gridA;
			Globals.mainLayerGraphicsA = gridA;
			
			
			
			
			
			
			
			
			
			
			
			
			//TO center the grid onf the overall map
			var startPosXShift:Number = 0;//tileWidth/2;
			var startPosYShift:Number = 0;
			
			for ( var i:int = 0; i < gridWidth; i++) {
				for ( var j:int = 0; j < gridHeight; j++) {
					var newTile:_TilesOutline = new _TilesOutline();
					
					newTile.x +=  i * tileWidth / 2 + j * tileWidth / 2 + startPosXShift;//- gridWidth*tileWidth/2;
					newTile.y -=  i * tileHeight / 2 + j * tileHeight / 2 - startPosYShift;//- gridHeight*tileHeight/2;
					
					if(i == 0 && j == 0) trace(newTile.x,newTile.y);
					
					Globals.backgroundLayerGraphicsA[i].push(newTile);
					Globals.engine._AddToBackground(newTile);
				}
				startPosYShift +=  tileHeight;
			}
			
			trace('MAP INIT Post Tile Init',Globals.engine.scene.all_Layers.x,Globals.engine.scene.all_Layers.y,
				Globals.engine.scene.background.x,Globals.engine.scene.background.y);
			
			
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