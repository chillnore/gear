package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;

	import flash.display.Graphics;
	import flash.display.Shape;

	/**
	 * 复选框皮肤
	 * 
	 * @author bright
	 * @version 20130422
	 */
	public class GCheckBoxSkin {
		protected static var _icon : IGSkin;

		protected static function drawCheck(g : Graphics, color : uint, alpha : Number) : void {
			var commands : Vector.<int>=new <int>[1, 2, 2, 2, 2, 2, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[3, 5, 5, 10, 7, 10, 12, 2, 13, 1, 11, 1, 6.5, 7, 5, 5, 3, 4];
			g.beginFill(color, alpha);
			g.drawPath(commands, data);
			g.endFill();
		}

		public function GCheckBoxSkin() {
		}

		public static function get icon() : IGSkin {
			if (_icon != null) {
				return _icon.clone();
			}
			_icon = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			_icon.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.75), GColorUtil.getAlphaColor(0xCCCCCC, 0.65)], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			_icon.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			_icon.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			_icon.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x5B5D5E], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			GCheckBoxSkin.drawCheck(g, 0x333333, 1);
			_icon.setAt(GPhase.SELECTED_UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.75), GColorUtil.getAlphaColor(0xCCCCCC, 0.65)], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			GCheckBoxSkin.drawCheck(g, 0x333333, 1);
			_icon.setAt(GPhase.SELECTED_OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [0x009DFF, 0x0075BF], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [0xD9F0FE, 0x99D7FE], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			GCheckBoxSkin.drawCheck(g, 0x333333, 1);
			_icon.setAt(GPhase.SELECTED_DOWN, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], 0, 0, 14, 14);
			GDrawUtil.drawGradientFillRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 12, 12);
			GDrawUtil.drawGradientFillRect(g, [0xFFFFFF, 0xEEEEEE], 1, 1, 12, 6, [0.3, 0]);
			GCheckBoxSkin.drawCheck(g, 0x333333, 0.4);
			_icon.setAt(GPhase.SELECTED_DISABLED, GBDUtil.toBD(skin));
			return _icon;
		}
	}
}
