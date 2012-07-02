package Editor
{
	import IsoEngine.IsoProjection;
	
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
			trace(e.target);
			selectItem(e.target);
		}
		
		private var newItem:*;
		private function selectItem(whatItem:*):void
		{
			trace('selectNewItem');
			newItem = new _Item_Tree_01();
			this.addChild(newItem);
			//newItem.x = Globals.stage.mouseX;
			//newItem.y = Globals.stage.mouseY;
			Globals.stage.addEventListener(Event.ENTER_FRAME, loop);
//			Globals.stage.addEventListener(MouseEvent.CLICK,placeOnMap);
			newItem.addEventListener(MouseEvent.CLICK,placeOnMap);
			
			//Mouse.hide();
			//Make New Instance, and follow mouse, snap to grid
			//Listen for Click on Stage, place in position
		}
		private function loop(e:Event):void
		{
			//FollowMouse
			var tempPosX:int = Globals.stage.mouseX-newItem.width/2;
			var tempPosY:int = Globals.stage.mouseY;
			//Snap Pos To Grid
			newItem.x = Math.ceil(tempPosX/Globals.tileDimenstions.x)*Globals.tileDimenstions.x;
			newItem.y = Math.ceil(tempPosY/Globals.tileDimenstions.y)*Globals.tileDimenstions.y;
		}
		
		
		
		private var projection:IsoProjection;
		private function placeOnMap(e:MouseEvent):void
		{
			
			projection = new IsoProjection(Globals.tileDimenstions.x, Globals.tileDimenstions.y);
			
			var isoPt:Point = projection.screenToISO(new Point(newItem.x,newItem.y));
			var screenPt:Point = projection.ISOToScreen(new Point(newItem.x,newItem.y));
			 trace(isoPt,newItem.x,newItem.y,screenPt);
			
			
			trace('place on map');
			/*newItem.x -= Globals.engine.scene.all_Layers.x;
			newItem.y -= Globals.engine.scene.all_Layers.y;
			Globals.engine._AddToScene(newItem);*/
			Globals.stage.removeEventListener(Event.ENTER_FRAME, loop);
			//Globals.stage.removeEventListener(MouseEvent.CLICK,placeOnMap);
			newItem.removeEventListener(MouseEvent.CLICK,placeOnMap);
			trace(newItem);
			newItem = null;
			
			Mouse.show();
			
		}
		
		
	}
}