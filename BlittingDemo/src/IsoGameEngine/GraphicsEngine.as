package IsoGameEngine 
{
	import IsoGameEngine.ISOObjects.ISOBoardObject;
	
	import adobe.utils.CustomActions;
	
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
		
		//private var camera:Camera;
		
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
		
		
		//ADDING AND REMOVING FROM SCENE
		public function _AddToScene(item:ISOBoardObject):void
		{
			Globals.mainLayerGraphicsA[item.tilePos.x][item.tilePos.y] = item;
			scene.main.addChild(item.graphic);
			sortMainLayerObjects();
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
			/*
			//Go to last in Y array
			var totalTiles:int = Globals.gridDimensions.x * Globals.gridDimensions.y /2;
			
			while(totalTiles > 0)
			{
			 //go to first in X array and go down N positions. Start at N = 1;
				var n:int = 0; //Column
				while(n > 0)
				{
					var m:int = 1; //Row
					while(m <= m + 1)
					{
						Globals.mainLayerGraphicsA[m][n];
						trace('sorting',m,n);
					}
					n++;
				}
				totalTiles--;
			}*/
			var counter:int = 0;
			
			for (var i:int = Globals.gridSize.y; i > 0; i--)
			{
				//trace('A',i);
				var nMax:int = Globals.gridSize.y - i;
				//trace('nMax',nMax);
				for (var j:int = 0; j < nMax+1; j++)
				{
					//trace('A',i,j);
					if(Globals.mainLayerGraphicsA[j][i+j] !=  undefined)
					;//trace('sort',j,i+j,Globals.mainLayerGraphicsA[j][i+j]);
					
					counter++;
				}
			}
			
			for (var i:int = Globals.gridSize.x; i > 0; i--)
			{
				//trace('AB',i);
				var nMax:int = Globals.gridSize.x - i;
				//trace('nMax',nMax);
				for (var j:int = 0; j < nMax; j++)
				{
					//trace('B',i,j);
					if(Globals.mainLayerGraphicsA[i+j][j] !=  undefined)
					;//trace('sort B',j,i+j,Globals.mainLayerGraphicsA[i+j][j]);
					counter++;
				}
			}
			
			//trace(counter, Globals.gridDimensions.x*Globals.gridDimensions.y);
			
			
			
			
			//var prevIndex:int = 0;
			//Globals.mainLayerGraphicsA
			/*if (Globals.mainLayerGraphicsA.length > 1) {
				for ( var i:int = 0; i < Globals.mainLayerGraphicsA.length-1; i++) {
					if (Globals.mainLayerGraphicsA[i] != null)
					{
						var index1:int = scene.main.getChildIndex(Globals.mainLayerGraphicsA[i]);
						var index2:int = scene.main.getChildIndex(Globals.mainLayerGraphicsA[i + 1]);
						if (index1 > index2)
						{
							scene.main.swapChildrenAt(index1, index2);
						}
						
				
					}
					
					
				}
			}//*/
			
		}//
		
		
		
		//POSITIONING ROUTINES
		/**
		 * Gets the object position inside the map scene. (Screen offset included.)
		 * @return
		 */
		/*public function getScenePosition(screenObjectPos:Point):Point
		{
			var scenePos:Point = new Point(screenObjectPos.x + Globals.tileDimenstions.x/2, 
											screenObjectPos.y + Globals.mapCenter.y);
			return scenePos;
		}*/
		
		
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