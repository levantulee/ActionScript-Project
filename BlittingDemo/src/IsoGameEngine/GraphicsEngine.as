package IsoGameEngine 
{
	import IsoGameEngine.ISOObjects.ISOBoardObject;
	import IsoGameEngine.Tools.Point3;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Simon
	 * 
	 * USE this to add in the main class:
	 * var engine:GraphicsEngine = new GraphicsEngine(stage);
		Globals.engine = engine;
	 * 
	 * Use ADD to Scene and Remove from Scene to add to render pipeline.
	 */
	public class GraphicsEngine
	{
		public var scene:Scene;
		private var sceneBmp:Bitmap;
		private var sceneBmpData:BitmapData;
		
		
		public function GraphicsEngine(stage:Stage) 
		{
			Globals.stage = stage;
			init();
		}
		
		
		
		public function init():void
		{
			scene = new Scene();
		
			sceneBmpData = new BitmapData(Globals.stage.stageWidth,Globals.stage.stageHeight);
            sceneBmp = new Bitmap(sceneBmpData);
			
			Globals.stage.addChildAt(sceneBmp, 0);
			
			scene.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			sceneBmpData.fillRect(sceneBmpData.rect,0);
            sceneBmpData.draw(scene);
		}
		
		//Check if the tile is free
		public function _CheckTileOccupied(tilePos:Point3):Boolean
		{
			if(Globals.mainLayerGraphicsA[tilePos.x][tilePos.y] == undefined)
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
		
		//ADDING AND REMOVING FROM SCENE
		public function _AddToScene(item:ISOBoardObject):Boolean
		{
			if(Globals.mainLayerGraphicsA[item.tilePos.x][item.tilePos.y] == undefined)
			{
				Globals.mainLayerGraphicsA[item.tilePos.x][item.tilePos.y] = item;
				scene.main.addChild(item.graphic);
				sortMainLayerObjects();	
				return true;
			}
			else 
			{
				return false;
			}
			
		}
		
		public function _RemoveFromScene(item:Sprite):void
		{
			scene.main.removeChild(item);
		}
		
		public function _AddToBackground(item:*):void
		{
			scene.background.addChild(item);
		}
		
		public function _RemoveFromBackground(item:Sprite):void
		{
			scene.background.removeChild(item);
		}
		
		public function _AddToForeground(item:*):void
		{
			scene.foreground.addChild(item);
		}
		
		public function _RemoveFromForeground(item:Sprite):void
		{
			scene.foreground.removeChild(item);
		}
		
		/**
		 * SORTING OF OBJECTS IN MAIN ART LAYER
		 */
		private function sortMainLayerObjects():void
		{
			var depthA:Array = new Array();
			var zCounter:int = 0;//Globals.gridSize.x*Globals.gridSize.y;
			
			
			//for (var x:int = Globals.gridSize.x; x > 0; x--)
			for (var x:int = 0; x < Globals.gridSize.x; x++)
			{
				//trace('AB',i);
				var nMax:int = Globals.gridSize.x - x;
				//trace('nMax',nMax);
				for (var y:int = 0; y < nMax; y++)
				{
					//trace('B',i,j);
					if(Globals.mainLayerGraphicsA[x+y][y] !=  undefined)
					{
						//trace('sort B',y,x+y,Globals.mainLayerGraphicsA[x+y][y]);
						var isoObject:ISOBoardObject = Globals.mainLayerGraphicsA[x+y][y];
						isoObject.setZ(zCounter);
						Globals.engine.scene.main.setChildIndex(isoObject.graphic,isoObject.tilePos.z)
						trace('First Half',zCounter);
						zCounter++;
					}
					
				}
			}
			
			
			//for (var y:int = Globals.gridSize.y; y > 0; y--)
			for (var y:int = 0; y < Globals.gridSize.y; y++)
			{
				//trace('A',i);
				var nMax:int = Globals.gridSize.y - y;
				//trace('nMax',nMax);
				for (var x:int = 0; x < nMax; x++)
				{
					//trace('A',i,j);
					if(Globals.mainLayerGraphicsA[x][y+x] !=  undefined){
						/*trace('sort',x,y+x,Globals.mainLayerGraphicsA[x][y+x]);
						//trace(Globals.gridSize.x*Globals.gridSize.y);
						trace(1+x);
						trace((Globals.gridSize.x-(y+x)),(x+1));
						
						Globals.mainLayerGraphicsA[x][y+x].setZ(Globals.gridSize.x*Globals.gridSize.y - (1+x) * ((Globals.gridSize.x-(y+x))-(x+1)));
						trace('Z',Globals.mainLayerGraphicsA[x][y+x].tilePos.z);
						*/
						var isoObject:ISOBoardObject = Globals.mainLayerGraphicsA[x][y+x];
						isoObject.setZ(zCounter);
						Globals.engine.scene.main.setChildIndex(isoObject.graphic,isoObject.tilePos.z)
						trace('First Half',zCounter);
						zCounter++;
					}
					else
						;//trace('A undefined');
					
					
				}
			}
			
			
			
			
			
			
			
		}//
		
		
		
		
		
		/**
		 * Receive an ISO point
		 * @return return a LAYER Point
		 * */
		public function getISOToLayer(ISOPoint:Point ):Point
		{
			//trace('mapPoint',ISOPoint);
			var Scale:int = Globals.tileSize.x;
			var screenPoint:Point = new Point();
			screenPoint.x = 1 * (Scale / 2) * (ISOPoint.x + ISOPoint.y) ;
			screenPoint.y = 1 * (Scale / 4) * (ISOPoint.y - ISOPoint.x);
			
			return screenPoint;
		}
		
		/**
		 * Receive a LAYER point
		 * @return return an ISO Point
		 * */
		public function getLayerToISO(layerPoint:Point):Point
		{
			//Shift Layer Point by half a tile in X to account for offset
			layerPoint.x += Globals.tileSize.x/2;
			
			var Scale:int = Globals.tileSize.x;
			var ISOPoint:Point = new Point();
			layerPoint.x /= (Scale / 2);
			layerPoint.y /= (Scale / 4);

			ISOPoint.x = (layerPoint.x - layerPoint.y) / 2;
			ISOPoint.y = (layerPoint.x + layerPoint.y) / 2;
			
			//Translate to correct position to account for offsets.
			ISOPoint.x = Math.floor(1 * (ISOPoint.x ));
			ISOPoint.y = Math.floor(1 * (ISOPoint.y ));
			
			return ISOPoint;
		}
		
		
		
		
		public function screenToLayerSpace(screenPoint:Point):Point
		{
			//trace('screenPoint',screenPoint);
			screenPoint.x -= Globals.engine.scene.all_Layers.x /*+ Globals.tileDimenstions.x/2*/;
			screenPoint.y -= Globals.engine.scene.all_Layers.y /*- Globals.mapCenter.y/2*/ /*- Globals.tileDimenstions.y/2*/;
			
			
			return screenPoint;
		}
		
		public function layerToScreenSpace(layerPoint:Point):Point
		{
			//trace('layerPoint',layerPoint);
			layerPoint.x += Globals.engine.scene.all_Layers.x /*- Globals.tileDimenstions.x/2*/;
			layerPoint.y += Globals.engine.scene.all_Layers.y /*+ Globals.mapCenter.y/2*/ /*- Globals.tileDimenstions.y/2*/;
			
			
			return layerPoint;
		}
		
		/**
		 * Get a clear position of a clicked tile and return its absolute value for inside the
		 * game map for placement.
		 * @return
		 */
		public function snapToTile(itemPos:Point):Point
		{		
			var gridPoint:Point = getLayerToISO(itemPos);
			//trace(gridPoint,'gridPoint');
			
			var screenPoint:Point = getISOToLayer(gridPoint)
			
			//trace(screenPoint,'screenPoint');
			return screenPoint;
		}
		
	}
}