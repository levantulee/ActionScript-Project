package BlittingEngine 
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
		
		public function Scene() 
		{
			all_Layers = new Sprite();
			addChild(all_Layers);
			//Background Layer
			background = new Sprite();
			all_Layers.addChild(background);
			//Main Layer
			main = new Sprite();
			all_Layers.addChild(main);
			//Foreground Layer
			foreground = new Sprite();
			all_Layers.addChild(foreground);
			
			//Globals.stage.addChild(this);
			//this.visible = false;
			//trace(background.parent, this.parent);
		}
		
	}

}