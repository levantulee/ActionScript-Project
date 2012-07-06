package IsoGameEngine 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Simon
	 */
	public class Scene extends Sprite 
	{
		public var background:Sprite;
		public var main:Sprite;
		public var foreground:Sprite
		
		public var all_Layers:Sprite;
		
		//SET ALL LAYERS IN GLOBALS MANUALLY!
		
		public function Scene() 
		{
			all_Layers = new Sprite();
			all_Layers.name = 'all_Layers';
			addChild(all_Layers);
			//Background Layer
			background = new Sprite();
			background.name = 'background';
			all_Layers.addChild(background);
			//Main Layer
			main = new Sprite();
			main.name = 'main';
			all_Layers.addChild(main);
			//Foreground Layer
			foreground = new Sprite();
			foreground.name = 'foreground';
			all_Layers.addChild(foreground);
		}
		
	}

}