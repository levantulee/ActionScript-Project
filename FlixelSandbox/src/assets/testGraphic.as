package assets
{
	import org.flixel.FlxSprite;
	
	public class testGraphic extends FlxSprite
	{
		public function testGraphic(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			loadGraphic(AssetsList.isoTile,false,false,AssetsList.isoTile.width,AssetsList.isoTile.height,false);
			this.angle = 10;
		}
		public function test():void
		{
			
		}
	}
}