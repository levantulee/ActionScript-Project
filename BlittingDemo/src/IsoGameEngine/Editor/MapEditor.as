package IsoGameEngine.Editor
{
	import IsoGameEngine.GameBoard.BaseTerrain;
	import IsoGameEngine.ISOObjects.ISOBoardObject;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class MapEditor extends _MapEditor
	{
		private var marker:ISOBoardObject = new ISOBoardObject();
		
		public function MapEditor()
		{
			init();
		}
		
		public function init():void
		{
			makeMap();
			
			var tree:_Item_Tree_01 = new _Item_Tree_01();
			addChild(tree);
			tree.y = 150;
			tree.addEventListener(MouseEvent.CLICK, mouseClick);
			var pave:_TilesPave = new _TilesPave();
			addChild(pave)
			pave.x += tree.width;
			pave.y = 150;
			pave.addEventListener(MouseEvent.CLICK, mouseClick);
			
			
			//POSITIONING TEST
			/*marker.graphic = new _Marker();
			marker.setTilePosition(2,2);
			//TEST SUCCESS: Get the LAYER position using the 0,0,0 preset grid ISO position of the marker. result should be 0,0
			var tempPos:Point = Globals.engine.getISOToLayer(new Point(marker.tilePos.x, marker.tilePos.y));
			marker.graphic.x = tempPos.x;
			marker.graphic.y = tempPos.y;//SUCCESS
			
			
			//TEST SUCCESS: Get the current ISO position using the default 0,0 LAYER position., result should be 1,1
			var tempISOPos:Point = Globals.engine.getLayerToISO(new Point(marker.graphic.x,marker.graphic.y));
			marker.setTilePosition(tempISOPos.x,tempISOPos.y);
			trace('tempISOPos',tempISOPos);// SUCCESS
			//SET the screen position again with the new iso position. Look out for offset
			var tempPos:Point = Globals.engine.getISOToLayer(new Point(marker.tilePos.x, marker.tilePos.y));
			marker.graphic.x = tempPos.x;
			marker.graphic.y = tempPos.y;//TEST TEST
			trace('tempPos',tempPos);*/
			
			
			
			
			initFields();
			
			this.addEventListener(Event.ENTER_FRAME, refreshUI);
		}
		
		private function refreshUI(e:Event):void
		{
			updateTextFields();
		}
		
		private function initFields():void
		{
			this._btn_MakeNewMap..addEventListener(MouseEvent.CLICK,makeNewMap);

			updateTextFields();
		}
		private function updateTextFields():void
		{
			this._txt_tilesX.text = String(Globals.terrain.gridWidth);
			this._txt_tilesY.text = String(Globals.terrain.gridHeight);
			this._txt_tileWidth.text = String(Globals.terrain.tileWidth);
			this._txt_tileHeight.text = String(Globals.terrain.tileHeight);
			
			this._txt_gridWidth.text = String(Globals.terrain.mapWidth);
			this._txt_gridHeight.text = String(Globals.terrain.mapHeight);
			
			
			this._txt_layerPosAll.text = String(Globals.engine.scene.all_Layers.x +',' + Globals.engine.scene.all_Layers.y);
			this._txt_layerPosMain.text = String(Globals.engine.scene.main.x +',' + Globals.engine.scene.main.y);
			this._txt_layerPosBG.text = String(Globals.engine.scene.background.x +',' + Globals.engine.scene.background.y);
			this._txt_layerPosFG.text = String(Globals.engine.scene.foreground.x +',' + Globals.engine.scene.foreground.y);
			
			var mouseLayerPos:Point = Globals.engine.screenToLayerSpace(new Point(Globals.stage.mouseX,Globals.stage.mouseY));
			this._txt_mouseOverTileLayerPos.text = String(mouseLayerPos);
			this._txt_mouseOverGridTile.text = String(Globals.engine.getLayerToISO(mouseLayerPos));
			this._txt_mouseOverStageLayerPos.text = String(new Point(Globals.stage.mouseX,Globals.stage.mouseY));
			
		}
		
		
		private function removeAllTiles():void
		{
			if(Globals.terrain != null)
			{
				Globals.terrain.clearMap();
			}
			
		}
		
		
		private function makeNewMap(e:MouseEvent):void
		{
			removeAllTiles();
			makeMap();
			
		}
		
		//MOVE MAP CREATION TO ENGINE
		private function makeMap():void
		{
			var terrain:BaseTerrain = new BaseTerrain(int(this._txt_set_tilesX.text), int(this._txt_set_tilesY.text), 25, 50, 4,4);
			Globals.terrain = terrain;
		}
		
		
		
		
		private function mouseClick(e:MouseEvent):void
		{
			//trace(e.target);
			selectItem(e.target);
		}
		
		private var newItem:ISOBoardObject;
		
		private function selectItem(whatItem:Object):void
		{
			//Get the passed in object, get its class name, get the definition of it for type, cast to class
			var TemplateObj:Class = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(whatItem)) as Class;

			newItem = new ISOBoardObject();
			newItem.setGraphic(new TemplateObj());
			newItem.graphic.x = Globals.stage.mouseX;
			newItem.graphic.y = Globals.stage.mouseY;
			
			Globals.stage.addChild(newItem.graphic);
			
			newItem.graphic.alpha = 0.5;
			
			Globals.stage.addEventListener(Event.ENTER_FRAME, loop);
			newItem.graphic.addEventListener(MouseEvent.CLICK,placeOnMap);
			
			//Mouse.hide();
			//Make New Instance, and follow mouse, snap to grid
			//Listen for Click on Stage, place in position
		}
		private function loop(e:Event):void
		{
			/*
			var mouseLayerPos:Point = Globals.engine.screenToLayerSpace(new Point(Globals.stage.mouseX,Globals.stage.mouseY));
			this._txt_mouseOverGridTile.text = String(Globals.engine.getLayerToISO(mouseLayerPos));
			*/
			var mouseLayerPos:Point = Globals.engine.screenToLayerSpace(new Point(Globals.stage.mouseX,Globals.stage.mouseY));
			//trace('mouseLayerPos',mouseLayerPos);
			var mouseIsoPos:Point = Globals.engine.getLayerToISO(mouseLayerPos);
			//trace('mouseIsoPos',mouseIsoPos);
			newItem.setTilePosition(mouseIsoPos.x,mouseIsoPos.y);
			//trace('newItem.tilePos',newItem.tilePos);
			//SET the screen position again with the new iso position. Look out for offset
			var tempPosLayer:Point = Globals.engine.getISOToLayer(new Point(newItem.tilePos.x, newItem.tilePos.y));
			//trace('tempPosLayer',tempPosLayer);
			//tempPosLayer.y *= -1;
			//trace('tempPosLayer',tempPosLayer);
			var tempPosScreen:Point = Globals.engine.layerToScreenSpace(tempPosLayer);
			
			newItem.graphic.x = tempPosScreen.x;
			newItem.graphic.y = tempPosScreen.y;//TEST TEST
			
			
		}
		
		private function placeOnMap(e:MouseEvent):void
		{
			if(0 <= newItem.tilePos.x && newItem.tilePos.x < Globals.gridSize.x &&
				0 <= newItem.tilePos.y && newItem.tilePos.y < Globals.gridSize.y)
			{
				trace('success');
				//Set Graphics to use Layer Position
				var layerPos:Point = Globals.engine.screenToLayerSpace(new Point(newItem.graphic.x,newItem.graphic.y));
				
				newItem.graphic.x = layerPos.x;
				newItem.graphic.y = layerPos.y;
				
				Globals.engine._AddToScene(newItem);
				Globals.stage.removeEventListener(Event.ENTER_FRAME, loop);
				newItem.graphic.removeEventListener(MouseEvent.CLICK,placeOnMap);
				newItem = null;
				
				Mouse.show();
			} else {
				trace('out of bounds');
			}
			
		}
		
		
	}
}