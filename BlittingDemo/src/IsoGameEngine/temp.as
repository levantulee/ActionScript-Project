// ActionScript file


public function getScenePosition(screenObjectPos:Point):Point
{
	var mousePos:Point = new Point(screenObjectPos.x /*+ Globals.engine.scene.all_Layers.x*/  + Globals.tileSize.x/2, 
		screenObjectPos.y /*- Globals.engine.scene.all_Layers.y*/ + Globals.mapCenter.y);
	return mousePos;
}

public function getMapToScreen(mapPoint:Point ):Point
{
	var Scale:int = Globals.tileSize.x;
	var screenPoint:Point = new Point();
	screenPoint.x = 1 * (Scale / 2) * (mapPoint.x + mapPoint.y);
	screenPoint.y = 1 * (Scale / 4) * (mapPoint.y - mapPoint.x + Globals.gridSize.y);
	
	return screenPoint;
}

public function getScreenToMap(screenPoint:Point):Point
{
	var Scale:int = Globals.tileSize.x;
	var mapPoint:Point = new Point();
	screenPoint.x /= (Scale / 2);
	screenPoint.y /= (Scale / 4);
	
	mapPoint.x = (screenPoint.x - screenPoint.y) / 2;
	mapPoint.y = (screenPoint.x + screenPoint.y) / 2;
	
	
	
	//Transpate to correct position to account for offsets.
	mapPoint.x = Math.floor(1 * (mapPoint.x + Globals.gridSize.x));
	mapPoint.y = Math.floor(1 * (mapPoint.y - Globals.gridSize.y));
	
	
	
	return mapPoint;
}


/**
 * Get a clear position of a clicked tile and return its absolute value for inside the
 * game map for placement.
 * @return
 */
public function snapMouseFollowToTile():Point
{
	var mousePos:Point = getScenePosition(new Point(Globals.stage.mouseX,Globals.stage.mouseY));
	//trace(mousePos,'mousePos');
	var gridPoint:Point = getScreenToMap(mousePos);
	//trace(gridPoint,'gridPoint');
	
	var screenPoint:Point = getMapToScreen(gridPoint)
	//screenPoint.x -=  Globals.engine.scene.all_Layers.x;
	//trace(screenPoint,'screenPoint');
	return screenPoint;
}