package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.Entity;
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
		private var _hugging : int = 0;
		private var _isZombie : Boolean = false;
		
		private var _animationZombie : Spritemap;
		
		public function Player( x : Number, y : Number ) 
		{
			super(x, y);
			
			animation = new Spritemap(Assets.SPRITE_MAIN_NORMAL, 16, 16);
			animation.add("stand", [6, 7, 8], 10, true);
			animation.add("run", [0, 1, 2], 10, true);
			animation.add("hug", [9, 10, 11], 3, true);
			animation.scale = 2;
			
			//_animationZombie = new Spritemap(Assets.SPRITE_MAIN_ZOMBIE, 16, 16);
			/*_animationZombie.add("stand", [6, 7, 8], 10, true);
			_animationZombie.add("run", [0, 1, 2], 10, true);
			_animationZombie.add("hug", [9, 10, 11], 3, true);
			_animationZombie.scale = 2;
			*/
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			type = "player";
			
			addBehavior(new CameraBehavior());
			addBehavior(new ControlableBehavior());
		}
		
		override public function update():void 
		{
			if ( _hugging < 0 )
			{
				super.update();
			}
			else
			{
				_hugging--;
			}
			
		}
		
		public function hug() : void
		{
			animation.play("hug");
			_hugging = 60;
		}
		
		public function revert() : void
		{
			if ( _isZombie )
			{
				
			}
			else
			{
				
			}
			
			_isZombie = !_isZombie;
		}
	}

}