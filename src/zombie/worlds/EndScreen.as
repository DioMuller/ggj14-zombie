package zombie.worlds 
{
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.flashpunk.graphics.Text;
	import zombie.Assets;
	import zombie.CustomCreator;
	import zombie.entities.GameManager;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class EndScreen extends World
	{
		private var _sfx : Sfx;
		
		public function EndScreen() 
		{
			var titleText:Text = new Text("You 'saved' " + GameManager.score + " people.");
            var textEntity:Entity = new Entity(0,0,titleText);
            textEntity.x = (FP.width/2)-(titleText.width/2);
            textEntity.y = (FP.height/2)-(titleText.height/2);
            add(textEntity);
			
			var titleText2:Text = new Text("Press X to Return to Title Screen");
			var textEntity2:Entity = new Entity(0,0,titleText2);
            textEntity2.x = (FP.width/2)-(titleText2.width/2);
            textEntity2.y = (FP.height/2)-(titleText2.height/2) + 100;
            add(textEntity2);
			
			_sfx = new Sfx(Assets.MUSIC_CREDITS);
			_sfx.loop();
		}
		
		override public function update():void 
		{
            if (Input.check(Key.X)) 
			{
				_sfx.stop();
                FP.world = new TitleScreen();
            }
        }
		
	}

}