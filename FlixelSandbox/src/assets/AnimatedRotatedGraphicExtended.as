/**
 * Based on the code by Hectate via http://flashgamedojo.com/wiki/index.php?title=Mouse-Aim_Tutorial_(Flixel)
 * */

package assets
{
	import org.flixel.FlxSprite;
	
	public class AnimatedRotatedGraphicExtended extends FlxSprite
	{
		
		private var direction:String;
		
		public function AnimatedRotatedGraphicExtended(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			//Load the graphic, flag as animation
			//loadGraphic(Graphic:Class, Animated:Boolean = false, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0, Unique:Boolean = false):FlxSprite
			loadGraphic(AssetsList.ImgPlayerupperAnimatedExtended, true, false, 32, 32);
			
			//Add the animations to the sprite
			//org.flixel.FlxSprite.addAnimation(Name:String, Frames:Array, FrameRate:Number=0, Looped:Boolean=true)
			addAnimation("X", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 30, true);
			addAnimation("0", [0, 16, 32, 48, 64, 80, 96, 112, 96, 80, 64, 48, 32, 16], 30, true);
			addAnimation("1", [1, 17, 33, 49, 65, 81, 97, 113, 97, 81, 65, 49, 33, 17], 30, true);
			addAnimation("2", [2, 18, 34, 50, 66, 82, 98, 114, 98, 82, 66, 50, 34, 18], 30, true);
			addAnimation("3", [3, 19, 35, 51, 67, 83, 99, 115, 99, 83, 67, 51, 35, 19], 30, true);
			addAnimation("4", [4, 20, 36, 52, 68, 84, 100, 116, 100, 84, 68, 52, 36, 20], 30, true);
			addAnimation("5", [5, 21, 37, 53, 69, 85, 101, 117, 101, 85, 69, 53, 37, 21], 30, true);
			addAnimation("6", [6, 22, 38, 54, 70, 86, 102, 118, 102, 86, 70, 54, 38, 22], 30, true);
			addAnimation("7", [7, 23, 39, 55, 71, 87, 103, 119, 103, 87, 71, 55, 39, 23], 30, true);
			addAnimation("8", [8, 24, 40, 56, 72, 88, 104, 120, 104, 88, 72, 56, 40, 24], 30, true);
			addAnimation("9", [9, 25, 41, 57, 73, 89, 105, 121, 105, 89, 73, 57, 41, 25], 30, true);
			addAnimation("10", [10, 26, 42, 58, 74, 90, 106, 122, 106, 90, 74, 58, 42, 26], 30, true);
			addAnimation("11", [11, 27, 43, 59, 75, 91, 107, 123, 107, 91, 75, 59, 43, 27], 30, true);
			addAnimation("12", [12, 28, 44, 60, 76, 92, 108, 124, 108, 92, 76, 60, 44, 28], 30, true);
			addAnimation("13", [13, 29, 45, 61, 77, 93, 109, 125, 109, 93, 77, 61, 45, 29], 30, true);
			addAnimation("14", [14, 30, 46, 62, 78, 94, 110, 126, 110, 94, 78, 62, 46, 30], 30, true);
			addAnimation("15", [15, 31, 47, 63, 79, 95, 111, 127, 111, 95, 79, 63, 47, 31], 30, true);
			
			direction = "X";
			
		}
		public function chooseAngle(aimAngle:int):void
		{
			
			if (aimAngle > -11.75 && aimAngle < 11.75)
			{
				direction = "0";
			}
			else if(aimAngle > 11.75 && aimAngle < 34.25)
			{
				direction = "1";
			}
			else if (aimAngle > 34.25 && aimAngle < 56.75)
			{
				direction = "2";
			}
			else if (aimAngle > 56.75 && aimAngle < 79.25)
			{
				direction = "3";
			}
			else if (aimAngle > 79.25 && aimAngle < 101.75)
			{
				direction = "4";
			}
			else if (aimAngle > 101.75 && aimAngle < 124.25)
			{
				direction = "5";
			}
			else if (aimAngle > 124.25 && aimAngle < 146.75)
			{
				direction = "6";
			}
			else if (aimAngle > 146.75 && aimAngle < 169.25)
			{
				direction = "7";
			}
				//This next one must be OR (||) instead of AND (&&) because, unlike the rest, both of these statements will never be true simultaneously.
				//The reason for this is because, as previously noted, the angles do not come out as 0 to 360, but -180 to 180.
				//This particular angle points directly left (-x).
			else if (aimAngle > 169.25 || aimAngle < -169.25)
			{
				direction = "8";
			}
			else if (aimAngle > -169.25 && aimAngle < -146.75)
			{
				direction = "9";
			}
			else if (aimAngle > -146.75 && aimAngle < -124.25)
			{
				direction = "10";
			}
			else if (aimAngle > -124.25 && aimAngle < -101.75)
			{
				direction = "11";
			}
			else if (aimAngle > -101.75 && aimAngle < -79.25)
			{
				direction = "12";
			}
			else if (aimAngle > -79.25 && aimAngle < -56.75)
			{
				direction = "13";
			}
			else if (aimAngle > -56.75 && aimAngle < -34.25)
			{
				direction = "14";
			}
			else //(aimAngle > -34.25 && aimAngle < -11.75)
			{
				direction = "15";
			}
		}
		
		override public function update():void
		{
			super.update();
			play(direction);
		}
		
	}
}