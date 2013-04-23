package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * 单元格皮肤
	 * 
	 * @author bright
	 * @version 20130422
	 */
	public class GCellSkin {
		protected static var _skin : IGSkin;

		public function GCellSkin() {
		}

		public static function get skin() : IGSkin {
			if (_skin == null) {
				_skin = new GPhaseSkin();
				var skin : Shape = new Shape();
				var g : Graphics = skin.graphics;
				GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 0, 0, 50, 50);
				_skin.setAt(GPhase.UP, GBDUtil.toBD(skin));
				g.clear();
				GDrawUtil.drawFillRect(g, 0xADDAFC, 1, 0, 0, 50, 50);
				_skin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
				g.clear();
				GDrawUtil.drawFillRect(g, 0x7EC3FB, 1, 0, 0, 50, 50);
				var bd : BitmapData = GBDUtil.toBD(skin);
				_skin.setAt(GPhase.DOWN, bd);
				_skin.setAt(GPhase.SELECTED_UP, bd);
				_skin.scale9Grid = new Rectangle(2, 2, 48, 48);
				return _skin;
			}
			return _skin.clone();
		}
	}
}
