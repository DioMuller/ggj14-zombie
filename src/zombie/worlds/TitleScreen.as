package zombie.worlds 
{
	import fplib.gui.Button;
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
		
		public function TitleScreen() 
		{
			var titleText:Text = new Text("Press X to Start");
            var textEntity:Entity = new Entity(0,0,titleText);
            textEntity.x = (FP.width/2)-(titleText.width/2);
            textEntity.y = (FP.height/2)-(titleText.height/2);
            add(textEntity);
			
			var button : Button = new Button(
			Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED,"New Game", FP.width/2 - 120, FP.height/2 - 40, 240, 80, NewGame);
			
            var splashText:Text = new Text("POWER OF LOVE");
            splashText.color = 0x00ff00;
            splashText.size = 32;
            var splashEntity:Entity = new Entity(0,0,splashText);
            splashEntity.x = (FP.width/2)-(splashText.width/2);
            splashEntity.y = 100;
            add(splashEntity);
		}
		
		override public function update():void 
		{
            if (Input.check(Key.X)) 
			{
                FP.world = new GameWorld(
						Assets.MAP_MAIN,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_BACKGROUND,
						new CustomCreator(),
						Assets.MUSIC_BGM01);
            }
        }
		
		public function NewGame() : void
		{
			FP.world = new GameWorld(
						Assets.MAP_MAIN,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_TILESET,
						Assets.IMAGE_BACKGROUND,
						new CustomCreator(),
						Assets.MUSIC_BGM01);
		}
		
	}

}