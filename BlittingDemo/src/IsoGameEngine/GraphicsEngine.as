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
		
		private var marker:_Marker = new _Marker();

		public function init():void
		{
			scene = new Scene();
		
			sceneBmpData = new BitmapData(Globals.stage.stageWidth,Globals.stage.stageHeight);
            sceneBmp = new Bitmap(sceneBmpData);
			
			Globals.stage.addChildAt(sceneBmp, 0);
						
			Globals.stage.addChild(marker);
			
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
			//var arrayPosition:Point = Globals.engine.getScreenToMap(new Point(item.x, item.y+Globals.mapCenter.y));
			//trace('_AddToScene OnGrid',arrayPosition, 'OnLayer', item.x,item.y);
			
			
			Globals.mainLayerGraphicsA[item.tilePos.x][item.tilePos.y] = item;
			trace('item.tilePos',item.tilePos);
			//trace('test',Globals.mainLayerGraphicsA[1][20]);
			item.graphic.x -= Globals.engine.scene.all_Layers.x;
			item.graphic.y -= Globals.engine.scene.all_Layers.y;
			
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
			
			for (var i:int = Globals.gridDimensions.y; i > 0; i--)
			{
				//trace('A',i);
				var nMax:int = Globals.gridDimensions.y - i;
				//trace('nMax',nMax);
				for (var j:int = 0; j < nMax+1; j++)
				{
					//trace('A',i,j);
					if(Globals.mainLayerGraphicsA[j][i+j] !=  undefined)
					;//trace('sort',j,i+j,Globals.mainLayerGraphicsA[j][i+j]);
					
					counter++;
				}
			}
			
			for (var i:int = Globals.gridDimensions.x; i > 0; i--)
			{
				//trace('AB',i);
				var nMax:int = Globals.gridDimensions.x - i;
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
		
		public function getISOToLayer(ISOPoint:Point ):Point
		{
			//trace('mapPoint',ISOPoint);
			var Scale:int = Globals.tileDimenstions.x;
			var screenPoint:Point = new Point();
			screenPoint.x = 1 * (Scale / 2) * (ISOPoint.x + ISOPoint.y) ;
			screenPoint.y = 1 * (Scale / 4) * (ISOPoint.y - ISOPoint.x + Globals.gridDimensions.y);
			
			
			
			return screenPoint;
		}
		
		
		public function getLayerToISO(layerPoint:Point):Point
		{
			var Scale:int = Globals.tileDimenstions.x;
			var newLayerPoint:Point = new Point();
			layerPoint.x /= (Scale / 2);
			layerPoint.y /= (Scale / 4);

			newLayerPoint.x = (layerPoint.x - layerPoint.y) / 2;
			newLayerPoint.y = (layerPoint.x + layerPoint.y) / 2;
			
			//Translate to correct position to account for offsets.
			newLayerPoint.x = Math.floor(1 * (newLayerPoint.x + Globals.gridDimensions.x)) - 6;
			newLayerPoint.y = Math.floor(1 * (newLayerPoint.y - Globals.gridDimensions.y)) + 5;
			
			return newLayerPoint;
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
		
		public function screenToLayerSpace(screenPoint:Point):Point
		{
			//trace('screenPoint',screenPoint);
			screenPoint.x -= Globals.engine.scene.all_Layers.x + Globals.tileDimenstions.x/2;
			screenPoint.y -= Globals.engine.scene.all_Layers.y - Globals.mapCenter.y/2 /*- Globals.tileDimenstions.y/2*/;
			
			
			return screenPoint;
		}
		
		public function layerToScreenSpace(layerPoint:Point):Point
		{
			//trace('layerPoint',layerPoint);
			layerPoint.x += Globals.engine.scene.all_Layers.x /*- Globals.tileDimenstions.x/2*/;
			layerPoint.y += Globals.engine.scene.all_Layers.y + Globals.mapCenter.y/2 /*- Globals.tileDimenstions.y/2*/;
			
			marker.x = layerPoint.x;
			marker.y = layerPoint.y;
			
			return layerPoint;
		}
		
	}
}