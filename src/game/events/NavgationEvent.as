package game.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class NavgationEvent extends Event 
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		
		public function NavgationEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
	}
}