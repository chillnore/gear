package gear.gui.skins {
	import gear.utils.GBDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;

	/**
	 * @author bright
	 * @version 20130425
	 */
	public class GTreeIcon {
		protected static var _closeIcon : BitmapData;
		protected static var _openIcon : BitmapData;
		protected static var _leafIcon : BitmapData;

		public static function get openIcon() : BitmapData {
			if (_openIcon == null) {
				var skin : Shape = new Shape();
				var g : Graphics = skin.graphics;
				GDrawUtil.drawFillBorder(g, 0x808080, 1, 0, 0, 9, 9);
				GDrawUtil.drawFillRect(g, 0, 1, 2, 4, 5, 1);
				_openIcon = GBDUtil.toBD(skin);
			}
			return _openIcon;
		}

		public static function get closeIcon() : BitmapData {
			if (_closeIcon == null) {
				var skin : Shape = new Shape();
				var g : Graphics = skin.graphics;
				GDrawUtil.drawFillBorder(g, 0x808080, 1, 0, 0, 9, 9);
				GDrawUtil.drawFillRect(g, 0, 1, 2, 4, 5, 1);
				GDrawUtil.drawFillRect(g, 0, 1, 4, 2, 1, 5);
				_closeIcon = GBDUtil.toBD(skin);
			}
			return _closeIcon;
		}

		public static function get leafIcon() : BitmapData {
			if (_leafIcon == null) {
				var skin : Shape = new Shape();
				var g : Graphics = skin.graphics;
				GDrawUtil.drawFillBorder(g, 0x808080, 1, 0, 0, 9, 9);
				_leafIcon = GBDUtil.toBD(skin);
			}
			return _leafIcon;
		}
	}
}
