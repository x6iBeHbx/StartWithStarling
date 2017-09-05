package game 
{
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.animation.Juggler;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class Obstacle extends Sprite 
	{
		
		private var _type:int;
		private var _speed:int;
		private var _distance:int;
		private var _watchOut:Boolean;
		private var _alreadyHit:Boolean;
		private var _position:String;
		private var obstacleImage:Image;
		private var obstacleCrashImage:Image;
		private var obstacleAnimation:MovieClip;
		private var watchOutAnimation:MovieClip;
		
		public function Obstacle(type:int, distace:int, watchOut:Boolean = true, speed:int = 0) 
		{
			super();
			
			_type = type;
			_distance = _distance;
			_watchOut = watchOut;
			_speed = speed;
			
			_alreadyHit = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			createObstacelArt();
			createObstacleCrashArt();
			createWatchOutAnimation();
		}
		
		private function createWatchOutAnimation():void 
		{
			watchOutAnimation = new MovieClip(Assets.getAtlas().getTextures("watchOut_"), 10);
			Starling.juggler.add(watchOutAnimation);
			
			if (_type == 4){
				watchOutAnimation.x = -watchOutAnimation.width;
				watchOutAnimation.y = obstacleAnimation.y + (obstacleAnimation.height * 0.5) - (watchOutAnimation.height * 0.5);
			}else{
				watchOutAnimation.x = -watchOutAnimation.width;
				watchOutAnimation.y = obstacleImage.y + (obstacleAnimation.height * 0.5) - (watchOutAnimation.height * 0.5);
			}
			this.addChild(watchOutAnimation);
		}
		
		private function createObstacleCrashArt():void 
		{
			obstacleCrashImage = new Image(Assets.getAtlas().getTexture("obstacle" + _type + "_crash"));
			obstacleCrashImage.visible = false;
			this.addChild(obstacleCrashImage);
		}
		
		private function createObstacelArt():void 
		{
			//TODO: fucking KASTIL
			if (_type == 4){
				obstacleAnimation = new MovieClip(Assets.getAtlas().getTextures("obstacle" + _type + "_0"), 10);
				Starling.juggler.add(obstacleAnimation);
				obstacleAnimation.x = 0;
				obstacleAnimation.y = 0;
				this.addChild(obstacleAnimation);
			}else {
				obstacleImage = new Image(Assets.getAtlas().getTexture("obstacle" + _type));
				obstacleImage.x = 0;
				obstacleImage.y = 0;
				this.addChild(obstacleImage);
			}
			
			obstacleImage = new Image(Assets.getAtlas().getTexture("obstacle" + _type));
			obstacleImage.x = 0;
			obstacleImage.y = 0;
			this.addChild(obstacleImage);
		}
		
		public function get watchOut():Boolean 
		{
			return _watchOut;
		}
		
		public function set watchOut(value:Boolean):void 
		{
			_watchOut = value;
			
			if (watchOutAnimation){
				if (value){
					watchOutAnimation.visible = true;
				}else{
					watchOutAnimation.visible = false;
				}
			}
		}
		
		public function get alreadyHit():Boolean 
		{
			return _alreadyHit;
		}
		
		public function set alreadyHit(value:Boolean):void 
		{
			_alreadyHit = value;
			
			if (value){
				obstacleCrashImage.visible = true;
				
				if (_type == 4){
					obstacleAnimation.visible = false;
				}else{
					obstacleImage.visible = false;
				}
			}
		}
		
		public function get position():String 
		{
			return _position;
		}
		
		public function set position(value:String):void 
		{
			_position = value;
		}
		
		public function get distance():int 
		{
			return _distance;
		}
		
		public function set distance(value:int):void 
		{
			_distance = value;
		}
		
		public function get speed():int 
		{
			return _speed;
		}
		
		public function set speed(value:int):void 
		{
			_speed = value;
		}
		
	}

}