package IsoGameEngine 
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Camera 
	{
		
		
		private var previousPos:Point;
		
		private var spill:uint = 0;
		
		private var scollingEnabled:Boolean = false;
		
		private var marker:_Marker = new _Marker();
		
		
		
		public function Camera() 
		{
			init();
		}
		
		private function init():void
		{
			previousPos = new Point(0,0);
			//Drag Listeners
			Globals.stage.addEventListener(MouseEvent.MOUSE_DOWN, dragStart);
			Globals.stage.addEventListener(MouseEvent.MOUSE_UP, dragStop);
			
			//Start Position of Camera is center of game grid
			var startPosXShift:Number = 0;
			var startPosYShift:Number = 0;
			
			
			//Globals.engine.scene.all_Layers.x -= Globals.mapCenter.x;
			//Globals.engine.scene.all_Layers.y -= Globals.mapCenter.y;
			
		}
		
		private function dragStart(e:MouseEvent):void
		{
			//Globals.engine.scene.all_Layers.startDrag();
			toggleScrolling();
		}
		
		private function dragStop(e:MouseEvent):void
		{
			//Globals.engine.scene.all_Layers.stopDrag();
			toggleScrolling();
			//resetBounds();
		}
		
		
		private function toggleScrolling():void
		{
			scollingEnabled = !scollingEnabled;
			
			if(scollingEnabled){
				previousPos.x = Globals.stage.mouseX;
				previousPos.y = Globals.stage.mouseY;
				Globals.stage.addEventListener(Event.ENTER_FRAME, loop);
			} else {
				Globals.stage.removeEventListener(Event.ENTER_FRAME, loop);
				previousPos.x = 0;
				previousPos.y = 0;
			}
		}
		
		
		private function loop(e:Event):void
		{
			if(Globals.stage.mouseX <= 0 || 
				Globals.stage.mouseX >= Globals.stage.stageWidth ||
				Globals.stage.mouseY <= 0 ||
				Globals.stage.mouseY >= Globals.stage.stageHeight)
			{
				toggleScrolling();
			}
			
			if(scollingEnabled){
				var diffX:int = Globals.stage.mouseX - previousPos.x;
				var diffY:int = Globals.stage.mouseY - previousPos.y;
				
				if(Globals.boardDimensions.x > Globals.stage.stageWidth)
				{
					Globals.engine.scene.all_Layers.x += diffX;
					resetBoundsX();
				}
				if(Globals.boardDimensions.y >  Globals.stage.stageHeight)
				{
					Globals.engine.scene.all_Layers.y += diffY;
					resetBoundsY();
				}
				previousPos.x = Globals.stage.mouseX;
				previousPos.y = Globals.stage.mouseY;
				
			}
			Globals.stage.addChild(marker);
		}
		
		
		
		private function resetBoundsX():void
		{
			//Rightside Bounds
			if (Globals.engine.scene.all_Layers.x + Globals.boardDimensions.x <= Globals.stage.stageWidth)
			{
				//trace('Rightside');
				Globals.engine.scene.all_Layers.x = Globals.stage.stageWidth - Globals.boardDimensions.x + spill;
			}
			//Leftside Bounds
			else if (Globals.engine.scene.all_Layers.x >= 0)
			{
				//trace('Leftside');
				Globals.engine.scene.all_Layers.x = 0 - spill;
			}
			marker.x = Globals.engine.scene.all_Layers.x;
		}
		
		private function resetBoundsY():void
			{
		 	//trace('Globals.engine.scene.all_Layers.y BEFORE',Globals.engine.scene.all_Layers.y);
			//Bottomside Bounds
			if (Globals.engine.scene.all_Layers.y + Globals.boardDimensions.y <= Globals.stage.stageHeight)
			{
				//trace('Bottomside');
				Globals.engine.scene.all_Layers.y = Globals.stage.stageHeight - Globals.boardDimensions.y + spill;
				//trace('Globals.engine.scene.all_Layers.y AFTER',Globals.engine.scene.all_Layers.y);
			}
			//Topside Bounds
			else if (Globals.engine.scene.all_Layers.y >= 0)
			{
				//trace('Topside');
				Globals.engine.scene.all_Layers.y = 0 - spill;
			}
			marker.y = Globals.engine.scene.all_Layers.y;
			//trace(marker.x,marker.y);
		}
		
		/*
		private function getMouseTilePosition():void
		{
			var mousePos:Point = new Point(Globals.stage.mouseX,Globals.stage.mouseY);
			var scenePos:Point = new Point(Globals.engine.scene.all_Layers.x,Globals.engine.scene.all_Layers.y);
			
			//trace('clickpos', mousePos.x - scenePos.x, mousePos.y - scenePos.y);
			
			//var transformed:Point = projection.screenToISO(new Point(mousePos.x - scenePos.x, mousePos.y - scenePos.y));
			//trace(transformed, transformed.x/640,transformed.y/640);
			
			var gridPoint:Point = AbsoluteToMap(new Point(mousePos.x - scenePos.x, mousePos.y - scenePos.y + Globals.mapCenter.y));
			trace('gridPoint',gridPoint);
			
			var screenPoint:Point = MapToAbsolute(gridPoint)
			trace('screenPoint', screenPoint, mousePos);
		}
		
		public function MapToAbsolute(mapPoint:Point ):Point
		{
			var Scale = Globals.tileDimenstions.x;
			var screenPoint:Point = new Point();
			screenPoint.x = 1 * (Scale / 2) * (mapPoint.x + mapPoint.y);
			screenPoint.y = 1 * (Scale / 4) * (mapPoint.y - mapPoint.x + Globals.gridDimensions.y);
			
			
			//screenPoint.x = (Scale / 2) * (mapPoint.x + mapPoint.y);
			//screenPoint.y = (Scale / 4) * (mapPoint.x - mapPoint.y);
			
			return screenPoint;
		}
			
		public function AbsoluteToMap(screenPoint:Point):Point
		{
			var Scale = Globals.tileDimenstions.x;
			var mapPoint:Point = new Point();
			screenPoint.x /= (Scale / 2);
			screenPoint.y /= (Scale / 4);

			mapPoint.x = (screenPoint.x - screenPoint.y) / 2;
			mapPoint.y = (screenPoint.x + screenPoint.y) / 2;
			
			//Transpate to correct position to account for offsets.
			mapPoint.x = Math.floor(1 * (mapPoint.x + Globals.gridDimensions.x + 1));
			mapPoint.y = Math.floor(1 * (mapPoint.y - Globals.gridDimensions.y));
			
			//Original
			//mapPoint.x = (screenPoint.x + screenPoint.y) / 2;
			//mapPoint.y = (screenPoint.x - screenPoint.y) / 2;
			
			return mapPoint;
		}*/
		
	}

}