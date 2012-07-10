package IsoGameEngine.GameBoard 
{
	import IsoGameEngine.ISOObjects.ISOBoardObject;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
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
			
			initGridObjectArrays();
			
			makeBackground();
			
			makeMapGrid();
			
		}
		
		private function initGridObjectArrays():void
		{
			//A 2D Array of Grid Height and Width
			var gridA:Array = new Array();
			
			for ( var x:int = 0; x < gridWidth; x++) {
				var heightA:Array = new Array();
				gridA.push(heightA);
				for ( var y:int = 0; y < gridHeight; y++) {
					gridA[x].push(null);
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
		}
		
		private function makeMapGrid():void
		{
			var startPosXShift:Number = 0;
			var startPosYShift:Number = 0;
			
			
			for ( var y:int = 0; y < gridHeight; y++) {
				for ( var x:int = 0; x < gridWidth; x++) {
					var newTile:_TilesOutline = new _TilesOutline();
					
					newTile.x +=  x * tileWidth / 2 + y * tileWidth / 2 + startPosXShift;
					newTile.y -=  x * tileHeight / 2 + y * tileHeight / 2 - startPosYShift;
					
					var tempISOObject:ISOBoardObject = new ISOBoardObject();
					tempISOObject.setGraphic(newTile);
					Globals.backgroundLayerGraphicsA[x][y] = tempISOObject;
					Globals.engine._AddToBackground(tempISOObject);
				}
				startPosYShift +=  tileHeight;
			}
		}
		
		
		/**
		 * Background Image of the map.
		 * Image is generated from a single base terrain tile, pasted in a sprite, then blitted into a single large bitmap.
		 * 
		 * NOTE, BG is assembled in a non ISO format, rectangular to screen. No perspective shift.
		 * 
		 * Size of background is (mapwidth/height + screen width/height) / tilesize)
		 * 
		 * Image will be added to BACKGROUND Layer at the position is BackgroundImage(0-x/2,0-y/2).
		 * 
		 * */
		
		private function makeBackground():void
		{
			var startPosXShift:Number = 0;
			var startPosYShift:Number = 0;
			
			var bgSprite:Sprite = new Sprite();
			
			var bgSize:Point = new Point((mapWidth + Globals.stage.stageWidth)/tileWidth + 1,(mapHeight*2 + Globals.stage.stageHeight)/tileHeight);
			
			/*if(bgSize.x < Globals.stage.stageWidth/tileWidth || bgSize.y < Globals.stage.stageHeight/tileHeight)
			{
				bgSize.x = Globals.stage.stageWidth/tileWidth;
				bgSize.y = Globals.stage.stageHeight/tileHeight;
			}*/
			
			for ( var y:int = 0; y < bgSize.y; y++) {
				for ( var x:int = 0; x < bgSize.x; x++) {
					var newTile:_TilesGrass = new _TilesGrass();
					
					if(y % 2 == 0){
						newTile.x +=  x * tileWidth;
					} else {
						newTile.x +=  x * tileWidth + tileWidth/2;
					}
					newTile.y +=  y * tileHeight / 2;
					
					bgSprite.addChild(newTile);					
				}
				startPosYShift +=  tileHeight;
			}
			
			
			var bgBmpData:BitmapData = new BitmapData(bgSprite.width-tileWidth,bgSprite.height-tileHeight);
			var bgBmp:Bitmap = new Bitmap(bgBmpData);
			
			var borderTileWidth:int = 10;
			
			bgSprite.x -= borderTileWidth*tileWidth;
			bgSprite.y -= borderTileWidth*tileHeight + Math.floor(gridHeight/2)*tileHeight;
			trace('1',bgSprite.x,bgSprite.y, bgBmp.x,bgBmp.y);
			
			bgBmp.x = bgSprite.x;
			bgBmp.y = bgSprite.y;
			
			trace('2',bgSprite.x,bgSprite.y, bgBmp.x,bgBmp.y);
			
			
			bgBmpData.fillRect(bgBmpData.rect,0);
			bgBmpData.draw(bgSprite);
			
			trace('3',bgSprite.x,bgSprite.y, bgBmp.x,bgBmp.y);
			
			//SNAP TO most CENTER TILE
			
			//bgBmp.x += tileWidth*gridWidth - tileWidth/2 - bgSize.x*tileWidth;
			//bgBmp.y -= (bgSize.y*tileHeight/4 - tileHeight/2);
			
			
			//var offset:Point = new Point();
		/*	if(bgBmp.width % tileWidth == 0){
				trace('BG X OFFSET ADJUST');
				//bgBmp.x -= tileWidth/2;
				//bgBmp.y -= tileHeight/4;
				trace(bgBmp.x,bgBmp.y);
			}
			if(bgBmp.y % tileWidth == 0){
				trace('BG Y OFFSET ADJUST');
				//bgBmp.x -= tileWidth/2;
				//bgBmp.y -= tileHeight/4;
				trace(bgBmp.x,bgBmp.y);
			}*/
			
			
			
			//Globals.backgroundLayerGraphicsA[0][0] = bgBmp;
			//Globals.engine._AddToBackground(bgBmp);
			
		}
		
		
		
		public function clearMap():void
		{
			var x:int, y:int;
			
			for (x = Globals.backgroundLayerGraphicsA.length-1; x >= 0 ; x--) {
				for (y = Globals.backgroundLayerGraphicsA[x].length-1; y >= 0 ; y--) {
					
					if(Globals.backgroundLayerGraphicsA[x][y] is ISOBoardObject){
						Globals.engine._RemoveFromBackground(Globals.backgroundLayerGraphicsA[x][y]);
					}
					Globals.backgroundLayerGraphicsA[x].splice(y,1);
				}
			}
			
			for (x = Globals.allGraphicLayersA.length-1; x >= 0 ; x--) {
				Globals.allGraphicLayersA.pop();
			}
		}
		
		
		
		
		
		
		
	}
}