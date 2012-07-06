package IsoGameEngine.SpecialEffects
{
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	public class OutlineFX
	{
		public function OutlineFX()
		{
			
		}
		public static function addOutlineFX(displayObject:*, color:uint,alpha:Number, blurDistance:Number, strenght:Number):void
		{
			var outline:GlowFilter=new GlowFilter(color,alpha,blurDistance,blurDistance,strenght);
			outline.quality=BitmapFilterQuality.HIGH;
			displayObject.filters=[outline];
		}
		public static function removeOutlineFX(displayObject:*):void
		{
			displayObject.filters = [];
		}
	}
}