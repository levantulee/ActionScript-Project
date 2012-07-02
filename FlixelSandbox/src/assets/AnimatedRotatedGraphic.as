/**
 * Based on the code by Hectate via http://flashgamedojo.com/wiki/index.php?title=Mouse-Aim_Tutorial_(Flixel)
 * */

package assets
{
	import org.flixel.FlxSprite;
	
	public class AnimatedRotatedGraphicExtended extends FlxSprite
	{
		public function AnimatedRotatedGraphicExtended(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(AssetsList.ImgPlayerupper, true, false, 32, 32);
			addAnimation("0", [0]);
			addAnimation("1", [1]);
			addAnimation("2", [2]);
			addAnimation("3", [3]);
			addAnimation("4", [4]);
			addAnimation("5", [5]);
			addAnimation("6", [6]);
			addAnimation("7", [7]);
			addAnimation("8", [8]);
			addAnimation("9", [9]);
			addAnimation("10", [10]);
			addAnimation("11", [11]);
			addAnimation("12", [12]);
			addAnimation("13", [13]);
			addAnimation("14", [14]);
			addAnimation("15", [15]);
			
		}
		public function chooseAngle(aimAngle:int):void
		{
			
			if (aimAngle > -11.75 && aimAngle < 11.75)
			{
				play("0");
			}
			else if(aimAngle > 11.75 && aimAngle < 34.25)
			{
				play("1");
			}
			else if (aimAngle > 34.25 && aimAngle < 56.75)
			{
				play("2");
			}
			else if (aimAngle > 56.75 && aimAngle < 79.25)
			{
				play("3");
			}
			else if (aimAngle > 79.25 && aimAngle < 101.75)
			{
				play("4");
			}
			else if (aimAngle > 101.75 && aimAngle < 124.25)
			{
				play("5");
			}
			else if (aimAngle > 124.25 && aimAngle < 146.75)
			{
				play("6");
			}
			else if (aimAngle > 146.75 && aimAngle < 169.25)
			{
				play("7");
			}
				//This next one must be OR (||) instead of AND (&&) because, unlike the rest, both of these statements will never be true simultaneously.
				//The reason for this is because, as previously noted, the angles do not come out as 0 to 360, but -180 to 180.
				//This particular angle points directly left (-x).
			else if (aimAngle > 169.25 || aimAngle < -169.25)
			{
				play("8");
			}
			else if (aimAngle > -169.25 && aimAngle < -146.75)
			{
				play("9");
			}
			else if (aimAngle > -146.75 && aimAngle < -124.25)
			{
				play("10");
			}
			else if (aimAngle > -124.25 && aimAngle < -101.75)
			{
				play("11");
			}
			else if (aimAngle > -101.75 && aimAngle < -79.25)
			{
				play("12");
			}
			else if (aimAngle > -79.25 && aimAngle < -56.75)
			{
				play("13");
			}
			else if (aimAngle > -56.75 && aimAngle < -34.25)
			{
				play("14");
			}
			else //(aimAngle > -34.25 && aimAngle < -11.75)
			{
				play("15");
			}
		}
	}
}