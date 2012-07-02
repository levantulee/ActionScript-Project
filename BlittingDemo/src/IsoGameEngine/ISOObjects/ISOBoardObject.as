package IsoGameEngine.ISOObjects
{
	import IsoGameEngine.Tools.Point3;
	
	import flash.display.Sprite;
	
	public class ISOBoardObject
	{
		
		public var graphic:Sprite;
		public var position:Point3;
		
		public function ISOBoardObject()
		{
			init();
		}
		
		public function init():void
		{
			
		}
		
		public function setPosition(_x:int = 0, _y:int = 0, _z:int = 0):void{
			position = new Point3(_x,_y,_z);
			graphic.x = position.x;
			graphic.y = position.y;
		}
		
		public var tilePos:Point3;
		public function setTilePosition(_x:int = 0, _y:int = 0, _z:int = 0):void{
			tilePos = new Point3(_x,_y,_z);
		}
		
		public function setGraphic(whatGraphic:Sprite):void
		{
			graphic = whatGraphic;
		}
	}
}