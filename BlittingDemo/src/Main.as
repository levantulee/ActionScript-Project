package 
{
	import IsoGameEngine.Camera;
	import IsoGameEngine.GraphicsEngine;
	
	import IsoGameEngine.Editor.MapEditor;
	
	import IsoGameEngine.GameBoard.BaseTerrain;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Simon
	 */
	[SWF(width="800", height="600", framerate="60", backgroundColor="#AAAAAA")]

	public class Main extends Sprite 
	{
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addChild( new Stats() );
			
			var engine:GraphicsEngine = new GraphicsEngine(stage);
			Globals.engine = engine;
			
			
			var terrain:BaseTerrain = new BaseTerrain(30, 30, 25, 50, 4,4);
			
			var camera:Camera = new Camera();
			
			
			var gui:_GUI_Border = new _GUI_Border;
			stage.addChild(gui);
			
			var editor:MapEditor = new MapEditor();
			stage.addChild(editor);
			
		}
		
	}
	
}