/**
 * This Class generates a animated spritesheet from a rotation spritesheet that is generated from a single image file
 * The idea is to use the loadRotatedGraphic call which generates a rotation spritesheet, we then translate this spritesheet
 * into a fully vertical sheet that is representing an animation loop.
 * To get appropriate animation we must pixel copy from the approriate location in the sheet into a animation container.
 * The flow is as follows:
 * LoadRotatedGraphic
 * ->Loop through it's sheet(arranged in a 2d array square layout sheetMaxDimesionX/Y = Math.ceil(Math.sqrt(amount of rotation samples))
 *   and copy the pixels of the sprite sample into a new bitmap data offset in the Y direction by the images (original image not sheet) height
 * -> This generates an animation of the rotated sprite as an addAnimation loop.
 * 
 * WARNING: Doing this will not allow yo to set the rotation via the angle property anymore. You would have to specifythe angle as a position
 * 			of pixelsquare in the animation sheet.
 * 			
 * 			Alpha mask is not yet copied!
 * 
 * 
 * */

package assets
{
	import assets.AssetsList;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flixel.FlxSprite;
	
	public class GenerateAnimatedFromRotated extends FlxSprite
	{
		
		private var direction:String;
		private var animationA:Array = new Array();
		private var bmd:BitmapData;
		
		public function GenerateAnimatedFromRotated(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			var rotations:uint = 64;
			var sheetMaxDimesion:int = Math.ceil(Math.sqrt(rotations));
			
			//Load the graphic, create rotations every 10 degrees
			//org.flixel.FlxSprite.loadRotatedGraphic(Graphic:Class, Rotations:uint=16, Frame:int=-1, AntiAliasing:Boolean=false, AutoBuffer:Boolean=false):FlxSprite
			loadRotatedGraphic(AssetsList.isoTile,rotations,-1,true,false);
			
			//Loop through the rotated sheets and pull out the generated graphic and assemble in a animation sheet.
			var spriteA:Array = new Array();
			
			//Data is stored in a 2d array fashion horizontal to vertical.
			bmd = new BitmapData(width,height*rotations);//Bitmap data container at the height size of all frames
			
			//Loop through the individual data to pull out the rotation an reassemble in a long vertical
			var counter:int = 0;
			for(var i:uint = 0; i < sheetMaxDimesion; i++){//Vertical
				for(var j:uint = 0; j < sheetMaxDimesion; j++){//Horizontal
					var tempbmd:BitmapData = new BitmapData(height,width);//Temp container which we draw into the correct position later
					var rect:Rectangle = new Rectangle(j*width,i*height,width,height);
					tempbmd.copyPixels(this.pixels,rect,new Point(0,0),null,null,false);//get the current pixel data
					
					var moveM:Matrix = new Matrix(1,0,0,1,0,height*counter);
					bmd.draw(tempbmd,moveM);
					counter++;
				}
			}		
			
			var bmp:Bitmap = new Bitmap(pixels);	//store it in a new bitmap
			pixels = bmp.bitmapData;
			
			
			//Create the animation array frames
			//say in how many frame intervals we go another step
			//DONE - DON'T MESS WITH IT
			var fps:uint = 30;
			for(var k:uint = 0; k < rotations; k++){
				animationA.push(k);
			}
			addAnimation("0",animationA,fps,true);

			direction = "0";
		}
		
		
		private var frameCounter:uint = 0;
		
		override public function update():void
		{
			if(frameCounter > animationA.length){
				frameCounter = 0;
			}
			var moveM:Matrix = new Matrix(1,0,0,1,0,height*frameCounter);
			super.update();
			//Play animation
			//pixels.draw(bmd,moveM);
			
			frameCounter++;
			
			
		}
		
		//DONE - DON'T MESS WITH IT
		public function giveMeArt():BitmapData{
			return bmd;
		}
		//DONE - DON'T MESS WITH IT
		public function giveMeAnimation():Array{
			return animationA;
		}
		
	}
}