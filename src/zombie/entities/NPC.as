package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.graphics.Spritemap;
	import zombie.Assets;
	import zombie.behaviors.ZombieBehavior;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class NPC extends GameEntity
	{
		private var _hugging : int = 0;
		
		public function NPC(x:Number, y:Number) 
		{
			super(x, y);
			
			animation = new Spritemap(Assets.SPRITE_NPC_ZOMBIE, 16, 16);
			animation.add("stand", [6, 7, 8], 5, true);
			animation.add("run", [0, 1, 2, 3, 4, 5], 5, true);
			animation.add("hug", [12, 13, 14], 3, true);
			animation.scale = 2;
			
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			addBehavior(new ZombieBehavior());
			
			type = "enemy";
			//addBehavior(new ControlableBehavior());
		}
		
		override public function update():void 
		{
			if ( _hugging == 0 )
			{
				super.update();
				
				if ( collide("player", x, y) && type == "enemy" )
				{
					var p : Player = (FP.world.nearestToEntity("player", this, false) as Player);
					y = p.y;
					x = p.x;
					
					TurnIntoNPC();
					
					p.hug();
					_hugging = 60;
					
					animation.play("hug");
                    animation.flipped = p.animation.flipped;
				}
			}
			else
			{
				_hugging--;
			}
		}
		
		public function TurnIntoNPC() : void
		{
			type = "npc";
			
			animation = new Spritemap(Assets.SPRITE_NPC_NORMAL, 16, 16);
			animation.add("stand", [6, 7, 8], 5, true);
			animation.add("run", [0, 1, 2], 5, true);
			animation.add("hug", [12, 13, 14], 3, true);
			
			
			animation.scale = 2;
			
			GameManager.score++;
			
			graphic = animation;
		}
		
	}

}