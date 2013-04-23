package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * 垂直滚动条皮肤
	 * 
	 * @author bright
	 * @version 20130422
	 */
	public class GVScrollBarSkin {
		protected static var _trackSkin : IGSkin;
		protected static var _thumbSkin : IGSkin;
		protected static var _thumbIcon : BitmapData;
		protected static var _upSkin : IGSkin;
		protected static var _downSkin : IGSkin;

		public function GVScrollBarSkin() {
		}

		public static function get trackSkin() : IGSkin {
			if (_trackSkin != null) {
				return _trackSkin;
			}
			_trackSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillRect(g, 0x585F63, 1, 0, 0, 1, 100);
			GDrawUtil.drawGradientFillRect(g, [0x94999B, 0xE7E7E7], 1, 0, 13, 100, null, null, 0);
			GDrawUtil.drawFillRect(g, 0x585F63, 1, 14, 0, 1, 100);
			_trackSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0xA5A5A5, 1, 0, 0, 1, 100);
			GDrawUtil.drawGradientFillRect(g, [0xDDDDDD, 0xEEEEEE], 1, 0, 13, 100, null, null, 0);
			GDrawUtil.drawFillRect(g, 0xA5A5A5, 1, 14, 0, 1, 100);
			_trackSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			_trackSkin.scale9Grid = new Rectangle(1, 0, 13, 100);
			return _trackSkin;
		}

		public static function get thumbSkin() : IGSkin {
			if (_thumbSkin != null) {
				return _thumbSkin.clone();
			}
			_thumbSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 15, 50);
			GDrawUtil.drawGradientFillRoundRect(g, [0xB7BABC, 0x585F63], 1, 0, 13, 50, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 12, 48, 0, 2, 0, 2);
			_thumbSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 15, 50);
			GDrawUtil.drawGradientFillRoundRect(g, [0x009DFF, 0x0075BF], 1, 0, 13, 50, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 12, 48, 0, 2, 0, 2);
			_thumbSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 15, 50);
			GDrawUtil.drawGradientFillRoundRect(g, [0x009DFF, 0x0075BF], 1, 0, 13, 50, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 12, 48, 0, 2, 0, 2);
			_thumbSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			_thumbSkin.scale9Grid = new Rectangle(5, 5, 9, 40);
			return _thumbSkin;
		}

		public static function get thumbIcon() : BitmapData {
			if (_thumbIcon != null) {
				return _thumbIcon;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			g.beginFill(0x5A6165, 1);
			g.drawRect(0, 0, 6, 1);
			g.drawRect(0, 2, 6, 1);
			g.drawRect(0, 4, 6, 1);
			g.drawRect(0, 6, 6, 1);
			_thumbIcon = GBDUtil.toBD(skin);
			return _thumbIcon;
		}

		public static function get upSkin() : IGSkin {
			if (_upSkin != null) {
				return _upSkin.clone();
			}
			_upSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawUpArrow(g, 0, 4, 5, 7, 4);
			_upSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawUpArrow(g, 0, 4, 5, 7, 4);
			_upSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawUpArrow(g, 0, 4, 5, 7, 4);
			_upSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawUpArrow(g, 0x888888, 4, 5, 7, 4);
			_upSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			_upSkin.scale9Grid = new Rectangle(1, 1, 13, 12);
			return _upSkin;
		}

		public static function get downSkin() : IGSkin {
			if (_downSkin != null) {
				return _downSkin.clone();
			}
			_downSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawDownArrow(g, 0, 4, 5, 7, 4);
			_downSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawDownArrow(g, 0, 4, 5, 7, 4);
			_downSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawDownArrow(g, 0, 4, 5, 7, 4);
			_downSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 15, 14);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xE6E6E6], 1, 1, 13, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 13, 6, [0.3, 0]);
			GDrawUtil.drawDownArrow(g, 0x888888, 4, 5, 7, 4);
			_downSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			_downSkin.scale9Grid = new Rectangle(1, 1, 13, 12);
			return _downSkin;
		}
	}
}
