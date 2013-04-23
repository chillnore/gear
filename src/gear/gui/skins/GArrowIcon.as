package gear.gui.skins {
	import gear.utils.GBDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;

	/**
	 * 箭头图标
	 * 
	 * @author Bright
	 * @version 20130423
	 */
	public class GArrowIcon {
		protected static var _upArrow : BitmapData;
		protected static var _downArrow : BitmapData;
		protected static var _leftArrow : BitmapData;
		protected static var _rightArrow : BitmapData;

		public function GArrowIcon() {
		}
		
		public static function get upArrow() : BitmapData {
			if (_upArrow != null) {
				return _upArrow;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawUpArrow(g, 0, 0, 0, 7, 4);
			_upArrow = GBDUtil.toBD(skin);
			return _upArrow;
		}
		
		public static function get downArrow() : BitmapData {
			if (_downArrow != null) {
				return _downArrow;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawDownArrow(g, 0, 0, 0, 7, 4);
			_downArrow = GBDUtil.toBD(skin);
			return _downArrow;
		}

		public static function get leftArrow() : BitmapData {
			if (_leftArrow != null) {
				return _leftArrow;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawLeftArrow(g, 0, 0, 0, 4, 7);
			_leftArrow = GBDUtil.toBD(skin);
			return _leftArrow;
		}

		public static function get rightArrow() : BitmapData {
			if (_rightArrow != null) {
				return _rightArrow;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawRightArrow(g, 0, 0, 0, 4, 7);
			_rightArrow = GBDUtil.toBD(skin);
			return _rightArrow;
		}
	}
}
