package BlittingEngine 
{
	import adobe.utils.CustomActions;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	/**
	 * ...
	 * @author Simon
	 * 
	 * USE this to add in the main class:
	 * var engine:GraphicsEngine = new GraphicsEngine(stage);
		Globals.engine = engine;
	 * 
	 * Use ADD to Scene and Remove from Scene to add to render pipeline.
	 */
	public class GraphicsEngine
	{
		public var scene:Scene;
		private var sceneBmp:Bitmap;
		private var sceneBmpData:BitmapData;
		
		//private var camera:Camera;
		
		public function GraphicsEngine(stage:Stage) 
		{
			Globals.stage = stage;
			init();
		}
		
		public function init():void
		{
			scene = new Scene();
		
			sceneBmpData = new BitmapData(Globals.stage.stageWidth,Globals.stage.stageHeight);
            sceneBmp = new Bitmap(sceneBmpData);
			
			Globals.stage.addChildAt(sceneBmp, 0);
			
			//camera = new Camera();
			
			scene.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			sceneBmpData.fillRect(sceneBmpData.rect,0);
            sceneBmpData.draw(scene);
		}
		
		public function _AddToScene(item:*):void
		{
			scene.main.addChild(item);
		}
		
		public function _RemoveFromScene(item:Sprite):void
		{
			scene.main.removeChild(item);
		}
		
		public function _AddToBackground(item:*):void
		{
			scene.background.addChild(item);
		}
		
		public function _RemoveFromBackground(item:Sprite):void
		{
			scene.background.removeChild(item);
		}
		
		public function _AddToForeground(item:*):void
		{
			scene.foreground.addChild(item);
		}
		
		public function _RemoveFromForeground(item:Sprite):void
		{
			scene.foreground.removeChild(item);
		}
		
	}
}