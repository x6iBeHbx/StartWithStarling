package game
{
	import game.events.NavgationEvent;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class Game extends Sprite
	{
		private var welcomeScreen:Welcome;
		private var inGameScreen:InGame;
		
		public function Game()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.addEventListener(NavgationEvent.CHANGE_SCREEN, onChangeScreen);
			
			welcomeScreen = new Welcome();
			addChild(welcomeScreen);
			welcomeScreen.initialize();
		}
		
		private function onChangeScreen(e:NavgationEvent):void
		{
			switch (e.data.id)
			{
				case "play": 
					
					inGameScreen = new InGame();
					this.addChild(inGameScreen);
					
					this.removeChild(welcomeScreen);
					welcomeScreen.dispose();
					break;
			}
		}
	
	}

}