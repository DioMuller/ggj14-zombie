package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.graphics.Spritemap;
	import zombie.behaviors.CameraBehavior;
	import zombie.Assets;
	import zombie.behaviors.ControlableBehavior;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class Player extends GameEntity
	{
		
		public function Player( x : Number, y : Number ) 
		{
			super(x, y);
			
			animation = new Spritemap(Assets.SPRITE_MAIN_00, 16, 16);
			animation.add("stand", [6, 7, 8], 10, true);
			animation.add("run", [0, 1, 2, 3, 4, 5], 10, true);
			animation.scale = 2;
			
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			addBehavior(new CameraBehavior());
			addBehavior(new ControlableBehavior());
		}
		
	}

}