package gear.gui.skins {
	import gear.gui.core.GPhase;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * 组合框皮肤
	 * 
	 * @author bright
	 * @version 20130422
	 */
	public class GComboBoxSkin {
		protected static var _arrowSkin : IGSkin;
		protected static var _editableSkin : IGSkin;

		protected static function drawDownArrow(g : Graphics, color : uint, x : int, y : int, w : int, h : int) : void {
			var commands : Vector.<int>=new <int>[1, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[x, y, x + w, y, x + w * 0.5, y + h, x, y];
			g.beginFill(color, 1);
			g.drawPath(commands, data);
			g.endFill();
			return;
		}

		public function GComboBoxSkin() {
		}

		public static function get arrowSkin() : IGSkin {
			if (_arrowSkin != null) {
				return _arrowSkin.clone();
			}
			_arrowSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRoundRect(g, [0xB7BABC, 0x585F63], 0, 0, 100, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 98, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xCCCCCC], 1, 1, 98, 11, 2, 2, 0, 0, [0.3, 0]);
			GDrawUtil.drawGradientFillRect(g, [0xB7BABC, 0x585F63], 78, 3, 1, 16);
			drawDownArrow(g, 0, 85, 9, 7, 4);
			_arrowSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			skin.graphics.clear();
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0x009DFF, 0x0075BF], 0, 0, 100, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 1, 1, 98, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xFFFFFF, 0xCCCCCC], 1, 1, 98, 11, 2, 2, 0, 0, [0.3, 0]);
			GDrawUtil.drawGradientFillRect(skin.graphics, [0x009DFF, 0x0075BF], 78, 3, 1, 16);
			drawDownArrow(g, 0, 85, 9, 7, 4);
			_arrowSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			skin.graphics.clear();
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0x009DFF, 0x0075BF], 0, 0, 100, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xD9F0FE, 0x99D7FE], 1, 1, 98, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xFFFFFF, 0xCCCCCC], 1, 1, 98, 11, 2, 2, 0, 0, [0.3, 0]);
			GDrawUtil.drawGradientFillRect(skin.graphics, [0x009DFF, 0x0075BF], 78, 3, 1, 16);
			drawDownArrow(g, 0, 85, 9, 7, 4);
			_arrowSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			skin.graphics.clear();
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], 0, 0, 100, 22, 3, 3, 3, 3);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 1, 1, 98, 20, 2, 2, 2, 2);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xFFFFFF, 0xCCCCCC], 1, 1, 98, 11, 2, 2, 0, 0, [0.3, 0]);
			GDrawUtil.drawGradientFillRect(skin.graphics, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], 78, 3, 1, 16);
			drawDownArrow(g, 0x888888, 85, 9, 7, 4);
			_arrowSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			_arrowSkin.scale9Grid = new Rectangle(4, 4, 77, 14);
			return _arrowSkin;
		}

		public static function get editableSkin() : IGSkin {
			if (_editableSkin != null) {
				return _editableSkin.clone();
			}
			_editableSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawGradientFillRoundRect(g, [0xB7BABC, 0x585F63], 0, 0, 21, 22, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(g, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 0, 1, 20, 20, 0, 2, 0, 2);
			GDrawUtil.drawGradientFillRoundRect(g, [0xFFFFFF, 0xCCCCCC], 0, 1, 20, 11, 0, 2, 0, 2, [0.3, 0]);
			drawDownArrow(g, 0, 6, 9, 7, 4);
			_editableSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			skin.graphics.clear();
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0x009DFF, 0x0075BF], 0, 0, 21, 22, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], 0, 1, 20, 20, 0, 2, 0, 2);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xFFFFFF, 0xCCCCCC], 0, 1, 20, 11, 0, 2, 0, 2, [0.3, 0]);
			drawDownArrow(g, 0, 6, 9, 7, 4);
			_editableSkin.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			skin.graphics.clear();
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0x009DFF, 0x0075BF], 0, 0, 21, 22, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xD9F0FE, 0x99D7FE], 0, 1, 20, 20, 0, 2, 0, 2);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xFFFFFF, 0xCCCCCC], 0, 1, 20, 11, 0, 2, 0, 2, [0.3, 0]);
			drawDownArrow(g, 0, 6, 9, 7, 4);
			_editableSkin.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			skin.graphics.clear();
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], 0, 0, 21, 22, 0, 3, 0, 3);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], 0, 1, 20, 20, 0, 2, 0, 2);
			GDrawUtil.drawGradientFillRoundRect(skin.graphics, [0xFFFFFF, 0xCCCCCC], 0, 1, 20, 11, 0, 2, 0, 2, [0.3, 0]);
			drawDownArrow(g, 0x888888, 6, 9, 7, 4);
			_editableSkin.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			_editableSkin.scale9Grid = new Rectangle(0, 4, 17, 14);
			return _editableSkin;
		}
	}
}
