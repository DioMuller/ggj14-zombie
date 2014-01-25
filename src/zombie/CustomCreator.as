package zombie 
{
	import fplib.maping.EntityCreator;
	import net.flashpunk.Entity;
	import zombie.entities.Player;
	import zombie.entities.NPC;
	
	/**
	 * ...
	 * @author Diogo Muller
	 */
	public class CustomCreator extends EntityCreator
	{
		override public function CreateEntity(type:String, xml:XML):Entity 
		{
			if ( type == "player" )
			{
				return new Player( int(xml["@x"]), int(xml["@y"])  );
			}
			else if ( type == "enemy")
			{
				return new NPC( int(xml["@x"]), int(xml["@y"])  );
			}
			
			return null;
		}
		
	}

}