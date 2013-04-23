package gear.gui.skins {
	import gear.gui.core.GPhase;

	import flash.display.BitmapData;

	/**
	 * 空皮肤
	 * 
	 * @author bright
	 * @version 20130422
	 */
	public class GEmptySkin {
		protected static var _skin : IGSkin;

		public function GEmptySkin() {
		}

		public static function get skin() : IGSkin {
			if (_skin != null) {
				return _skin.clone();
			}
			_skin = new GPhaseSkin();
			var bd : BitmapData = new BitmapData(60, 60, true, 0);
			_skin.setAt(GPhase.UP, bd);
			return _skin;
		}
	}
}
