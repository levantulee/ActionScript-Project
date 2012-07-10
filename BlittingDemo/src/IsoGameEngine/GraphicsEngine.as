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

	/****************************************************************************************
	 * ...
	 * @author Simon
	 * 
	 * USE this to add in the main class:
	 * 
	 * 
	 * var engine:GraphicsEngine = new GraphicsEngine(stage);
	 * Globals.engine = engine;
	 * 
	 * 
	 * Use ADD to Scene and Remove from Scene to add to render pipeline. See detailed descriptions
	 * for all funcitons below.
	 ****************************************************************************************/
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
		
		
		/****************************************************************************************
		 * INIT
		 * 1. Generate the Scene Layers to place all sprites
		 * 2. Prepare the BMP Data to render the scene into
		 * 3. Place a bitmap on the stage that will display said bitmap data
		 * 4. Start the rendering loop
		 ****************************************************************************************/
		public function init():void
		{
			scene = new Scene();
		
			sceneBmpData = new BitmapData(Globals.stage.stageWidth,Globals.stage.stageHeight);
            sceneBmp = new Bitmap(sceneBmpData);
			
			Globals.stage.addChildAt(sceneBmp, 0);
			
			scene.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		
		/****************************************************************************************
		 * RENDER the SCENE into the STAGE BMP's BMPDATA Object
		 ****************************************************************************************/
		private function loop(e:Event):void
		{
			sceneBmpData.fillRect(sceneBmpData.rect,0);
            sceneBmpData.draw(scene);
		}
		
		
		
		/****************************************************************************************
		 * Add a ISO object into the MAIN SCENE Layer
		 * @return FALSE if placement failed due to already Occupied
		 ****************************************************************************************/
		public function _AddToScene(item:ISOBoardObject):Boolean
		{
			if(Globals.mainLayerGraphicsA[item.tilePos.x][item.tilePos.y] == undefined)
			{
				//trace('item pos', item.tilePos.z);
				zSortDisplayList(item);
				
				//Globals.mainLayerGraphicsA[item.tilePos.x][item.tilePos.y] = item;
				scene.main.addChild(item.graphic);
				//sortMainLayerObjects();	
				return true;
			}
			else 
			{
				return false;
			}
			
		}
		
		/****************************************************************************************
		 * REMOVE an ISO object from the MAIN SCENE Layer
		 ****************************************************************************************/
		public function _RemoveFromScene(item:ISOBoardObject):void
		{
			scene.main.removeChild(item.graphic);
		}
		
		/****************************************************************************************
		 * Add a ISO object into the BACKGROUND Layer
		 * @return FALSE if placement failed due to already Occupied
		 ****************************************************************************************/
		public function _AddToBackground(item:ISOBoardObject):void
		{
			scene.background.addChild(item.graphic);
		}
		
		/****************************************************************************************
		 * REMOVE an ISO object from the BACKGROUND Layer
		 ****************************************************************************************/
		public function _RemoveFromBackground(item:ISOBoardObject):void
		{
			scene.background.removeChild(item.graphic);
		}
		
		/****************************************************************************************
		 * Add a ISO object into the FOREGROUND Layer
		 * @return FALSE if placement failed due to already Occupied
		 ****************************************************************************************/
		public function _AddToForeground(item:*):void
		{
			scene.foreground.addChild(item);
		}
		
		/****************************************************************************************
		 * REMOVE an ISO object from the FOREGROUND Layer
		 ****************************************************************************************/
		public function _RemoveFromForeground(item:Sprite):void
		{
			scene.foreground.removeChild(item);
		}
		
		
/****************************************************************************************
 * TEST SORTING ROUTINE
 ****************************************************************************************/
		private function zSortDisplayList(item:ISOBoardObject):void
		{
			if (Globals.displayListA.length > 0)
			{
				var first:int = 0, last:int = Globals.displayListA.length-1;
				
				for (var i:int = 0; i < 10/*Globals.displayListA.length*/; i++)
				{
					var midPoint:int = Math.floor((first + last) / 2);
					
					if (first >= last-1) {
						Globals.displayListA.splice(i, 0, item);
						trace('OVER', i, first, last);
						sort();
						break;
					}
					
					if(item.tilePos.z == Globals.displayListA[midPoint].tilePos.z)
					{
						Globals.displayListA.splice(i, 0, item);
						trace('MATCH', i, first, last);
						sort();
						break;
					}
					else if (item.tilePos.z < Globals.displayListA[midPoint].tilePos.z)
					{
						first = first;
						last = midPoint;
						trace('above', i, first, last);
					}
					else (item.tilePos.z > Globals.displayListA[midPoint].tilePos.z)
					{
						first = midPoint;
						last = last;
						trace('below',i, first, last);
					}
				}
				
				trace('Globals.displayListA.length', Globals.displayListA.length);
			} else {
				Globals.displayListA.push(item);
			}
			
			function sort(){
				for (var z:int = 0; z < Globals.displayListA.length; z++)
				{
					trace(Globals.displayListA[z].tilePos.z);
					//Globals.engine.scene.main.setChildIndex(Globals.displayListA[z].graphic, z);
				}
			}
		}
		
		
		
		
		
		
		
		/****************************************************************************************
		 * Depth Sorts items on grid from Bottom Corner (Front) to Top Corner (Back) to get 
		 * correct depth overlaps.
		 * Sort for All Layers Tracked Arrays
		 * ***************************************************************************************/
		private function sortMainLayerObjects():void
		{
			
			
			var x:int,y:int,nMax:int;
			var isoObject:ISOBoardObject;
			
			var displayListA:Array;
			var displayLayer:Sprite;
			
			for (var i:int = 0; i < Globals.engine.scene.all_Layers.numChildren; i++)
			{
				
				var depthA:Array = new Array();
				var zCounter:int = 0;
								
				//SelectDisplayList
				trace('allGraphicLayersA',Globals.allGraphicLayersA.length);
				displayListA = Globals.allGraphicLayersA[i];
				if(displayListA == null)
				{
					break;
				}
				//SelectDisplayLayer
	
				displayLayer = Sprite(Globals.engine.scene.all_Layers.getChildAt(i));
			
				//Sort from top corner to middle
				for (x = Globals.gridSize.x-1; x > 0; x--) 
				{
					nMax = Globals.gridSize.x - x;
					for (y = 0; y < nMax; y++)
					{
						if(displayListA[x+y][y] !=  undefined)
						{
							//trace('First Half',x+y,y,zCounter);
							isoObject = displayListA[x+y][y];
							isoObject.setZ(zCounter);
							displayLayer.setChildIndex(isoObject.graphic,isoObject.tilePos.z);
							zCounter++;
						}
					}
				}
				//Sort from Middle to Bottom Corner
				for (y = 0; y < Globals.gridSize.y; y++)
				{
					nMax = Globals.gridSize.x - x;
					for (x = 0; x < nMax; x++)
					{
						if(displayListA[x][y+x] !=  undefined){
							//trace('First Half',x,y+x,zCounter);
							isoObject = displayListA[x][y+x];
							isoObject.setZ(zCounter);
							displayLayer.setChildIndex(isoObject.graphic,isoObject.tilePos.z);
							zCounter++;
						}
					}
				}
			}
		}
		
		
		
		
		
		/****************************************************************************************
		 * Receive an ISO point
		 * @return return a LAYER Point
		 * ***************************************************************************************/
		public function getISOToLayer(ISOPoint:Point ):Point
		{
			//trace('mapPoint',ISOPoint);
			var Scale:int = Globals.tileSize.x;
			var screenPoint:Point = new Point();
			screenPoint.x = 1 * (Scale / 2) * (ISOPoint.x + ISOPoint.y) ;
			screenPoint.y = 1 * (Scale / 4) * (ISOPoint.y - ISOPoint.x);
			
			return screenPoint;
		}
		
		/****************************************************************************************
		 * Receive a LAYER point
		 * @return return an ISO Point
		 * ***************************************************************************************/
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
		
		
		
		/****************************************************************************************
		 * Convert a Point from Screen Layer to Blitting Layer
		 * @return Point on Layer
		 * **************************************************************************************/
		public function screenToLayerSpace(screenPoint:Point):Point
		{
			//trace('screenPoint',screenPoint);
			screenPoint.x -= Globals.engine.scene.all_Layers.x /*+ Globals.tileDimenstions.x/2*/;
			screenPoint.y -= Globals.engine.scene.all_Layers.y /*- Globals.mapCenter.y/2*/ /*- Globals.tileDimenstions.y/2*/;
			
			
			return screenPoint;
		}
		
		/****************************************************************************************
		 * Convert a Point from Blitting Layer to Screen Layer
		 * @return Point on Screen
		 * **************************************************************************************/
		public function layerToScreenSpace(layerPoint:Point):Point
		{
			//trace('layerPoint',layerPoint);
			layerPoint.x += Globals.engine.scene.all_Layers.x /*- Globals.tileDimenstions.x/2*/;
			layerPoint.y += Globals.engine.scene.all_Layers.y /*+ Globals.mapCenter.y/2*/ /*- Globals.tileDimenstions.y/2*/;
			
			
			return layerPoint;
		}
		
		/****************************************************************************************
		 * Get a clear position of a clicked tile and return its absolute value for inside the
		 * game map for placement.
		 * @return Point on Screen napped to underlying tile
		 * **************************************************************************************/
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