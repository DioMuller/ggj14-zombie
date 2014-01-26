package zombie.worlds 
{
	import fplib.maping.EntityCreator;
	import fplib.maping.OgmoMap;
    import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Sfx;
	import zombie.entities.GameManager;
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
    import zombie.entities.OldMan;
	import zombie.Assets;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class GameWorld extends OgmoMap
	{
		private var _gameManager : GameManager;
        private var _oldMan : OldMan;
        private var _oldManText : Text;
        private var _oldManTextEnt : Entity;
		
		private var _statusText : Text;
		private var _statusTextEnt : Entity;
		
		protected var _evilMainTile : Tilemap;		
		protected var _evilSecondaryTile : Tilemap;
		
		protected var _isEvil : Boolean = false;
		
		public function GameWorld(levelAsset : Class, mainTileSetAsset : Class, secondaryTileSetAsset : Class, backgroundAsset : Class, entityCreator : EntityCreator, bgmAsset : Class = null) 
		{
			super(levelAsset, mainTileSetAsset, secondaryTileSetAsset, backgroundAsset, entityCreator, bgmAsset);
            
            _gameManager = new GameManager();
            _oldMan = new OldMan();
            
            _oldManText = new Text("");
            _oldManText.size = 12;
            _oldManText.color = 0xffffff;
			
            _oldMan.layer = -1000;
            
            
			_oldManText = new Text("");
            _oldManText.size = 12;
            _oldManText.color = 0xffffff;
			
            _oldManTextEnt = new Entity(0, 0, _oldManText);
            _oldManTextEnt.graphic.scrollX = _oldManTextEnt.graphic.scrollY = 0;
			_oldManTextEnt.layer = -1000;
			
			_statusText = new Text("");
            _statusText.size = 12;
            _statusText.color = 0xffffff;
			
			_statusTextEnt = new Entity( (FP.screen.width - _statusText.width - 10)/2, 10, _statusText );
			_statusTextEnt.graphic.scrollX = _statusTextEnt.graphic.scrollY = 0;
			_statusTextEnt.layer = -1000;
			
            add(_oldManTextEnt);
            add(_gameManager);
            add(_oldMan);
			add(_statusTextEnt);
            
            setOldMan(false, "Save as many people as you can!");
			setStatusText("Your Vision");
		}
        
        private function setOldMan(evil : Boolean, text : String) : void
        {
            _oldManText.text = text;
            _oldMan.setEvil(evil);
            _oldMan.x = ((FP.width / 2 - (_oldMan.width + _oldManText.textWidth))) / 2;
            _oldMan.y = (FP.height / 2 - _oldMan.height);
            _oldManTextEnt.x = _oldMan.x + _oldMan.width;
            _oldManTextEnt.y = _oldMan.y + (_oldMan.height - _oldManText.height)/ 2;
        }
		
		private function setStatusText(text : String) : void
		{
			_statusText.text = text;
            _statusTextEnt.x = (FP.screen.width - (_statusText.width * 2) - 10) / 2;
			_statusTextEnt.graphic = _statusText;
		}
		
		//{ region Constructor Helper Methods
		/**
		 * Constructor auxiliary function, initializes world from a OGMO map.
		 * @param	levelAsset Level (OGMO file) asset reference.
		 * @param	mainTileSetAsset Main Tileset asset reference.
		 * @param	secondaryTileSetAsset Secondary Tileset asset reference.
		 * @param	backgroundAsset Background asset reference.
		 */
		protected override function createMap( levelAsset : Class, mainTileSetAsset : Class, secondaryTileSetAsset : Class, backgroundAsset : Class, bgmAsset : Class ) : void
		{
			//TODO: Load from any number of tilesets?
			
			if ( bgmAsset ) 
			{
				_sfx = new Sfx(bgmAsset);
				_sfx.loop();
			}
			
			// Loads XML.
			var xmlData : XML = FP.getXML( levelAsset );
			
			// Map properties
			_mapWidth = xmlData["@width"];
			_mapHeight = xmlData["@height"];
			// TODO: Load from file?
			_tileSize = 16;
			
			// Loads a backdrop.
			_background = new Backdrop(backgroundAsset);
			// TODO: Create property so we can change this anytime.
			_background.scrollX = 0.5;
			_background.scrollY = 0.5;
			_backgroundEntity = new Entity( 0, 0, _background );
			_backgroundEntity.layer = 1001;
			add(_backgroundEntity);
			
			// Loads collision layer.
			_mapGrid = new Grid( _mapWidth, _mapHeight, _tileSize, _tileSize );
			_mapGrid.loadFromString( String( xmlData["Collision"] ), "", "\n" );
			_mapImage = new Image( _mapGrid.data );
			_mapImage.scale = _tileSize;
			_mapGridEntity = new Entity( 0, 4, _mapImage, _mapGrid );
			_mapGridEntity.visible = false;
			_mapGridEntity.type = "solid";
			_mapGridEntity.layer = 1000;
			add(_mapGridEntity);
			
			// Load main tileset layer
			var x : XML;
			
			_mainTileLayer = new Tilemap( mainTileSetAsset, _mapWidth, _mapHeight, _tileSize, _tileSize);
			for each( x in xmlData["MainLayer"]["tile"] )
			{
				_mainTileLayer.setTile( int( x["@x"] ), int( x["@y"]), int( x["@id"] ) );
			}
			_mainTileLayerEntity = new Entity(0, 0, _mainTileLayer );
			_mainTileLayerEntity.layer = 999;
			add(_mainTileLayerEntity);
			
			_evilMainTile = new Tilemap( secondaryTileSetAsset, _mapWidth, _mapHeight, _tileSize, _tileSize);
			for each( x in xmlData["MainLayer"]["tile"] )
			{
				_evilMainTile.setTile( int( x["@x"] ), int( x["@y"]), int( x["@id"] ) );
			}
			
			// Load secondary tileset layer
			_secondaryTileLayer = new Tilemap( mainTileSetAsset, _mapWidth, _mapHeight, _tileSize, _tileSize);
			for each( x in xmlData["SecondaryLayer"]["tile"] )
			{
				_secondaryTileLayer.setTile( int( x["@x"] ), int( x["@y"]), int( x["@id"] ) );
			}
			_secondaryTileLayerEntity = new Entity(0, 0, _secondaryTileLayer );
			_secondaryTileLayerEntity.layer = -999;
			add(_secondaryTileLayerEntity);
			
			_evilSecondaryTile = new Tilemap( secondaryTileSetAsset, _mapWidth, _mapHeight, _tileSize, _tileSize);
			for each( x in xmlData["SecondaryLayer"]["tile"] )
			{
				_evilSecondaryTile.setTile( int( x["@x"] ), int( x["@y"]), int( x["@id"] ) );
			}
			
			createEntities(xmlData["Entities"]);
		}
		//} endregion Constructor Helper Methods
		
		public function changeAlignment() : void
		{
			if ( _isEvil )
			{
				_mainTileLayerEntity.graphic = _mainTileLayer;
				_secondaryTileLayerEntity.graphic = _secondaryTileLayer;
				_oldManText.color = 0xffffff;
				_statusText.color = 0xffffff;
				
				_sfx.stop();
				_sfx = new Sfx(Assets.MUSIC_BGM04); //( int( Math.random() * 2 ) < 1 )? new Sfx(Assets.MUSIC_BGM03) : new Sfx(Assets.MUSIC_BGM02);
				_sfx.play();
				
				_isEvil = false;
			}
			else
			{
				_mainTileLayerEntity.graphic = _evilMainTile;
				_secondaryTileLayerEntity.graphic = _evilSecondaryTile;
				_oldManText.color = 0xff0000;
				_statusText.color = 0xff0000;
				_statusText.size = 16;
				
				_sfx.stop();
				_sfx = new Sfx(Assets.MUSIC_BGM03); //( int( Math.random() * 2 ) < 1 )? new Sfx(Assets.MUSIC_BGM03) : new Sfx(Assets.MUSIC_BGM02);
				_sfx.play();
				
				_isEvil = true;
                setOldMan(true, "Get as many people as you can!");
				setStatusText("Their Vision");
			}
		}
		
		public function get IsEvil( ) : Boolean
		{
			return _isEvil;
		}
	}

}