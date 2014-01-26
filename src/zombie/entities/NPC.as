package zombie.entities
{
	import flash.display.BitmapData;
	import fplib.base.GameEntity;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
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
		private var _hugging:Boolean = false;
		protected var _isZombie:Boolean = false;
		protected var _humanAnimation:Spritemap;
		
		private var zombieNpcMessage:Array;
		private var zombieSavedMessage:Array;
		private var humanNpcMessage:Array;
		private var humanZombifiedMessage:Array;
		
		public var _baloonText:Text;
		public var _baloonEntity:Entity;
		public var _baloonStr:String;
		public var _baloonTextTimer:Number;
		
		private var _bloodEmitter:Emitter;
		private var _loveEmitter:Emitter;
		private var _loveEmitterCap:int;
		
		public function NPC(x:Number, y:Number)
		{
			super(x, y);
			
			var num:int = int(Math.round(Math.random() * 3));
			
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
			
			graphic = animation;
			
			setHitbox(8, 32, -8, 0);
			
			addBehavior(new ZombieBehavior());
			
			type = "enemy";
			
			zombieNpcMessage = ["GAHH!", "BLHRRHHRH!", "BRAINS", "BR41NNSS", "#GGJCWB"];
			
			zombieSavedMessage = ["Thank you!", "I love you Mr!", "I almost died due to fatigue! Can't program so much!", "Help the others please!", "I'll follow you!"];
			
			humanNpcMessage = ["HEEEELLLLPPP A ZOMBIEEEE", "OH NO A PROGRAMER BROKE FREE!", "APOCALYPSE IS COMING!", "Don't get any closer!", "NOOOOOOOOOOOO!!!!!!"];
			
			humanZombifiedMessage = ["AGHHH", "HE GOT ME!", "BURRRRR", "BRAAAAINNNNNNSSS", "..............."];
		}
		
		override public function update():void
		{
			if (!_bloodEmitter)
			{
				var bloodRange:int = 30;
				_bloodEmitter = new Emitter(Assets.PARTICLE_BLOOD, 4, 4);
				_bloodEmitter.newType("rightblood", [0]);
				_bloodEmitter.setAlpha("rightblood", 1, 0);
				_bloodEmitter.setColor("rightblood", 0xFF0000, 0x000000);
				_bloodEmitter.setMotion("rightblood", 90 - 45 + bloodRange, 40, 0.5, -bloodRange * 2, 0, 0, null);
				_bloodEmitter.setGravity("rightblood", 30, 1);
				_bloodEmitter.newType("leftblood", [0]);
				_bloodEmitter.setAlpha("leftblood", 1, 0);
				_bloodEmitter.setColor("leftblood", 0xFF0000, 0x000000);
				_bloodEmitter.setMotion("leftblood", 90 + 45 - bloodRange, 40, 0.5, bloodRange * 2, 0, 0, null);
				_bloodEmitter.setGravity("leftblood", 30, 1);
				_bloodEmitter.relative = false;
				
				_loveEmitter = new Emitter(Assets.PARTICLE_HEART, 8, 8);
				_loveEmitter.newType("heart", [0]);
				_loveEmitter.setAlpha("heart", 1, 0);
				_loveEmitter.setColor("heart", 0xFF0000, 0xffffff);
				_loveEmitter.setMotion("heart", 60, 30, 0.5, 60, 50, 0.5, null);
				_loveEmitter.setGravity("heart", 10, 1);
				
				var particleEnt:Entity = new Entity(0, 0);
				particleEnt.layer = 10;
				particleEnt.addGraphic(_bloodEmitter);
				particleEnt.addGraphic(_loveEmitter);
				FP.world.add(particleEnt);
			}
			
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
			if (_baloonTextTimer <= 0)
			{
				_baloonStr = "";
			}
			
			(_baloonEntity.graphic as Text).text = _baloonStr;
			
			if (!_hugging)
			{
				super.update();
				
				if (((FP.world as GameWorld).IsEvil && !_isZombie) || (!(FP.world as GameWorld).IsEvil && _isZombie))
				{
					revert();
				}
				
				if (collide("player", x, y) && type == "enemy")
				{
					var p:Player = (FP.world.nearestToEntity("player", this, false) as Player);
					y = p.y;
					x = p.x;
					
					p.hug();
					_hugging = true;
					
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
				if (!(FP.world as GameWorld).IsEvil)
				{
					if (_loveEmitterCap-- <= 0)
					{
						_loveEmitter.emit("heart", x + (graphic as Spritemap).width / 2, y + 10);
						_loveEmitterCap = 3;
					}
				}
				else
				{
					if ((graphic as Spritemap).flipped)
						_bloodEmitter.emit("leftblood", x + (graphic as Spritemap).width / 2, y + 10);
					else
						_bloodEmitter.emit("rightblood", x + (graphic as Spritemap).width * 1.25, y + 10);
				}
				
				if ((graphic as Spritemap).complete)
				{
					TurnIntoNPC();
					_hugging = false;
				}
			}
		}
		
		public function TurnIntoNPC():void
		{
			type = "npc";
			
			GameManager.score++;
			
			if (!_isZombie)
			{
				graphic = _humanAnimation;
			}
			else
			{
				graphic = animation;
			}
		}
		
		public function revert():void
		{
			if ((!_isZombie && type == "npc") || (_isZombie && type == "enemy"))
			{
				graphic = animation;
			}
			else
			{
				graphic = _humanAnimation;
			}
			
			_isZombie = !_isZombie;
		}
		
		public function randomZombieNpcMessage(override:Boolean = false):void
		{
			if (_baloonStr == "" || override)
			{
				_baloonStr = zombieNpcMessage[int(Math.random() * (zombieNpcMessage.length - 1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xff5555;
			}
		}
		
		public function randomZombieSavedMessage(override:Boolean = false):void
		{
			if (_baloonStr == "" || override)
			{
				_baloonStr = zombieSavedMessage[int(Math.random() * (zombieSavedMessage.length - 1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xffff00;
			}
		}
		
		public function randomHumanNpcMessage(override:Boolean = false):void
		{
			if (_baloonStr == "" || override)
			{
				_baloonStr = humanNpcMessage[int(Math.random() * (humanNpcMessage.length - 1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xffff00;
			}
		}
		
		public function randomHumanZombifiedMessage(override:Boolean = false):void
		{
			if (_baloonStr == "" || override)
			{
				_baloonStr = humanZombifiedMessage[int(Math.random() * (humanZombifiedMessage.length - 1))];
				_baloonTextTimer = 2;
				_baloonText.color = 0xff5555;
			}
		}
	}
}