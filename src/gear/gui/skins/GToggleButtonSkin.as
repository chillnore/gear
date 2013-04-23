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
	public class GToggleButtonSkin {
		protected static var _skin : IGSkin;

		public function GToggleButtonSkin() {
		}

		public static function get skin() : IGSkin {
			if (_skin != null) {
				return _skin.clone();
			}
			_skin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRoundRect(g, [0xB7BABC, 0x585F63], 0, 0, 60, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 58, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xCCCCCC], 1, 1, 58, 11, 2, 2, 0, 0, [0.3, 0]);
			_skin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRoundRect(g, [0x009DFF, 0x0075BF], 0, 0, 60, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 1, 1, 58, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xCCCCCC], 1, 1, 58, 11, 2, 2, 0, 0, [0.3, 0]);
			_skin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRoundRect(g, [0x009DFF, 0x0075BF], 0, 0, 60, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 58, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xCCCCCC], 1, 1, 58, 11, 2, 2, 0, 0, [0.3, 0]);
			_skin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], 0, 0, 60, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 58, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xCCCCCC], 1, 1, 58, 11, 2, 2, 0, 0, [0.15, 0]);
			_skin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRoundRect(g, [0x009DFF, 0x0075BF], 0, 0, 60, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xCCCCCC, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 1, 1, 58, 20, 2, 2, 2, 2);
			_skin.setAt(GPhase.SELECTED_UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0x009DFF, 0.4), GColorUtil.getAlphaColor(0x0075BF, 0.4)], 0, 0, 60, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xCCCCCC, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 58, 20, 2, 2, 2, 2);
			_skin.setAt(GPhase.SELECTED_DISABLED, GBDUtil.toBD(skin));
			_skin.scale9Grid = new Rectangle(4, 4, 52, 14);
			return _skin;
		}
	}
}
