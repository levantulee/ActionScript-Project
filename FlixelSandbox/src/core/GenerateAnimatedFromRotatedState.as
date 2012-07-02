package core
{
	import assets.AnimationTest;
	import assets.AssetsList;
	import assets.GenerateAnimatedFromRotated;
	
	import flash.display.BitmapData;
	
	import org.flixel.*;
	
	public class GenerateAnimatedFromRotatedState extends FlxState
	{
		private var angle:int = 0;
		
		//Art Instances
		private var rotatedAsset:GenerateAnimatedFromRotated;
		private var extremeAnimationA:Array = new Array();
		private var animatedAsset:FlxSprite = new FlxSprite();
		
		public function GenerateAnimatedFromRotatedState():void
		{
			rotatedAsset = new GenerateAnimatedFromRotated(100,100)
			add(rotatedAsset);
			
			
			//DONE - DON'T MESS WITH IT
			animatedAsset.x = 200;
			animatedAsset.y = 100;
			animatedAsset.loadGraphic(AssetsList.animatedTile,true,false,48,48,false);
			animatedAsset.pixels = rotatedAsset.giveMeArt();
			animatedAsset.frameHeight = 48;//Ensure the sample height is correct
			animatedAsset.height = 48;
			animatedAsset.addAnimation("0",rotatedAsset.giveMeAnimation(),60,true);
			add(animatedAsset);
			
		}
		
		
		
		override public function update():void
		{
			super.update(); //Update Loop in FlxState attachment
			
		}
	}
}