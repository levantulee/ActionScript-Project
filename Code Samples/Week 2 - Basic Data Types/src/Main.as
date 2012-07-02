package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Main extends Sprite 
	{
		
		private var tf:TextField = new TextField(); //make a new instance of object
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
			tf.x = 12;
			tf.y = 12;
			tf.wordWrap = true;
			tf.width = 350;
			tf.border = true;
			tf.borderColor = 0x000000;
			
			var rand:Number = -1 * Math.random() * 1 - 1;

			stage.addChild(tf);//add object to stage
			
			var aNumber:Number = rand;
			var aInt:int = rand;
			var aUint:uint = uint(rand+5);
			var aString:String = "I am a string";

			tf.text = "aString: " + aString + "\n aNumber: " + aNumber + "\n aInt: " + aInt + "\n aUint: " + aUint;
		}
		
		
		
		
	}
	
}