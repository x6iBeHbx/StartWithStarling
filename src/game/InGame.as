package game
{
	import flash.utils.getTimer;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class InGame extends Sprite
	{
		private var startButton:Button;
		private var hero:Hero;
		private var bg:GameBackground;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var gameState:String;
		
		public function InGame()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawGame();
		}
		
		private function drawGame():void
		{
			bg = new GameBackground();
			bg.speed = 10;
			this.addChild(bg);
			
			hero = new Hero();
			hero.x = stage.stageWidth / 2;
			hero.y = stage.stageHeight / 2;
			
			this.addChild(hero);
			
			startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			startButton.x = stage.stageWidth * 0.5 - startButton.width * 0.5;
			startButton.y = stage.stageHeight * 0.5 - startButton.height * 0.5;
			this.addChild(startButton);
		}
		
		private function initialize():void
		{
			
			this.addEventListener(Event.ENTER_FRAME, checkElapsed);
			
			hero.x = -stage.stageWidth;
			hero.y = stage.stageHeight * 0.5;
			
			gameState = "idle";
			
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClicked);
		}
		
		private function onStartButtonClicked(e:Event):void
		{
			startButton.visible = false;
			startButton.removeEventListener(Event.TRIGGERED, onStartButtonClicked);
			
			launchHero();
		}
		
		private function launchHero():void
		{
			
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		private function onGameTick(e:Event):void
		{
			switch (gameState)
			{
			case "idle": 
				break;
			case "flying": 
				break;
			case "over": 
				break;
			}
		}
		
		private function checkElapsed(e:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			
			elapsed = (timeCurrent - timePrevious) * 0.001;
		}
	
	}

}