package zombie
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import fplib.maping.OgmoMap;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(800, 600, 60, false);
			
			FP.world = new OgmoMap(
						Assets.MAP_MAIN,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_BACKGROUND,
						new CustomCreator() );
		}
		
	}
	
}