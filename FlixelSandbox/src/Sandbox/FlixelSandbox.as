package Sandbox
{
	//Flash Imports
	import Debug.Stats;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import core.Globals;
	import core.DefaultState;
	import core.RotateAnimationState;
	import core.GenerateAnimatedFromRotatedState;
	import core.AnimatedAndRotatedState;
	
	import org.flixel.*;
	
	[SWF(width = "720", height = "512", frameRate = "120", backgroundColor = "0x333333")]
	
	public class FlixelSandbox  extends FlxGame
	{
		public function FlixelSandbox():void
		{
			//Init the default game state
			//super(Globals.gameWidth, Globals.gameHeight,DefaultState, Globals.gameZoom, 60, 120,true);
			
			//Using rotation and animation in the same flx sprite, rotation is embedded within the spritesheet
			//super(Globals.gameWidth, Globals.gameHeight,RotateAnimationState, Globals.gameZoom, 60, 120,true);
			
			//Generate animation using a rotated spritesheet. (not animated)
			//super(Globals.gameWidth, Globals.gameHeight,GenerateAnimatedFromRotatedState, Globals.gameZoom, 60, 120,true);
			
			//Generate rotation and animation from a simple animation sheet that doesnt contain a rotaiton in the spritesheet.
			super(Globals.gameWidth, Globals.gameHeight,AnimatedAndRotatedState, Globals.gameZoom, 60, 120,true);
			
			
			forceDebugger = true;
						
			//Add stats
			FlxG.stage.addChild(new Stats());
		}
	}
}