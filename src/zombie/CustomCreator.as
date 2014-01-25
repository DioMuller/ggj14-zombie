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
				return new Player( xml["@x"] as Number, xml["@y"] as Number  );
			}
			else if ( type == "enemy")
			{
				return new NPC( xml["@x"] as Number, xml["@y"] as Number  );
			}
			
			return null;
		}
		
	}

}