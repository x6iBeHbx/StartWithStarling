package game 
{
	import game.events.NavgationEvent;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.GlowFilter;
	
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class Welcome extends Sprite 
	{
		private var bg:Image;
		private var hero:Image;
		
		private var playBtn:Button;
		private var aboutBtn:Button;
		public function Welcome() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
		}
		
		private function drawScreen():void 
		{
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);
			
			hero = new Image(Assets.getAtlas().getTexture("welcome_hero"));
			hero.width = 300;
			hero.height = 300;
			hero.x = 50;
			hero.y = 200;
			this.addChild(hero);
			
			var title:Image = new Image(Assets.getAtlas().getTexture("welcome_title"));
			title.x = 400;
			title.y = 0;
			this.addChild(title);
			
			playBtn = new Button(Assets.getAtlas().getTexture("welcome_playButton"));
			playBtn.x = 450;
			playBtn.y = 250;
			this.addChild(playBtn);

			
			aboutBtn = new Button(Assets.getAtlas().getTexture("welcome_aboutButton"));
			aboutBtn.x = 500;
			aboutBtn.y = 400;
			this.addChild(aboutBtn);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClicked);
		}
		
		private function onMainMenuClicked(e:Event):void 
		{
			var buttonClicked:Button = e.target as Button;
			
			if (buttonClicked == playBtn){
				this.dispatchEvent(new NavgationEvent(NavgationEvent.CHANGE_SCREEN, true, {id: "play"}));
			}
		}
		
		public function initialize():void{
			
			hero.x = -hero.width;
			hero.y = 200;
			
			this.visible = true;
			
			TweenLite.to(hero, 2, {x:80});
			
			this.addEventListener(Event.ENTER_FRAME, heroAnimation);
		}
		
		private function heroAnimation(e:Event):void 
		{
			var currentDate:Date = new Date();
			hero.y = 100 + (Math.cos(currentDate.getTime() * 0.002) * 25);
			playBtn.y = 250 + (Math.cos(currentDate.getTime() * 0.002) * 10);
			aboutBtn.y = 400 + (Math.cos(currentDate.getTime()*0.002)*10);
		}
		
	}

}