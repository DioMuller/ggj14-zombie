package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import zombie.behaviors.CameraBehavior;
	import zombie.Assets;
	import zombie.behaviors.ControlableBehavior;
	import net.flashpunk.FP;
	import zombie.worlds.GameWorld;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class Player extends GameEntity
	{
		private var _hugging : Boolean = false;
		private var _isZombie : Boolean = false;
		
		private var _animationZombie : Spritemap;
		
		public function Player( x : Number, y : Number ) 
		{
			super(x, y);
			
			animation = new Spritemap(Assets.SPRITE_MAIN_NORMAL, 16, 16);
			animation.add("stand", [6, 7, 8], 10, true);
			animation.add("run", [0, 1, 2], 10, true);
			animation.add("hug", [9, 10, 11], 3, false);
			animation.scale = 2;
			
			_animationZombie = new Spritemap(Assets.SPRITE_MAIN_ZOMBIE, 16, 16);
			_animationZombie.add("stand", [6, 7, 8], 10, true);
			_animationZombie.add("run", [0, 1, 2], 10, true);
			_animationZombie.add("hug", [9, 10, 11], 3, false);
			_animationZombie.scale = 2;
			
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			type = "player";
			
			addBehavior(new CameraBehavior());
			addBehavior(new ControlableBehavior());
		}
		
		override public function update():void 
		{
			if (  ((FP.world as GameWorld).IsEvil && ! _isZombie) ||
			(!(FP.world as GameWorld).IsEvil && _isZombie) )
			{
				revert();
			}
			if ( !_hugging )
			{
				super.update();
			}
			else
			{
				if ((graphic as Spritemap).complete)
                    _hugging = false;
			}
			
		}
		
		public function hug() : void
		{
			(graphic as Spritemap).play("hug");
			_hugging = true;
		}
		
		public function revert() : void
		{
			if ( _isZombie )
			{
				graphic = animation;
			}
			else
			{
				graphic = _animationZombie;
			}
			
			_isZombie = !_isZombie;
		}
	}

}