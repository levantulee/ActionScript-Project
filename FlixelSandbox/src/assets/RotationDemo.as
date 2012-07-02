package assets
{
	import org.flixel.FlxSprite;
	
	public class RotationDemo extends FlxSprite
	{
		public function RotationDemo(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			loadGraphic(AssetsList.Circle1,false,false,AssetsList.Circle1.width,AssetsList.Circle1.height,false);
			this.angle = 10;
		}
		public function test():void
		{
			
		}
	}
}