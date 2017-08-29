package game 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Andrii Andriushchenko
	 */
	public class Assets 
	{
		[Embed(source="../../media/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		[Embed(source="../../media/graphics/bgLayer1.jpg")]
		public static const BgLayer1:Class;
	
		private static var gameTexture:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../../media/graphics/mySpritesheet.png")]
		public static const AtlasTextureGame:Class;
		[Embed(source="../../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXMLGame:Class;
		
		public static function getAtlas():TextureAtlas{
			
			if (gameTextureAtlas == null){
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = (XML)(new AtlasXMLGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture{
			
			if (gameTexture[name] == undefined){
				
				var bitmap:Bitmap = new Assets[name]();
				gameTexture[name] = Texture.fromBitmap(bitmap);
			}
			return gameTexture[name];
		}
	}

}