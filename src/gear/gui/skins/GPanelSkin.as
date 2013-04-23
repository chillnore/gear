package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * @author Administrator
	 */
	public class GPanelSkin {
		protected static var _skin : IGSkin;
		protected static var _modalSkin : IGSkin;

		public function GPanelSkin() {
		}

		public static function get skin() : IGSkin {
			if (_skin != null) {
				return _skin;
			}
			_skin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0xA9ACAE, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 1, 1, 48, 48);
			_skin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			_skin.scale9Grid = new Rectangle(1, 1, 48, 48);
			return _skin;
		}
		
		public static function get modalSkin():IGSkin{
			if (_modalSkin != null) {
				return _modalSkin.clone();
			}
			_modalSkin= new GPhaseSkin();
			var bd : BitmapData = new BitmapData(60, 60, true, 0);
			bd.fillRect(bd.rect, 0x21000000);
			_modalSkin.setAt(GPhase.UP, bd);
			return _modalSkin;
		}
	}
}
