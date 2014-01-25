package fplib.math.steering 
{
	import fplib.math.PhysicsBehavior;
	import fplib.math.PhysicsEntity;
	import fplib.math.Vector2D;
	import net.flashpunk.FP;
	import fplib.math.Units;
	
	/**
	 * Base steering behavior.
	 * @author Diogo Muller
	 */
	public class Steering extends PhysicsBehavior
	{
		public var searchAtXFrames : Number = 10;
		
		protected var _toSearch : Number = 0;
		protected var _target : PhysicsEntity = null;
		
		public function Steering()
		{
			super();
		}
		
		override public function update():void 
		{
			super.update();
			
			_toSearch--;
			
			if ( _toSearch <= 0 )
			{
				_target = FP.world.nearestToEntity("player", physicsParent) as PhysicsEntity;
			}
			
			if ( _target )
			{
				parent.position = Vector2D.add( parent.position, calculate());
			}
		}
		
		public function calculate() : Vector2D
		{
			return Vector2D.ZERO;
		}
		
	}

}