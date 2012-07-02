package  
{
	import flash.events.*;
	/**
	 * ...
	 * @author Simon
	 */
	public class LeopardTank extends Tank
	{
		
		public function LeopardTank(_x:int = 0 ,_y:int = 0) 
		{
			super(_x, _y);
			
			this.gotoAndStop('LeopardTank');
			
			//this.addEventListener(MouseEvent.CLICK, mouseClick);
		
		}
		
		private function mouseClick(e:MouseEvent):void
		{
			//deleteObject();
		}
		
		public override function deleteObject():void
		{
			trace('I am deleting me');
			
			this.removeEventListener(MouseEvent.CLICK, mouseClick);
			
			super.deleteObject();
		}
		
	}

}