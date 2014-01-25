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
    import fplib.gui.Button;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class EndScreen extends World
	{
		private var _sfx : Sfx;
		
		public function EndScreen() 
		{
			var titleText:Text = new Text("You zombified " + GameManager.score + " people.");
            var textEntity:Entity = new Entity(0,0,titleText);
            textEntity.x = (FP.width/2)-(titleText.width/2);
            textEntity.y = (FP.height/2)-(titleText.height/2) - 60;
            add(textEntity);
            
            var button : Button = new Button(Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED, "Title Screen", FP.width / 2 - 64, FP.height / 2, 128, 32, ResetGame);
			button.active = true;
			add(button);
			
			_sfx = new Sfx(Assets.MUSIC_CREDITS);
			_sfx.loop();
		}
		
        public function ResetGame() : void
		{
            _sfx.stop();
            FP.world = new TitleScreen();
		}
	}

}