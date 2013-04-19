package gear.gui.skin {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * @author bright
	 */
	public class GComboBoxSkin {
		protected static var _arrowSkin : IGSkin;
		protected static var _editableSkin : IGSkin;

		protected static function drawDownArrow(g : Graphics, color : uint, x : int, y : int, w : int, h : int) : void {
			g.beginFill(color, 1);
			g.moveTo(x, y);
			g.lineTo(x + w, y);
			g.lineTo(x + w * 0.5, y + h);
			g.lineTo(x, y);
			g.endFill();
		}

		public function GComboBoxSkin() {
		}

		public static function get arrowSkin() : IGSkin {
			if (_arrowSkin == null) {
				_arrowSkin = new GPhaseSkin();
				var skin : Shape = new Shape();
				var g : Graphics = skin.graphics;
				GDrawUtil.drawGradientFillRoundRect(g, GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], 0, 0, 100, 22, 3, 3, 3, 3);
				GDrawUtil.drawGradientFillRoundRect(g, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], 1, 1, 98, 20, 2, 2, 2, 2);
				GDrawUtil.drawGradientFillRoundRect(g, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 1, 1, 98, 11, 2, 2, 0, 0);
				GDrawUtil.drawGradientFillRect(g, GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], 78, 3, 1, 16);
				drawDownArrow(g, 0, 85, 9, 7, 4);
				_arrowSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
				skin.graphics.clear();
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 0, 0, 100, 22, 3, 3, 3, 3);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], 1, 1, 98, 20, 2, 2, 2, 2);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 1, 1, 98, 11, 2, 2, 0, 0);
				GDrawUtil.drawGradientFillRect(skin.graphics, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 78, 3, 1, 16);
				drawDownArrow(g, 0, 85, 9, 7, 4);
				_arrowSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
				skin.graphics.clear();
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 0, 0, 100, 22, 3, 3, 3, 3);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], 1, 1, 98, 20, 2, 2, 2, 2);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 1, 1, 98, 11, 2, 2, 0, 0);
				GDrawUtil.drawGradientFillRect(skin.graphics, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 78, 3, 1, 16);
				drawDownArrow(g, 0, 85, 9, 7, 4);
				_arrowSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
				skin.graphics.clear();
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], [1, 1], [0, 255], 0, 0, 100, 22, 3, 3, 3, 3);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], 1, 1, 98, 20, 2, 2, 2, 2);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 1, 1, 98, 11, 2, 2, 0, 0);
				GDrawUtil.drawGradientFillRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], [1, 1], [0, 255], 78, 3, 1, 16);
				drawDownArrow(g, 0x888888, 85, 9, 7, 4);
				_arrowSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
				_arrowSkin.scale9Grid = new Rectangle(4, 4, 77, 14);
			}
			return _arrowSkin.clone();
		}

		public static function get editableSkin() : IGSkin {
			if (_editableSkin == null) {
				_editableSkin = new GPhaseSkin();
				var skin : Shape = new Shape();
				var g : Graphics = skin.graphics;
				GDrawUtil.drawGradientFillRoundRect(g, GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], 0, 0, 21, 22, 0, 3, 0, 3);
				GDrawUtil.drawGradientFillRoundRect(g, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], 0, 1, 20, 20, 0, 2, 0, 2);
				GDrawUtil.drawGradientFillRoundRect(g, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 0, 1, 20, 11, 0, 2, 0, 2);
				drawDownArrow(g, 0, 6, 9, 7, 4);
				_editableSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
				skin.graphics.clear();
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 0, 0, 21, 22, 0, 3, 0, 3);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], 0, 1, 20, 20, 0, 2, 0, 2);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 0, 1, 20, 11, 0, 2, 0, 2);
				drawDownArrow(g, 0, 6, 9, 7, 4);
				_editableSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
				skin.graphics.clear();
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 0, 0, 21, 22, 0, 3, 0, 3);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], 0, 1, 20, 20, 0, 2, 0, 2);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 0, 1, 20, 11, 0, 2, 0, 2);
				drawDownArrow(g, 0, 6, 9, 7, 4);
				_editableSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
				skin.graphics.clear();
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], [1, 1], [0, 255], 0, 0, 21, 22, 0, 3, 0, 3);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], 0, 1, 20, 20, 0, 2, 0, 2);
				GDrawUtil.drawGradientFillRoundRect(skin.graphics, GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], 0, 1, 20, 11, 0, 2, 0, 2);
				drawDownArrow(g, 0x888888, 6, 9, 7, 4);
				_editableSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
				_editableSkin.scale9Grid = new Rectangle(0, 4, 17, 14);
			}
			return _editableSkin.clone();
		}
	}
}
