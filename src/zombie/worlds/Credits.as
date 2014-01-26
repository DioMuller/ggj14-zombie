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
	public class Credits extends World
	{
		private var _sfx:Sfx;
		private var textBasePosY:Number;
		private var textBasePosX:Number = 0;
		
		public function Credits()
		{
			textBasePosY = FP.height / 7;
			
			CreateCategory("Game Design", "Diogo Muller de Miranda\r\nRicardo Takeda");
			CreateCategory("Developers ", "Diogo Muller de Miranda\r\nJoao Vitor Pietsiaki Moraes\r\nErik Onuki");
			CreateCategory("Game Art", "Diogo Muller de Miranda\r\nRicardo Takeda");
			CreateCategory("Music and Sound Effects", "Ricardo Takeda");
			
			var button:Button = new Button(Assets.BUTTON_NORMAL, Assets.BUTTON_OVER, Assets.BUTTON_PRESSED, "Return", FP.width / 2 - 64, textBasePosY + 20, 128, 32, Return);
			button.active = true;
			add(button);
			
			_sfx = new Sfx(Assets.MUSIC_CREDITS);
			_sfx.loop();
		}
		
		public function Return():void
		{
			_sfx.stop();
			FP.world = new TitleScreen();
		}
		
		private function CreateCategory(title:String, text:String):void
		{
			var cat1Title:Text = new Text(title);
			cat1Title.color = 0x00ff00;
			cat1Title.size = 24;
			var cat1TitleEnt:Entity = new Entity(0, 0, cat1Title);
			cat1TitleEnt.x = textBasePosX == 0 ? (FP.width / 2) - (cat1Title.width / 2) : textBasePosX;
			cat1TitleEnt.y = textBasePosY;
			add(cat1TitleEnt);
			textBasePosY += cat1Title.height;
			
			if (textBasePosX == 0)
				textBasePosX = cat1TitleEnt.x;
			
			var cat1Text:Text = new Text(text);
			var cat1TextEnt:Entity = new Entity(0, 0, cat1Text);
			cat1TextEnt.x = textBasePosX == 0 ? cat1TitleEnt.x : textBasePosX;
			cat1TextEnt.y = textBasePosY;
			add(cat1TextEnt);
			textBasePosY += cat1Text.height + 20;
		}
	}

}