package assets
{
	import org.flixel.FlxSprite;
	
	public class AnimationTest extends FlxSprite
	{
		public function AnimationTest(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			loadGraphic(AssetsList.ImgPlayerupper,true,false,32,32,false);
			addAnimation("0", [0, 1, 2, 3, 4, 5, 6,7,8,9,10], 30, true);
		}
		override public function update():void{
			super.update();
			play("0");
		}
	}
}