package zombie.behaviors 
{
	import fplib.base.Behavior;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class CameraBehavior extends Behavior
	{
		
		public function CameraBehavior() 
		{
			FP.screen.scaleX = 2;
			FP.screen.scaleY = 2;
		}
		
		override public function update():void 
		{
			super.update();
			
			FP.camera.x = Math.max( 0, Math.min((1920 - FP.screen.width), parent.position.X - 100));
			FP.camera.y = Math.max( 0, Math.min((1080 - FP.screen.height), parent.position.Y - 100));
		}
		
	}

}