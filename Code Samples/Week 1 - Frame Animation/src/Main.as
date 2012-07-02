package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon
	 */
	
	 
	public class Main extends Sprite 
	{
		
		private var o:grayBoxGraphic = new grayBoxGraphic(); //make a new instance of grayBoxGraphic
		
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
			addChild(o);//add object to stage
			
			addEventListener(Event.ENTER_FRAME,moveMe);
		}
		
		
		private function moveMe(event:Event):void{
			o.x += 1;
		}
		
	}
	
}