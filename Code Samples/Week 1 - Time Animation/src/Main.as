package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Main extends Sprite 
	{
		
		private var o:grayBoxGraphic = new grayBoxGraphic(); //make a new instance of object
		private var previousTimer:int = getTimer();//get the current time since the movie started
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			o.x = 50; //set X and Y location
			o.y = 120;
			stage.addChild(o);//add object to stage
			
			addEventListener(Event.ENTER_FRAME,moveMe);
		}
		
		
		private function moveMe(event:Event):void{
			var timeDifference:int = getTimer()-previousTimer;
			previousTimer += timeDifference;
			o.x += timeDifference*0.1
		}
		
	}
	
}