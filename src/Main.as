package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import game.Game;
	import game.InGames;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	[SWF(frameRate="60", width="1024", height="768", backgroundColor="0x000000")]
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