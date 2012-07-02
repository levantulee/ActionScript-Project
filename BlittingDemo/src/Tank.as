package  
{
	//import flash.display.MovieClip;
	import flash.events.*;
	import Globals;
	
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author YongHe
	 */
	public class Tank extends _Tank
	{
		//private var turret:_Turret;
		private var movement:int = 5;
		private var rotate:int = 5;
		private var key:KeyObject = new KeyObject(Globals.stage);
		
		
		public function Tank(_x:int = 0 ,_y:int = 0) 
		{
			this.x = _x;	
			this.y = _y;
			
			this.gotoAndStop('DefaultTank');
			//this.stop();
			
			//Globals.gameObjects.push(this);
			
			Globals.engine._AddToScene(this);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		private function loop(e:Event):void 
		{
			//cout stuff for debug using trace(whatever)
			//trace("ding");
			this.play();
			
			if (key.isDown(Keyboard.UP))
			{
				this.y -= movement;
			}
			if (key.isDown(Keyboard.DOWN))
			{
				this.y += movement;
			}
			
			if (key.isDown(Keyboard.LEFT))
			{
				this.x -= movement;
			}
			if (key.isDown(Keyboard.RIGHT))
			{
				this.x += movement;
			}
			
			
			//this.rotation += rotate;
			//this.x += movement;
			
			//if (this.x > stage.stageWidth || this.x < 0)
			//{
				//movement = -movement;
				//rotate	 = -rotate;
			//}
		
		}
		
		public function deleteObject():void
		{
			//this.removeEventListener(Event.ENTER_FRAME, loop);
			
			Globals.engine.RemoveFromScene(this);
			
			//var index:int = Globals.gameObjects.indexOf(this);
			//Globals.gameObjects.splice(index, 1);
			
			Globals.deleteObject(this);
		}
		
	}

}