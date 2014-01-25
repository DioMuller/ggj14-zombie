package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import zombie.behaviors.DebugInfoBehavior;
	
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
			
			timer -= FP.elapsed;
			
			(graphic as Text).text = "Score: " + score + " Time: " + timer.toFixed(0);
		}
		
		public static function reset() : void
		{
			score = 0;
			timer = 60;
		}
		
	}

}