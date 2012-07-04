package 
{
	import IsoGameEngine.Camera;
	import IsoGameEngine.Editor.MapEditor;
	import IsoGameEngine.GameBoard.BaseTerrain;
	import IsoGameEngine.GraphicsEngine;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon
	 */
	[SWF(width="800", height="600", framerate="60", backgroundColor="#AAAAAA")]

	public class Main extends Sprite 
	{

		
		
		
		private var key:KeyObject;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//stage.addChild( new Stats() );
			
			var engine:GraphicsEngine = new GraphicsEngine(stage);
			Globals.engine = engine;
			
			var camera:Camera = new Camera();
			
			var gui:_GUI_Border = new _GUI_Border;
			stage.addChild(gui);
			
			
			editor = new MapEditor();
			editor.visible = false;
			
			Globals.stage.addChild(editor)
				
			this.addEventListener(Event.ENTER_FRAME, loop);
			key = new KeyObject(Globals.stage);
		}
		
		private function loop(e:Event):void
		{
			if(key.isDown(key.E))
			{
				toggleEditor();
			}
		}
		
		private var editor:MapEditor;
		private function toggleEditor():void
		{
			
			if(editor.visible)
			{
				editor.visible = false;
			} else {
				editor.visible = true;
			}
				
		}
		
	}
	
}