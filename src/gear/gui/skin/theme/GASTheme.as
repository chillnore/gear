package gear.gui.skin.theme {
	import gear.gui.core.GPhase;
	import gear.gui.skin.GPhaseSkin;
	import gear.gui.skin.IGSkin;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;
	import gear.utils.GMathUtil;

	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * AS3主题皮肤
	 * 
	 * @author bright
	 * @version 20121206 
	 */
	public final class GASTheme implements IGTheme {
		private static const BUTTON_SKIN : int = 0;
		private static const CELL_SKIN : int = 1;
		private static const CHECK_BOX_ICON : int = 2;
		private static const EMPTY_SKIN : int = 3;
		private static const HSCROLL_BAR_TRACK_SKIN : int = 4;
		private static const HSCROLL_BAR_THUMB_SKIN : int = 5;
		private static const HSCROLL_BAR_ARROW_UP_SKIN : int = 6;
		private static const HSCROLL_BAR_ARROW_DOWN_SKIN : int = 7;
		private static const LIST_SKIN : int = 8;
		private static const MODAL_SKIN : int = 9;
		private static const PANEL_BG_SKIN : int = 10;
		private static const PROGRESS_BAR_TRACK_SKIN : int = 11;
		private static const PROGRESS_BAR_BAR_SKIN : int = 12;
		private static const RADIO_BUTTON_ICON : int = 13;
		private static const VSCROLL_BAR_TRACK_SKIN : int = 14;
		private static const VSCROLL_BAR_THUMB_SKIN : int = 15;
		private static const VSCROLL_BAR_ARROW_UP_SKIN : int = 16;
		private static const VSCROLL_BAR_ARROW_DOWN_SKIN : int = 17;
		private static const TEXT_AREA_BORDER_SKIN : int = 18;
		private static const TEXT_INPUT_BORDER_SKIN : int = 19;
		private static const TOGGLE_BUTTON_SKIN : int = 20;
		private static const HSCROLL_BAR_THUMB_ICON : int = 0;
		private static const LEFT_ARROW_ICON : int = 1;
		private static const RIGHT_ARROW_ICON : int = 2;
		private static const VSCROLL_BAR_THUMB_ICON : int = 3;
		private var _caches : Vector.<IGSkin>;
		private var _icons : Vector.<BitmapData>;

		public function GASTheme() {
			_caches = new Vector.<IGSkin>(21, true);
			_icons = new Vector.<BitmapData>(4, true);
		}

		public function get buttonSkin() : IGSkin {
			var result : IGSkin = _caches[BUTTON_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.15, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(4, 4, 60 - 8, 22 - 8);
			_caches[BUTTON_SKIN] = result;
			return result;
		}

		public function get cellSkin() : IGSkin {
			var result : IGSkin = _caches[CELL_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 0, 0, 50, 50);
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0xADDAFC, 1, 0, 0, 50, 50);
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0x7EC3FB, 1, 0, 0, 50, 50);
			var bd : BitmapData = GBDUtil.toBD(skin);
			result.setAt(GPhase.DOWN, bd);
			result.setAt(GPhase.SELECTED_UP, bd);
			result.scale9Grid = new Rectangle(2, 2, 48, 48);
			_caches[CELL_SKIN] = result;
			return result;
		}

		public function get checkBoxIcon() : IGSkin {
			var result : IGSkin = _caches[CHECK_BOX_ICON];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.75), GColorUtil.getAlphaColor(0xEEEEEE, 0.65)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			var commands : Vector.<int>=new <int>[1, 2, 2, 2, 2, 2, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[3, 5, 5, 10, 7, 10, 12, 2, 13, 1, 11, 1, 6.5, 7, 5, 5, 3, 4];
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			g.beginFill(0x333333, 1);
			g.drawPath(commands, data);
			result.setAt(GPhase.SELECTED_UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.75), GColorUtil.getAlphaColor(0xEEEEEE, 0.65)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			g.beginFill(0x333333, 1);
			g.drawPath(commands, data);
			result.setAt(GPhase.SELECTED_OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			g.beginFill(0x333333, 1);
			g.drawPath(commands, data);
			result.setAt(GPhase.SELECTED_DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			mtx.createGradientBox(12, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 6);
			g.endFill();
			g.beginFill(0x333333, 0.4);
			g.drawPath(commands, data);
			result.setAt(GPhase.SELECTED_DISABLED, GBDUtil.toBD(skin));
			_caches[CHECK_BOX_ICON] = result;
			return result;
		}

		public function get emptySkin() : IGSkin {
			var result : IGSkin = _caches[EMPTY_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var bd : BitmapData = new BitmapData(60, 60, true, 0);
			result.setAt(GPhase.UP, bd);
			_caches[EMPTY_SKIN] = result;
			return result;
		}

		public function get hScrollBarTrackSkin() : IGSkin {
			var result : IGSkin = _caches[HSCROLL_BAR_TRACK_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillLine(g, 0x585F63, 1, 0, 0, 100);
			GDrawUtil.drawGradientFillRect(g, GradientType.LINEAR, [0x94999B, 0xE7E7E7], [1, 1], [0, 255], 0, 1, 100, 13);
			GDrawUtil.drawFillLine(g, 0x585F63, 1, 0, 14, 100);
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillLine(g, 0xA5A5A5, 1, 0, 0, 100);
			GDrawUtil.drawGradientFillRect(g, GradientType.LINEAR, [0xDDDDDD, 0xEEEEEE], [1, 1], [0, 255], 0, 1, 100, 13);
			GDrawUtil.drawFillLine(g, 0xA5A5A5, 1, 0, 14, 100);
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(0, 1, 100, 13);
			_caches[HSCROLL_BAR_TRACK_SKIN] = result;
			return result;
		}

		public function get hScrollBarThumbSkin() : IGSkin {
			var result : IGSkin = _caches[HSCROLL_BAR_THUMB_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(50, 12, GMathUtil.angleToRadian(0), 0, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 1, 50, 12, 3, 3, 0, 0);
			g.endFill();
			mtx.createGradientBox(48, 11, GMathUtil.angleToRadian(0), 1, 2);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 2, 48, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(50, 12, GMathUtil.angleToRadian(0), 0, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 1, 50, 12, 3, 3, 0, 0);
			g.endFill();
			mtx.createGradientBox(48, 11, GMathUtil.angleToRadian(0), 1, 2);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 2, 48, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(50, 12, GMathUtil.angleToRadian(0), 0, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 1, 50, 12, 3, 3, 0, 0);
			g.endFill();
			mtx.createGradientBox(48, 11, GMathUtil.angleToRadian(0), 1, 2);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 2, 48, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(5, 5, 50 - 10, 12 - 6);
			_caches[HSCROLL_BAR_THUMB_SKIN] = result;
			return result;
		}

		public function get hScrollBarArrowUpSkin() : IGSkin {
			var result : IGSkin = _caches[HSCROLL_BAR_ARROW_UP_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(9, 3);
			g.lineTo(9, 10);
			g.lineTo(5, 6.5);
			g.lineTo(9, 3);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(9, 3);
			g.lineTo(9, 10);
			g.lineTo(5, 6.5);
			g.lineTo(9, 3);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(9, 3);
			g.lineTo(9, 10);
			g.lineTo(5, 6.5);
			g.lineTo(9, 3);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [0.3, 0.3], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0x888888, 1);
			g.moveTo(9, 3);
			g.lineTo(9, 10);
			g.lineTo(5, 6.5);
			g.lineTo(9, 3);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 13, 12);
			_caches[HSCROLL_BAR_ARROW_UP_SKIN] = result;
			return result;
		}

		public function get hScrollBarArrowDownSkin() : IGSkin {
			var result : IGSkin = _caches[HSCROLL_BAR_ARROW_DOWN_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(6, 3);
			g.lineTo(10, 6.5);
			g.lineTo(6, 10);
			g.lineTo(6, 3);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(6, 3);
			g.lineTo(10, 6.5);
			g.lineTo(6, 10);
			g.lineTo(6, 3);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(6, 3);
			g.lineTo(10, 6.5);
			g.lineTo(6, 10);
			g.lineTo(6, 3);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [0.3, 0.3], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0x888888, 1);
			g.moveTo(6, 3);
			g.lineTo(10, 6.5);
			g.lineTo(6, 10);
			g.lineTo(6, 3);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 13, 12);
			_caches[HSCROLL_BAR_ARROW_DOWN_SKIN] = result;
			return result;
		}

		public function get listSkin() : IGSkin {
			var result : IGSkin = _caches[LIST_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0xA8ACAE, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 1, 1, 48, 48);
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 48, 48);
			_caches[LIST_SKIN] = result;
			return result;
		}

		public function get modalSkin() : IGSkin {
			var result : IGSkin = _caches[MODAL_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var bd : BitmapData = new BitmapData(60, 60, true, 0);
			bd.fillRect(bd.rect, 0x21000000);
			result.setAt(GPhase.UP, bd);
			_caches[MODAL_SKIN] = result;
			return result;
		}

		public function get panelBgSkin() : IGSkin {
			var result : IGSkin = _caches[PANEL_BG_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0xA9ACAE, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 1, 1, 48, 48);
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 48, 48);
			_caches[PANEL_BG_SKIN] = result;
			return result;
		}

		public function get progressBarTrackSkin() : IGSkin {
			var result : IGSkin = _caches[PROGRESS_BAR_TRACK_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(2, 2, 10, 10);
			_caches[PROGRESS_BAR_TRACK_SKIN] = result;
			return result;
		}

		public function get progressBarBarSkin() : IGSkin {
			var result : IGSkin = _caches[PROGRESS_BAR_BAR_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 14, 14);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			mtx.createGradientBox(12, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.drawRect(1, 1, 12, 12);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(2, 2, 10, 10);
			_caches[PROGRESS_BAR_BAR_SKIN] = result;
			return result;
		}

		public function get radioButtonIcon() : IGSkin {
			var result : IGSkin = _caches[RADIO_BUTTON_ICON];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
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
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
			g.drawCircle(7, 7, 6);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
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
			result.setAt(GPhase.SELECTED_UP, GBDUtil.toBD(skin));
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
			result.setAt(GPhase.SELECTED_OVER, GBDUtil.toBD(skin));
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
			result.setAt(GPhase.SELECTED_DOWN, GBDUtil.toBD(skin));
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
			result.setAt(GPhase.SELECTED_DISABLED, GBDUtil.toBD(skin));
			return result;
		}

		public function get hScrollBarThumbIcon() : BitmapData {
			var result : BitmapData = _icons[HSCROLL_BAR_THUMB_ICON];
			if (result != null) {
				return result;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			g.beginFill(0x5A6165, 1);
			g.drawRect(0, 0, 1, 6);
			g.drawRect(2, 0, 1, 6);
			g.drawRect(4, 0, 1, 6);
			g.drawRect(6, 0, 1, 6);
			result = GBDUtil.toBD(skin);
			_icons[HSCROLL_BAR_THUMB_ICON] = result;
			return result;
		}

		public function get leftArrowIcon() : BitmapData {
			var result : BitmapData = _icons[LEFT_ARROW_ICON];
			if (result != null) {
				return result;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			g.beginFill(0, 1);
			g.moveTo(4, 0);
			g.lineTo(4, 7);
			g.lineTo(0, 3.5);
			g.lineTo(4, 0);
			g.endFill();
			result = GBDUtil.toBD(skin);
			_icons[LEFT_ARROW_ICON] = result;
			return result;
		}

		public function get rightArrowIcon() : BitmapData {
			var result : BitmapData = _icons[RIGHT_ARROW_ICON];
			if (result != null) {
				return result;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			g.beginFill(0, 1);
			g.moveTo(0, 0);
			g.lineTo(4, 3.5);
			g.lineTo(0, 7);
			g.lineTo(0, 0);
			g.endFill();
			result = GBDUtil.toBD(skin);
			_icons[RIGHT_ARROW_ICON] = result;
			return result;
		}

		public function get vScrollBarTrackSkin() : IGSkin {
			var result : IGSkin = _caches[VSCROLL_BAR_TRACK_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			g.beginFill(0x585F63, 1);
			g.drawRect(0, 0, 1, 100);
			g.endFill();
			mtx.createGradientBox(13, 100, GMathUtil.angleToRadian(0), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x94999B, 0xE7E7E7], [1, 1], [0, 255], mtx);
			g.drawRect(1, 0, 13, 100);
			g.endFill();
			g.beginFill(0x585F63, 1);
			g.drawRect(14, 0, 1, 100);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			g.beginFill(0xA5A5A5, 1);
			g.drawRect(0, 0, 1, 100);
			g.endFill();
			mtx.createGradientBox(13, 100, GMathUtil.angleToRadian(0), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xDDDDDD, 0xEEEEEE], [1, 1], [0, 255], mtx);
			g.drawRect(1, 0, 13, 100);
			g.endFill();
			g.beginFill(0xA5A5A5, 1);
			g.drawRect(14, 0, 1, 100);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 0, 13, 100);
			_caches[VSCROLL_BAR_TRACK_SKIN] = result;
			return result;
		}

		public function get vScrollBarThumbSkin() : IGSkin {
			var result : IGSkin = _caches[VSCROLL_BAR_THUMB_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 14, 50);
			mtx.createGradientBox(12, 50, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 0, 12, 50, 0, 3, 0, 3);
			g.endFill();
			mtx.createGradientBox(12, 48, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 11, 48, 0, 2, 0, 2);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 14, 50);
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 14, 50);
			mtx.createGradientBox(12, 50, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 0, 12, 50, 0, 3, 0, 3);
			g.endFill();
			mtx.createGradientBox(12, 48, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 11, 48, 0, 2, 0, 2);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillRect(g, 0, 0, 0, 0, 14, 50);
			mtx.createGradientBox(12, 50, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 0, 12, 50, 0, 3, 0, 3);
			g.endFill();
			mtx.createGradientBox(12, 48, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 11, 48, 0, 2, 0, 2);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(2, 4, 12 - 6, 50 - 8);
			_caches[VSCROLL_BAR_THUMB_SKIN] = result;
			return result;
		}

		public function get vScrollBarArrowUpSkin() : IGSkin {
			var result : IGSkin = _caches[VSCROLL_BAR_ARROW_UP_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [0.3, 0.3], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0x888888, 1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 13, 12);
			_caches[VSCROLL_BAR_ARROW_UP_SKIN] = result;
			return result;
		}

		public function get vScrollBarArrowDownSkin() : IGSkin {
			var result : IGSkin = _caches[VSCROLL_BAR_ARROW_DOWN_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0, 1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [0.3, 0.3], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13, 6);
			g.endFill();
			g.beginFill(0x888888, 1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 13, 12);
			_caches[VSCROLL_BAR_ARROW_DOWN_SKIN] = result;
			return result;
		}

		public function get textAreaBorderSkin() : IGSkin {
			var result : IGSkin = _caches[TEXT_AREA_BORDER_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0x565656, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillLine(g, 0xDADADA, 1, 1, 1, 48);
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 1, 2, 48, 47);
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillBorder(g, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 0, 0, 50, 50);
			GDrawUtil.drawFillLine(g, 0xDADADA, 1, 1, 1, 48);
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 1, 2, 48, 47);
			result.setAt(GPhase.FOCUS, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillBorder(g, 0xA5A5A5A5, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillLine(g, 0xECECEC, 1, 1, 1, 48);
			GDrawUtil.drawFillRect(g, 0xFFFFFF, 1, 1, 2, 48, 47);
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(2, 2, 46, 46);
			_caches[TEXT_AREA_BORDER_SKIN] = result;
			return result;
		}

		public function get textInputBorderSkin() : IGSkin {
			var result : IGSkin = _caches[TEXT_INPUT_BORDER_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0x565656, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillLine(g, 0xDADADA, 1, 1, 1, 48);
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawGradientFillBorder(g, GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], 0, 0, 50, 50);
			GDrawUtil.drawFillLine(g, 0xDADADA, 1, 1, 1, 48);
			result.setAt(GPhase.FOCUS, GBDUtil.toBD(skin));
			g.clear();
			GDrawUtil.drawFillBorder(g, 0xA5A5A5A5, 1, 0, 0, 50, 50);
			GDrawUtil.drawFillLine(g, 0xECECEC, 1, 1, 1, 48);
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(2, 2, 46, 46);
			_caches[TEXT_INPUT_BORDER_SKIN] = result;
			return result;
		}

		public function get toggleButtonSkin() : IGSkin {
			var result : IGSkin = _caches[TOGGLE_BUTTON_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.3, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x585F63, 0.3)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			mtx.createGradientBox(58, 11, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xCCCCCC], [0.15, 0], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 11, 2, 2, 0, 0);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xCCCCCC, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			result.setAt(GPhase.SELECTED_UP, GBDUtil.toBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0x009DFF, 0.4), GColorUtil.getAlphaColor(0x0075BF, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xCCCCCC, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			result.setAt(GPhase.SELECTED_DISABLED, GBDUtil.toBD(skin));
			result.scale9Grid = new Rectangle(4, 4, 60 - 8, 22 - 8);
			_caches[TOGGLE_BUTTON_SKIN] = result;
			return result;
		}

		public function get vScrollBarThumbIcon() : BitmapData {
			var result : BitmapData = _icons[VSCROLL_BAR_THUMB_ICON];
			if (result != null) {
				return result;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			g.beginFill(0x5A6165, 1);
			g.drawRect(0, 0, 6, 1);
			g.drawRect(0, 2, 6, 1);
			g.drawRect(0, 4, 6, 1);
			g.drawRect(0, 6, 6, 1);
			result = GBDUtil.toBD(skin);
			_icons[VSCROLL_BAR_THUMB_ICON] = result;
			return result;
		}
	}
}
