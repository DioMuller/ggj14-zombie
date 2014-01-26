package zombie.entities 
{
	import fplib.base.GameEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import zombie.Assets;
	import zombie.behaviors.ZombieBehavior;
	import net.flashpunk.FP;
	import zombie.worlds.GameWorld;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class NPC extends GameEntity
	{
		private var _hugging : Boolean = false;
		protected var _isZombie : Boolean = false;
		protected var _humanAnimation : Spritemap;
		
		private var zombieNpcMessage: Array;
		private var zombieSavedMessage: Array;
		private var humanNpcMessage: Array;
		private var humanZombifiedMessage: Array;
		
		protected var _zombieSound : Sfx;
		protected var _humanSound : Sfx;
		
		public var _baloonText:Text;
		public var _baloonEntity:Entity;
		public var _baloonStr:String;
		public var _baloonTextTimer:Number;
		
		public function NPC(x:Number, y:Number) 
		{
			super(x, y);
			
			var num : int = int( Math.round( Math.random() * 3 ) );
			
			animation = new Spritemap(Assets.SPRITE_NPC_ZOMBIE[num], 16, 16);
			animation.add("stand", [6, 7, 8], 5, true);
			animation.add("run", [0, 1, 2, 3, 4, 5], 5, true);
			animation.add("hug", [12, 13, 14], 3, false);
			animation.scale = 2;
			
			_humanAnimation = new Spritemap(Assets.SPRITE_NPC_NORMAL[num], 16, 16);
			_humanAnimation.add("stand", [6, 7, 8], 5, true);
			_humanAnimation.add("run", [0, 1, 2, 3, 4, 5], 5, true);
			_humanAnimation.add("hug", [12, 13, 14], 3, false);
			_humanAnimation.scale = 2;
			
			_zombieSound = new Sfx(Assets.SOUND_ZOMBIE);
			_humanSound = new Sfx(Assets.SOUND_ZOMBIE);
			
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			addBehavior(new ZombieBehavior());
			
			type = "enemy";
			
			zombieNpcMessage = [
				"GAHH!",
				"BLHRRHHRH!",
				"BRAINS",
				"BR41NNSS",
				"#GGJCWB"
			];
			
			zombieSavedMessage = [
				"Thank you!",
				"I love you Mr!",
				"I almost died due to fatigue! Can't program so much!",
				"Help the others please!",
				"I'll follow you!"
			];
			
			humanNpcMessage = [
				"HEEEELLLLPPP A ZOMBIEEEE",
				"OH NO A PROGRAMER BROKE FREE!",
				"APOCALYPSE IS COMING!",
				"Don't get any closer!",
				"NOOOOOOOOOOOO!!!!!!"
			];
			
			humanZombifiedMessage = [
				"AGHHH",
				"HE GOT ME!",
				"BURRRRR",
				"BRAAAAINNNNNNSSS",
				"..............."
			];
		}
		
		override public function update():void 
		{
			
			if (!_baloonEntity)
			{
				_baloonText = new Text("");
				_baloonText.size = 8;
				_baloonText.color = 0xffff00;
				_baloonEntity = new Entity(x, y - 15, _baloonText);
				_baloonEntity.layer = -2000;
				FP.world.add(_baloonEntity);
				_baloonTextTimer = 0;
				randomZombieNpcMessage();
			}
			
			_baloonEntity.x = x;
			_baloonEntity.y = y - 15;
			_baloonTextTimer -= FP.elapsed;
			if (_baloonTextTimer <= 0) {
				_baloonStr = "";
			}
			
			(_baloonEntity.graphic as Text).text = _baloonStr;
			
			if ( !_hugging )
			{
				super.update();
				
				if (  ((FP.world as GameWorld).IsEvil && ! _isZombie) ||
				(!(FP.world as GameWorld).IsEvil && _isZombie) )
				{
					revert();
				}
				
				if ( collide("player", x, y) && type == "enemy" )
				{
					var p : Player = (FP.world.nearestToEntity("player", this, false) as Player);
					y = p.y;
					x = p.x;
					
					p.hug();
					_hugging = true;
					
					if( !_isZombie ) _zombieSound.play();
					//else _humanSound.play();
					
					(graphic as Spritemap).play("hug");
                    (graphic as Spritemap).flipped = (p.graphic as Spritemap).flipped;
					
					if (!(FP.world as GameWorld).IsEvil) 
					{
						randomZombieSavedMessage(true);
					}
					else 
					{
						randomHumanZombifiedMessage(true);
					}
				}
			}
			else
			{
                if ((graphic as Spritemap).complete) {
                    TurnIntoNPC();
                    _hugging = false;
                }
			}
		}
		
		public function TurnIntoNPC() : void
		{
			type = "npc";
			
			GameManager.score++;
			
			if ( !_isZombie )
			{
				graphic = _humanAnimation;				
			}
			else
			{
				graphic = animation;
			}
		}
		
		public function revert() : void
		{
			if ( (!_isZombie && type == "npc") || (_isZombie && type == "enemy") )
			{
				graphic = animation;
			}
			else
			{
				graphic = _humanAnimation;
			}
			
			_isZombie = !_isZombie;
		}
		
		public function randomZombieNpcMessage(override:Boolean = false) : void
		{
			if(_baloonStr == "" || override) {
				_baloonStr = zombieNpcMessage[int(Math.random() * (zombieNpcMessage.length-1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xff5555;
			}
		}
		
		public function randomZombieSavedMessage(override:Boolean = false) : void
		{
			if(_baloonStr == "" || override) {
				_baloonStr = zombieSavedMessage[int(Math.random() * (zombieSavedMessage.length-1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xffff00;
			}
		}
		
		public function randomHumanNpcMessage(override:Boolean = false) : void
		{
			if (_baloonStr == "" || override) {
				_baloonStr = humanNpcMessage[int(Math.random() * (humanNpcMessage.length-1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xffff00;
			}
		}
		
		public function randomHumanZombifiedMessage(override:Boolean = false) : void
		{
			if(_baloonStr == "" || override) {
				_baloonStr = humanZombifiedMessage[int(Math.random() * (humanZombifiedMessage.length-1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xff5555;
			}
		}
		
	}

}