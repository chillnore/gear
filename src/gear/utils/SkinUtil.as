package gear.utils {
	import gear.log4a.GLogger;

	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	/**
	 * Skin Util
	 * 
	 * @author bright
	 * @version 20121017
	 */
	public class SkinUtil {
		public static function getSprite(key : String) : Sprite {
			var sprite : Sprite;
			try {
				var asset : Class = getDefinitionByName(key) as Class;
				sprite = new asset() as Sprite;
			} catch(e : Error) {
				GLogger.warn(e.message);
			}
			return sprite;
		}
	}
}
