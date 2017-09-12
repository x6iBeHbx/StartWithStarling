package game
{
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class InGames extends Sprite
	{
		private var startButton:Button;
		private var hero:Hero;
		private var bg:GameBackground;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var gameState:String;
		private var playerSpeed:Number;
		private var hitObstacle:Number = 0;
		private const MIN_SPEED:Number = 650;
		
		private var scoreDistance:int; 
		private var obstacleGapCount:int;
		
		private var gameArea:Rectangle;
		
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		
		private var obstacleToAnimate:Vector.<Obstacle>;
		
		public function InGames()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawGame();
			initialize();
		}
		
		private function drawGame():void
		{
			bg = new GameBackground();
			this.addChild(bg);
			
			hero = new Hero();
			hero.x = stage.stageWidth / 2;
			hero.y = stage.stageHeight / 2;
			
			this.addChild(hero);
			
			startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			startButton.x = stage.stageWidth * 0.5 - startButton.width * 0.5;
			startButton.y = stage.stageHeight * 0.5 - startButton.height * 0.5;
			this.addChild(startButton);
			
			gameArea = new Rectangle(0, 100, stage.stageWidth, stage.stageHeight - 250);
		}
		
		public function initialize():void
		{
			
			this.addEventListener(Event.ENTER_FRAME, checkElapsed);
			
			hero.x = -stage.stageWidth;
			hero.y = stage.stageHeight * 0.5;
			
			gameState = "idle";
			
			playerSpeed = 0;
			hitObstacle = 0;
			
			bg.speed = 0;
			scoreDistance = 0;
			obstacleGapCount = 0;
			
			obstacleToAnimate = new Vector.<Obstacle>();
			
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
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			touch = e.getTouch(stage);
			
			touchX = touch.globalX;
			touchY = touch.globalY;
		}
		
		private function onGameTick(e:Event):void
		{
			switch (gameState)
			{
			case "idle": 
				// take off
				if (hero.x < stage.stageWidth * 0.5 * 0.5){
					hero.x += ((stage.stageWidth * 0.5 * 0.5 + 10) - hero.x) * 0.05;
					hero.y = stage.stageHeight * 0.5;
					
					playerSpeed += (MIN_SPEED - playerSpeed) * 0.05;
					bg.speed = playerSpeed * elapsed;
				}else{
					gameState = "flying";
				}
				break;
			case "flying":
				
				if (hitObstacle <= 0){
					
					hero.y -= (hero.y - touchY) * 0.1;
					
					if(-(hero.y - touchY) < 150 && -(hero.y - touchY) > -150){
						hero.rotation = deg2rad(-(hero.y - touchY) * 0.2);
					}
					
					if (hero.y > gameArea.bottom - hero.height * 0.5){
						hero.y = gameArea.bottom - hero.height * 0.5;
						hero.rotation = deg2rad(0);
					}
					
					if (hero.y < gameArea.top + hero.height * 0.5){
						hero.y = gameArea.top + hero.height * 0.5
						hero.rotation = deg2rad(0);
					}
				}else{
					hitObstacle--;
					cameraShake();
				}
				
				playerSpeed -= (playerSpeed - MIN_SPEED) * 0.01;
				bg.speed = playerSpeed * elapsed;
				
				scoreDistance += (playerSpeed * elapsed) * 0.1;
				
				initObstacle();
				animateObstacle();
				break;
			case "over": 
				break;
			}
		}
		
		private function cameraShake():void 
		{
			if (hitObstacle > 0){
				this.x = Math.random() * hitObstacle;
				this.y = Math.random() * hitObstacle;
				
			}else if (x != 0){
				this.x = 0;
				this.y = 0;
			}
		}
		
		private function animateObstacle():void 
		{
			var obstacleToTrack:Obstacle;
			
			for (var i:uint = 0; i < obstacleToAnimate.length; i++ ){
				obstacleToTrack = obstacleToAnimate[i];
				
				if (obstacleToTrack.alreadyHit == false && obstacleToTrack.bounds.intersects(hero.bounds)){
					
					obstacleToTrack.alreadyHit = true;
					obstacleToTrack.rotation = deg2rad(70);
					hitObstacle = 30;
					playerSpeed *= 0.5;
				}
				
				if (obstacleToTrack.distance > 0){
					obstacleToTrack.distance -= playerSpeed * elapsed;
				}
				else{
					if (obstacleToTrack.watchOut){
						obstacleToTrack.watchOut = false;
					}
					obstacleToTrack.x -= (playerSpeed + obstacleToTrack.speed) * elapsed;
				}
				
				if (obstacleToTrack.x < -obstacleToTrack.width || gameState == "over"){
					obstacleToAnimate.splice(i, 1);
					this.removeChild(obstacleToTrack);
				}
			}
		}
		
		private function initObstacle():void 
		{
			if (obstacleGapCount < 1200){
				obstacleGapCount += playerSpeed * elapsed;
			}else if (obstacleGapCount != 0){
				obstacleGapCount = 0;
				createObstacle(Math.ceil(Math.random() * 4), Math.random() * 1000 + 1000);
			}
			
		}
		
		private function createObstacle(type:Number, distance:Number):void 
		{
			var obstacle:Obstacle = new Obstacle(type, distance, true, 300);
			obstacle.x = stage.stageWidth;
			this.addChild(obstacle);
			
			if (type <= 3){
				if (Math.random() > 0.5){
					obstacle.y = gameArea.top;
					obstacle.position = "top";
				}
				else{
					obstacle.y = gameArea.bottom - obstacle.height;
					obstacle.position = "bottom";
				}
			}
			else{
				obstacle.y = int(Math.random() * (gameArea.bottom - obstacle.height - gameArea.top)) + gameArea.top;
				obstacle.position = "middle";
			}
			
			obstacleToAnimate.push(obstacle);
		}
		
		private function checkElapsed(e:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			
			elapsed = (timeCurrent - timePrevious) * 0.001;
		}
	
	}

}