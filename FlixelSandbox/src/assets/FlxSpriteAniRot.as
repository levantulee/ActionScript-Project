/**
 * FlxSpriteAniRot
 * 
 * Creating animated and rotated sprite from an un-rotated animated image.
 * 
 * @version 1.0 - November 8th 2011
 * @link http://www.gameonaut.com
 * @author Simon Etienne Rozner / Gameonaut.com
*/

package assets
{	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flixel.FlxSprite;
	
	public class FlxSpriteAniRot extends FlxSprite
	{
		private var rotationRefA:Array = new Array();
		private var rect:Rectangle;
		private var rotations:uint;
		private var sheetMaxDimesion:int;
		
		private var framesAmount:uint;
		private var frameCounter:uint = 0;
		
		public function FlxSpriteAniRot(animatedAsset:Class, rotationSamples:uint, X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			loadGraphic(animatedAsset,true,false); //Just to get the amount of frames
			framesAmount = frames;//Length of Animation
			rotations = rotationSamples;
			sheetMaxDimesion = Math.ceil(Math.sqrt(rotations))
			
			//Load the graphic, create rotations every 10 degrees
			for(var i:uint = 0; i < framesAmount; i++){
				loadRotatedGraphic(animatedAsset,rotations,i,true,false);//Create the rotation spritesheet for that frame
				var bmd:BitmapData = new BitmapData(width*sheetMaxDimesion,height*sheetMaxDimesion,true,0x00000000);//Create a bitmapData container
				rect = new Rectangle(0,0,width*sheetMaxDimesion,height*sheetMaxDimesion);
				bmd.copyPixels(pixels,rect,new Point(0,0),pixels,new Point(0,0),true);//get the current pixel data
				
				rotationRefA.push(bmd);//store it for reference.
			}			
		}
		
		
		override public function update():void
		{
			animateSprite();
			super.update();
		}
		
		private function animateSprite():void{
			
			if(frameCounter > framesAmount-1){
				frameCounter = 0;
			}
			
			pixels.fillRect(rect,0x00000000);//clear out blank to avoid artefacts
			pixels.copyPixels(rotationRefA[frameCounter],rect,new Point(0,0),rotationRefA[frameCounter],new Point(0,0),true);
			drawFrame(true);//enforce update since this is not an animated frame in the traditional sense
			
			frameCounter++;
		}
	}
}