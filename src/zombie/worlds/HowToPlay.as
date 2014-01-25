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
	public class HowToPlay extends World
	{
		private var _sfx : Sfx;
		
		public function HowToPlay() 
		{
            var titleText:Text = new Text("Objective: You have to save as many people as you can.\r\n           Hug them to save'em with your love.");
            var textEntity:Entity = new Entity(0,0,titleText);
            textEntity.x = (FP.width/2)-(titleText.width/2);
            textEntity.y = (FP.height/4*1.7)-(titleText.height/2) - 60;
            add(textEntity);
            
			var titleText2:Text = new Text("Movement: Keyboard Arrows or WASD\r\n");
            var textEntity2:Entity = new Entity(0,0,titleText2);
            textEntity2.x = (FP.width/2)-(titleText2.width/2);
            textEntity2.y = (FP.height/4*2.7)-(titleText2.height/2) - 60;
            add(textEntity2);
            
            
            var button : Button = new Button(Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED, "Return", FP.width / 2 - 64, FP.height / 4 * 2.7, 128, 32, Return);
			button.active = true;
			add(button);
			
			_sfx = new Sfx(Assets.MUSIC_CREDITS);
			_sfx.loop();
		}
		
        public function Return() : void
		{
            _sfx.stop();
            FP.world = new TitleScreen();
		}
	}

}