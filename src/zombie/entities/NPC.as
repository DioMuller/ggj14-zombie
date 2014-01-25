package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.graphics.Spritemap;
	import zombie.Assets;
	import zombie.behaviors.FleeBehavior;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class NPC extends GameEntity
	{
		
		public function NPC(x:Number, y:Number) 
		{
			super(x, y);
			
			animation = new Spritemap(Assets.SPRITE_NPC_00, 16, 16);
			animation.add("stand", [6, 7, 8], 5, true);
			animation.add("run", [0, 1, 2, 3, 4, 5], 5, true);
			animation.scale = 2;
			
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			addBehavior(new FleeBehavior());
			
			type = "enemy";
			//addBehavior(new ControlableBehavior());
		}
		
		override public function update():void 
		{
			super.update();
			
			if ( collide("player", x, y) )
			{
				TurnIntoNPC();
			}
		}
		
		public function TurnIntoNPC()
		{
			type = "npc";
			
			animation = new Spritemap(Assets.SPRITE_NPC_04, 16, 16);
			animation.add("stand", [6, 7, 8], 5, true);
			animation.add("run", [0, 1, 2, 3, 4, 5], 5, true);
			animation.scale = 2;
			
			graphic = animation;
		}
		
	}

}