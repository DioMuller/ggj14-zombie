package zombie.entities 
{
	import fplib.base.GameEntity;
	import fplib.maping.OgmoMap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import zombie.behaviors.DebugInfoBehavior;
	import zombie.worlds.EndScreen;
	import zombie.worlds.GameWorld;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class GameManager extends GameEntity
	{
		public static var score : int = 0;
		public static var timer : Number = 60;
		
		public var _text : Text;
		
		public function GameManager() 
		{
			reset();
			
			_text = new Text("Score: " + score + " Time: " + timer, 10, 10);
			_text.color = 0xffffff;
			_text.size = 16;
			_text.scrollX = _text.scrollY = 0;
			
			layer = -1000;
			
			graphic = _text;
			
			
			addBehavior(new DebugInfoBehavior());
		}
		
		override public function update():void 
		{
			super.update();
			
			var world : GameWorld = (FP.world as GameWorld);
			
			timer -= FP.elapsed;
			
			
			if ( timer < 30 && !world.IsEvil )
			{
				world.changeAlignment();
			}
			
			if ( timer < 0 )
			{
				world.stopMusic();
				FP.screen.scaleX = 1;
				FP.screen.scaleY = 1;
				FP.world = new EndScreen();
			}
			
			if( timer > 1.5 ) {
				(graphic as Text).text = "Score: " + score + " Time: " + timer.toFixed(0);
			}
			else {
				(graphic as Text).text = "Score: " + score + " Time: 1";
			}
		}
		
		public static function reset() : void
		{
			score = 0;
			timer = 60;
		}
		
	}

}