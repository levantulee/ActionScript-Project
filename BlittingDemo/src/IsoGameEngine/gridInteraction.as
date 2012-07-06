package IsoGameEngine
{
	
	import IsoGameEngine.ISOObjects.ISOBoardObject;
	import IsoGameEngine.SpecialEffects.OutlineFX;
	import IsoGameEngine.Tools.Point3;
	
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	public class gridInteraction
	{
		public function gridInteraction()
		{
		}
		
		private static var tileOccupiedMarker:_TilesOccupied;
		
		
		
		/****************************************************************************************
		 * Check if the current tile is within the grid boundaries.
		 * @return BOOLEAN FALSE IF: Position is outside of Bounds
		 ****************************************************************************************/
		public static function _CheckTileOutOfBounds(refISOObject:ISOBoardObject):Boolean
		{
			if(0 <= refISOObject.tilePos.x && refISOObject.tilePos.x < Globals.gridSize.x &&
				0 <= refISOObject.tilePos.y && refISOObject.tilePos.y < Globals.gridSize.y)
			{
				//trace('Inside Bounds');
				return false;
			}
			else
			{
				//trace('Outside Bounds');
				_HideTileOccupiedMarker();
				SetIsoObjectOutlineColor(refISOObject,0xFF0000);
				return true;
			}
		}
		
		
		
		
		/****************************************************************************************
		 * Check if the current tile is occupied or not.
		 * @return FALSE IF: Position is occupied
		 ****************************************************************************************/
		public static function _CheckTileOccupied(refISOObject:ISOBoardObject):Boolean
		{
			if(Globals.mainLayerGraphicsA[refISOObject.tilePos.x][refISOObject.tilePos.y] == undefined)
			{
				return false;
			}
			else 
			{
				return true;
			}
		}
		
		
		
		/****************************************************************************************
		 * Shows a occupied marker at the position in question
		 * Graphic changes based on if the position is free or not.
		 ****************************************************************************************/
		public static function _ShowTileOccupiedMarker(refISOObject:ISOBoardObject, isOccupied:Boolean):void
		{
			if(tileOccupiedMarker == null)
			{
				//trace('MAKE MARKER');
				_MakeTileOccupiedGraphic();
			}
			
			if(isOccupied == false)//not occupied
			{
				tileOccupiedMarker.gotoAndStop(isOccupied);
				SetIsoObjectOutlineColor(refISOObject,0x00FF00);
			}
			else
			{
				tileOccupiedMarker.gotoAndStop(isOccupied);
				SetIsoObjectOutlineColor(refISOObject,0xFF0000);
			}
			
			tileOccupiedMarker.x = refISOObject.graphic.x;
			tileOccupiedMarker.y  = refISOObject.graphic.y;
			
			tileOccupiedMarker.visible = true;
		}
		
		private static function SetIsoObjectOutlineColor(refISOObject:ISOBoardObject,color:int):void
		{
			OutlineFX.addOutlineFX(refISOObject.graphic,color,1,5,1);
		}
		
		public static function _HideTileOccupiedMarker():void
		{
			if(tileOccupiedMarker != null)
			{
				tileOccupiedMarker.visible = false;
			}
		}
		

		public static function _MakeTileOccupiedGraphic():void
		{
			tileOccupiedMarker = new _TilesOccupied();
			
			tileOccupiedMarker.visible = false;
			Globals.stage.addChildAt(tileOccupiedMarker,0);
		}
		
		public static function _RemoveTileOccupiedGraphic():void
		{
			Globals.stage.removeChild(tileOccupiedMarker);
			tileOccupiedMarker = null;
		}
		
		/****************************************************************************************
		 * ISO Object to follow the mouse movement around.
		 * ISO Object must be in SCREEN SPACE
		 ****************************************************************************************/
		public static function _ItemFollowMouse(refISOObject:ISOBoardObject):void
		{
			var mouseLayerPos:Point = Globals.engine.screenToLayerSpace(new Point(Globals.stage.mouseX,Globals.stage.mouseY)); //trace('mouseLayerPos',mouseLayerPos);
			var mouseIsoPos:Point = Globals.engine.getLayerToISO(mouseLayerPos); //trace('mouseIsoPos',mouseIsoPos);
			refISOObject.setTilePosition(mouseIsoPos.x,mouseIsoPos.y); //trace('newItem.tilePos',newItem.tilePos);
			
			//SET the screen position again with the new iso position. Look out for offset
			var tempPosLayer:Point = Globals.engine.getISOToLayer(new Point(refISOObject.tilePos.x, refISOObject.tilePos.y));
			
			var tempPosScreen:Point = Globals.engine.layerToScreenSpace(tempPosLayer);
			
			refISOObject.graphic.x = tempPosScreen.x;
			refISOObject.graphic.y = tempPosScreen.y;
		}
		
		/****************************************************************************************
		 * Item in Layer Position os removed from Layer and Moved onto Stage
		 ****************************************************************************************/
		public static function _MoveObjectFromLayerToStage(refISOObject:ISOBoardObject):void
		{
			//Globals.engine._RemoveFromScene(refISOObject):	
			var screenPos:Point = Globals.engine.layerToScreenSpace(new Point(refISOObject.graphic.x,refISOObject.graphic.y));
			
			refISOObject.graphic.x = screenPos.x;
			refISOObject.graphic.x = screenPos.y;
			
		}
		
		/****************************************************************************************
		 * Attempts to Place an Item on the grid. Checks for Occupancy, Does not check for out of bounds.
		 * @return Placing Success
		 ****************************************************************************************/
		public static function _PlaceIsoItem(refISOObject:ISOBoardObject):Boolean
		{
			
			_HideTileOccupiedMarker();
			
			if(!_CheckTileOccupied(refISOObject)){
				//trace('placing');
				//Remove Glow Effect
				OutlineFX.removeOutlineFX(refISOObject.graphic);
				
				//Set Graphics to use Layer Position
				var layerPos:Point = Globals.engine.screenToLayerSpace(new Point(refISOObject.graphic.x,refISOObject.graphic.y));
				
				refISOObject.graphic.x = layerPos.x;
				refISOObject.graphic.y = layerPos.y;
				
				
				Globals.engine._AddToScene(refISOObject);
				
				return true;
			}
			else 
			{
				//trace('not placing');
				return false;
			}
		}
		
		
		
		
		
		
	}
}