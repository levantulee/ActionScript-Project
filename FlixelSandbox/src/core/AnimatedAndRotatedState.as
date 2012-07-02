package core
{
	
	import assets.FlxSpriteAniRot;
	import assets.AssetsList;
	
	import org.flixel.*;
	
	public class AnimatedAndRotatedState extends FlxState
	{
	
		private var aniRotSprt:FlxSpriteAniRot;
		public function AnimatedAndRotatedState():void
		{
			aniRotSprt = new FlxSpriteAniRot(AssetsList.animatedTile,360,100,100);
			add(aniRotSprt);
		}
		
		
		
		override public function update():void
		{
			super.update(); //Update Loop in FlxState attachment
			aniRotSprt.angle += 1;
		}
	}
}