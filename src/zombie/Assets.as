package zombie 
{
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class Assets 
	{
		/* IMAGES */
		[Embed(source = "../../assets/images/background.png")] public static const IMAGE_BACKGROUND : Class;
		
		/* TILESETS */
		[Embed(source = "../../assets/images/tileset.png")] public static const IMAGE_TILESET : Class;
		[Embed(source = "../../assets/images/tileset2.png")] public static const IMAGE_EVILTILE : Class;
		
		/* MAPS */
		[Embed(source = "../../assets/maps/MainMap.oel", mimeType = "application/octet-stream")] public static const MAP_MAIN : Class;
		
		/* SPRITES */
		[Embed(source = "../../assets/images/main-normal.png")] public static const SPRITE_MAIN_NORMAL : Class;
		
		[Embed(source = "../../assets/images/npc-normal.png")] public static const SPRITE_NPC_NORMAL : Class;
		[Embed(source = "../../assets/images/npc-zombie.png")] public static const SPRITE_NPC_ZOMBIE : Class;
		
		[Embed(source = "../../assets/images/MainCharacter 00.png")] public static const SPRITE_MAIN_00 : Class;
		[Embed(source = "../../assets/images/MainCharacter 01.png")] public static const SPRITE_MAIN_01 : Class;
		[Embed(source = "../../assets/images/MainCharacter 02.png")] public static const SPRITE_MAIN_02 : Class;
		[Embed(source = "../../assets/images/MainCharacter 03.png")] public static const SPRITE_MAIN_03 : Class;
		[Embed(source = "../../assets/images/MainCharacter 04.png")] public static const SPRITE_MAIN_04 : Class;
		
		[Embed(source = "../../assets/images/NPC 00.png")] public static const SPRITE_NPC_00 : Class;
		[Embed(source = "../../assets/images/NPC 01.png")] public static const SPRITE_NPC_01 : Class;
		[Embed(source = "../../assets/images/NPC 02.png")] public static const SPRITE_NPC_02 : Class;
		[Embed(source = "../../assets/images/NPC 03.png")] public static const SPRITE_NPC_03 : Class;
		[Embed(source = "../../assets/images/NPC 04.png")] public static const SPRITE_NPC_04 : Class;
		
		/* BUTTON */
		[Embed(source = "../../assets/images/ButtonBase.png")] public static const BUTTON_NORMAL : Class;
		[Embed(source = "../../assets/images/ButtonOver.png")] public static const BUTTON_OVER : Class;
		[Embed(source = "../../assets/images/ButtonPressed.png")] public static const BUTTON_PRESSED : Class;
		
		/* MUSIC */
		[Embed(source = "../../assets/music/mus loop.mp3")] public static const MUSIC_BGM01 : Class;
		[Embed(source = "../../assets/music/zumclov.mp3")] public static const MUSIC_CREDITS : Class;
	}

}