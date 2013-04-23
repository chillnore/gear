package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * @author Administrator
	 */
	public class GProgressBarSkin {
		protected static var _trackSkin : IGSkin;
		protected static var _barSkin : IGSkin;

		public function GProgressBarSkin() {
		}

		public static function get trackSkin() : IGSkin {
			if (_trackSkin != null) {
				return _trackSkin.clone();
			}
			_trackSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 1, 1, 12, 12);
			_trackSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			_trackSkin.scale9Grid = new Rectangle(2, 2, 10, 10);
			return _trackSkin;
		}

		public static function get barSkin() : IGSkin {
			if (_barSkin != null) {
				return _barSkin.clone();
			}
			_barSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 12, 12);
			_barSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			_barSkin.scale9Grid = new Rectangle(2, 2, 10, 10);
			return _barSkin;
		}
	}
}
