package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Game;
	import game.InGame;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	[SWF(width="720", height="640", frameRate="60", backgroundColor="#808080")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_starling = new Starling(Game, stage);
			_starling.antiAliasing = 1;
            _starling.start();
		}
		
	}
	
}