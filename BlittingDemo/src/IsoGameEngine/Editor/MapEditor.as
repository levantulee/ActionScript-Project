package IsoGameEngine.Editor
{
	import IsoGameEngine.ISOObjects.ISOBoardObject;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.ui.Mouse;

	public class MapEditor extends Sprite
	{
		public function MapEditor()
		{
			init();
		}
		
		public function init():void
		{
			var tree:_Item_Tree_01 = new _Item_Tree_01();
			addChild(tree);
			tree.y = 150;
			tree.addEventListener(MouseEvent.CLICK, mouseClick);
			var pave:_TilesPave = new _TilesPave();
			addChild(pave)
			pave.x += tree.width;
			pave.y = 150;
			pave.addEventListener(MouseEvent.CLICK, mouseClick);
		}
		
		private function mouseClick(e:MouseEvent):void
		{
			//trace(e.target);
			selectItem(e.target);
		}
		
		private var newItem:*;
		private function selectItem(whatItem:*):void
		{
			//trace('selectNewItem');
			newItem = new ISOBoardObject();
			newItem.setGraphic(new _Item_Tree_01());
			this.addChild(newItem.graphic);
			//newItem.x = Globals.stage.mouseX;
			//newItem.y = Globals.stage.mouseY;
			Globals.stage.addEventListener(Event.ENTER_FRAME, loop);
//			Globals.stage.addEventListener(MouseEvent.CLICK,placeOnMap);
			newItem.graphic.addEventListener(MouseEvent.CLICK,placeOnMap);
			
			//Mouse.hide();
			//Make New Instance, and follow mouse, snap to grid
			//Listen for Click on Stage, place in position
		}
		private function loop(e:Event):void
		{
			//FollowMouse
			var placementPosition:Point = Globals.engine.snapMouseFollowToTile();
			var placementPosition:Point = Globals.engine.snapMouseFollowToTile();
			
			//Snap Pos To Grid
			newItem.setPosition(placementPosition.x,placementPosition.y);
		}
		
		private function placeOnMap(e:MouseEvent):void
		{
			
			var placementPosition:Point = Globals.engine.getScenePosition(new Point(newItem.graphic.x,newItem.graphic.y));
			//trace('place on map',placementPosition);
			
			//newItem.setPosition(placementPosition.x,placementPosition.y);
			var tilePos = Globals.engine.getScreenToMap(placementPosition);
			trace(tilePos);
			if(0 < tilePos.x && tilePos.x <= Globals.gridDimensions.x &&
				0 < tilePos.y && tilePos.y <= Globals.gridDimensions.y)
			{
				trace('success');
				newItem.setTilePosition(tilePos.x,tilePos.y);
				Globals.engine._AddToScene(newItem);
				Globals.stage.removeEventListener(Event.ENTER_FRAME, loop);
				//Globals.stage.removeEventListener(MouseEvent.CLICK,placeOnMap);
				newItem.graphic.removeEventListener(MouseEvent.CLICK,placeOnMap);
				//trace(newItem);
				newItem = null;
				
				Mouse.show();
			} else {
				trace('out of bounds');
			}
			
		}
		
		
	}
}