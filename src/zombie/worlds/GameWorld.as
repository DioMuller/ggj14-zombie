package zombie.worlds 
{
	import fplib.maping.EntityCreator;
	import fplib.maping.OgmoMap;
	import zombie.entities.GameManager;
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class GameWorld extends OgmoMap
	{
		private var _gameManager : GameManager;
		
		public function GameWorld(levelAsset : Class, mainTileSetAsset : Class, secondaryTileSetAsset : Class, backgroundAsset : Class, entityCreator : EntityCreator, bgmAsset : Class = null) 
		{
			super(levelAsset, mainTileSetAsset, secondaryTileSetAsset, backgroundAsset, entityCreator, bgmAsset);
			
			_gameManager = new GameManager();
			
			add(_gameManager);
		}
		
	}

}