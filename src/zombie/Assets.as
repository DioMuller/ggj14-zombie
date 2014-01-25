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
		
		/* MAPS */
		[Embed(source = "../../assets/maps/MainMap.oel", mimeType = "application/octet-stream")] public static const MAP_MAIN : Class;
		
		/* SPRITES */
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
		
		/* MUSIC */
		[Embed(source = "../../assets/music/bgm01.mp3")] public static const MUSIC_BGM01 : Class;
	}

}