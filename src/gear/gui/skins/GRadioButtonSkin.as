package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GMathUtil;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	/**
	 * @author Administrator
	 */
	public class GRadioButtonSkin {
		protected static var _icon : IGSkin;

		public function GRadioButtonSkin() {
		}

		public static function get icon():IGSkin{
			if(_icon!=null){
				return _icon.clone();
			}
			_icon= new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
			g.drawCircle(7, 7, 6);
			g.endFill();
			_icon.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
			g.drawCircle(7, 7, 6);
			g.endFill();
			_icon.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			_icon.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			_icon.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
			g.drawCircle(7, 7, 6);
			g.endFill();
			g.beginFill(0x333333, 1);
			g.drawCircle(7, 7, 2);
			g.endFill();
			_icon.setAt(GPhase.SELECTED_UP, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
			g.drawCircle(7, 7, 6);
			g.endFill();
			g.beginFill(0x333333, 1);
			g.drawCircle(7, 7, 2);
			g.endFill();
			_icon.setAt(GPhase.SELECTED_OVER, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			g.beginFill(0x333333, 1);
			g.drawCircle(7, 7, 2);
			g.endFill();
			_icon.setAt(GPhase.SELECTED_DOWN, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			g.beginFill(GColorUtil.getAlphaColor(0x333333, 0.3), 1);
			g.drawCircle(7, 7, 2);
			g.endFill();
			_icon.setAt(GPhase.SELECTED_DISABLED, GBDUtil.toBD(skin));
			return _icon;
		}
	}
}
