package zombie.worlds 
{
	import fplib.gui.Button;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;
    import net.flashpunk.graphics.Text;
	import zombie.Assets;
	import zombie.CustomCreator;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class TitleScreen extends World
	{
		private var _sfx : Sfx;
		
		public function TitleScreen() 
		{
			var btStartGame : Button = new Button(
			Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED, "New Game", FP.width / 2 - 64, FP.height / 2 - 60, 128, 32, NewGame);
			add(btStartGame);
            
            var btHowToPlay : Button = new Button(
			Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED, "How to Play", FP.width / 2 - 64, FP.height / 2 - 20, 128, 32, ShowHowToPlay);
			add(btHowToPlay);
            
            var btShowCredits : Button = new Button(
			Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED, "Credits", FP.width / 2 - 64, FP.height / 2 + 20, 128, 32, ShowCredits);
			add(btShowCredits);
			
            var splashText:Text = new Text("POWER OF LOVE");
            splashText.color = 0xff0000;
            splashText.size = 64;
            var splashEntity:Entity = new Entity(0,0,splashText);
            splashEntity.x = (FP.width/2)-(splashText.width/2);
            splashEntity.y = 100;
            add(splashEntity);
			
			var infoText:Text = new Text("Global Game Jam 2014");
            infoText.color = 0xffffff;
            infoText.size = 16;
            var infoEntity:Entity = new Entity(0,0,infoText);
            infoEntity.x = (FP.width/2)-(infoText.width/2);
            infoEntity.y = 500;
            add(infoEntity);
			
			_sfx = new Sfx(( int( Math.random() * 10 ) != 0 )? Assets.MUSIC_OPENING : Assets.MUSIC_EASTEREGG);
			_sfx.loop();
		}
		
		public function NewGame() : void
		{
			_sfx.stop();
			FP.world = new GameWorld(
						Assets.MAP_MAIN,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_EVILTILE,
						Assets.IMAGE_BACKGROUND,
						new CustomCreator(),
						Assets.MUSIC_BGM04); // ( int( Math.random() * 2 ) < 1 )? Assets.MUSIC_BGM01 : Assets.MUSIC_BGM04);
		}
        
        public function ShowHowToPlay() : void
		{
			//_sfx.stop();
			FP.world = new HowToPlay();
		}
        
        public function ShowCredits() : void
		{
			_sfx.stop();
			FP.world = new Credits();
		}
	}
}