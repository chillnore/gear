package gear.gui.skins {
	import flash.display.BitmapData;

	/**
	 * @author bright
	 * @version 20130425
	 */
	public class GTreeIcon {
		protected static var _closeIcon : BitmapData;
		protected static var _openIcon : BitmapData;
		protected static var _leafIcon : BitmapData;

		public static function get closeIcon() : BitmapData {
			return _closeIcon;
		}
	}
}
