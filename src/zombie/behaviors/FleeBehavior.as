package zombie.behaviors 
{
	import fplib.base.Behavior;
	import fplib.base.GameEntity;
	import fplib.math.Vector2D
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class FleeBehavior extends Behavior
	{
		private var _target : GameEntity = null;
		
		public var minimumDistance = 100;
		
		public function FleeBehavior() 
		{
			
		}
		
		override public function update():void 
		{
			if ( ! _target )
			{
				_target = FP.world.nearestToEntity("player", parent) as GameEntity;
			}
			else
			{
			
				var desiredVelocity : Vector2D = Vector2D.subtract(parent.position, _target.position);
				var distance : Number = desiredVelocity.Size;
				
				if( distance < 100 )
				{
					desiredVelocity.normalize();
					desiredVelocity = Vector2D.multiply(desiredVelocity, FP.elapsed * 30);
					parent.animation.play("run");
				}
				else
				{
					desiredVelocity = Vector2D.ZERO;
					parent.animation.play("stand");
				}
				
				parent.position = Vector2D.add(parent.position, desiredVelocity);
			}
		}
		
	}

}