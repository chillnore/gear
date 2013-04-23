package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * @author Administrator
	 */
	public class GBorderSkin {
		protected static var _skin : IGSkin;

		public function GBorderSkin() {
		}

		public static function get skin() : IGSkin {
			if (_skin != null) {
				return _skin.clone();
			}
			_skin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0x565656, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0xDADADA, 1, 1, 1, 48, 1);
			_skin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillBorder(g, [0x009DFF, 0x0075BF], 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0xDADADA, 1, 1, 1, 48, 1);
			_skin.setAt(GPhase.FOCUS, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillBorder(g, 0xA5A5A5A5, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0xECECEC, 1, 1, 1, 48, 1);
			_skin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			_skin.scale9Grid = new Rectangle(2, 2, 46, 46);
			return _skin;
		}
	}
}
