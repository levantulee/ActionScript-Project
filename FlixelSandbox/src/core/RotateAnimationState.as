package core
{
	import assets.AnimatedRotatedGraphicExtended;
	import assets.RotationDemo;
	import assets.AssetsList;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.flixel.*;
	import org.osmf.events.TimeEvent;
	
	public class RotateAnimationState extends FlxState
	{
		private var isoTile:FlxSprite = new FlxSprite(50,50,AssetsList.squareTile);
		private var squareTile:FlxSprite = new FlxSprite(100,50,AssetsList.squareTile);
		private var tempSprite:Sprite = new Sprite();
		
		private var angle:int = 0;
		
		//Art Instances
		private var animatedAsset:AnimatedRotatedGraphicExtended;
		private var animatedAsset2:AnimatedRotatedGraphicExtended;
		private var extremeAnimationA:Array = new Array();
		
		public function RotateAnimationState():void
		{
			//Create a sprite instance
			animatedAsset = new AnimatedRotatedGraphicExtended(100,100)
			add(animatedAsset);
			
			//Create another to test overlay
			animatedAsset2 = new AnimatedRotatedGraphicExtended(110,110)
			add(animatedAsset2);
			
			//Extreme Animation Test (note, 40 instances alow the application still to run at 30 fps on a 2008 macbook pro)
			for(var i:uint = 0; i < 40; i++){
				for(var j:uint = 0; j < 40; j++){
					var newAnimation:AnimatedRotatedGraphicExtended = new AnimatedRotatedGraphicExtended(15*i,15*j);
					extremeAnimationA.push(newAnimation);
					//add(newAnimation);
				}
			}
		}
		
		
		
		override public function update():void
		{
			super.update(); //Update Loop in FlxState attachment
			
			//Each time the animation loops to the end rotate to a new angle.
			if(int(animatedAsset.frame/16) == animatedAsset.frames/16-1){
				angle += 15;//Change the angle
			}
			if(angle > 180){
				angle = -180;//Loop around the back
			}
			
			//Set the new sprite angle in sprite sheet
			animatedAsset.chooseAngle(angle);
			//animatedAsset2.chooseAngle(angle);
			
			//Update all graphics in array
			for(var i:uint = 0; i < extremeAnimationA.length; i++){
				extremeAnimationA[i].chooseAngle(angle);
			}
			
		}
	}
}