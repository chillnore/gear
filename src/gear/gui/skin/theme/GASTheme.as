package gear.gui.skin.theme {
	import gear.gui.core.GPhase;
	import gear.gui.skin.GPhaseSkin;
	import gear.gui.skin.IGSkin;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
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
		private static const EMPTY_SKIN : int = 0;
		private static const BUTTON_SKIN : int = 1;
		private static const CHECK_BOX_ICON : int = 2;
		private static const PROGRESS_BAR_TRACK_SKIN:int=3;
		private static const PROGRESS_BAR_BAR_SKIN:int=4;
		private static const RADIO_BUTTON_ICON : int = 5;
		private static const SCROLL_BAR_TRACK_SKIN : int = 6;
		private static const SCROLL_BAR_THUMB_SKIN : int = 7;
		private static const SCROLL_BAR_ARROW_UP_SKIN : int = 8;
		private static const SCROLL_BAR_ARROW_DOWN_SKIN : int = 9;
		private static const TOGGLE_BUTTON_SKIN : int = 10;
		private static const SCROLL_BAR_THUMB_ICON : int = 0;
		private var _caches : Vector.<IGSkin>;
		private var _icons : Vector.<BitmapData>;

		public function GASTheme() {
			_caches = new Vector.<IGSkin>(11, true);
			_icons = new Vector.<BitmapData>(1, true);
		}

		public function get emptySkin() : IGSkin {
			var result : IGSkin = _caches[EMPTY_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var bd : BitmapData = new BitmapData(60, 60, true, 0);
			// bd.fillRect(bd.rect, 0x330000FF);
			result.setAt(GPhase.UP, bd);
			_caches[EMPTY_SKIN] = result;
			return result;
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
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(4, 4, 60 - 8, 22 - 8);
			_caches[BUTTON_SKIN] = result;
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
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_UP, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_OVER, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_DOWN, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_DISABLED, GBDUtil.shapeToBD(skin));
			_caches[CHECK_BOX_ICON] = result;
			return result;
		}
		
		public function get progressBarTrackSkin():IGSkin{
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
			result.setAt(GPhase.UP,GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(2,2,10,10);
			_caches[PROGRESS_BAR_TRACK_SKIN]=result;
			return result;
		}
		
		public function get progressBarBarSkin():IGSkin{
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
			result.setAt(GPhase.UP,GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(2,2,10,10);
			_caches[PROGRESS_BAR_BAR_SKIN]=result;
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
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginFill(0xFFFFFF, 1);
			g.drawCircle(7, 7, 6);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xB7BABC, 0.3), GColorUtil.getAlphaColor(0x5B5D5E, 0.3)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 7);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xFFFFFF, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawCircle(7, 7, 6);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_UP, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_OVER, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_DOWN, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.SELECTED_DISABLED, GBDUtil.shapeToBD(skin));
			return result;
		}

		public function get scrollBarTrackSkin() : IGSkin {
			var result : IGSkin = _caches[SCROLL_BAR_TRACK_SKIN];
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
			g.beginGradientFill(GradientType.LINEAR, [0x94999B,0xE7E7E7], [1, 1], [0, 255], mtx);
			g.drawRect(1, 0, 13, 100);
			g.endFill();
			g.beginFill(0x585F63, 1);
			g.drawRect(14, 0, 1, 100);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
			g.clear();
			g.beginFill(0xA5A5A5, 1);
			g.drawRect(0, 0, 1, 100);
			g.endFill();
			mtx.createGradientBox(13, 100, GMathUtil.angleToRadian(0), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xDDDDDD,0xEEEEEE], [1, 1], [0, 255], mtx);
			g.drawRect(1, 0, 13, 100);
			g.endFill();
			g.beginFill(0xA5A5A5, 1);
			g.drawRect(14, 0, 1, 100);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(1, 0, 13, 100);
			_caches[SCROLL_BAR_TRACK_SKIN]=result;
			return result;
		}

		public function get scrollBarThumbSkin() : IGSkin {
			var result : IGSkin = _caches[SCROLL_BAR_THUMB_SKIN];
			if (result != null) {
				return result.clone();
			}
			result = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(12, 50, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x585F63], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 0, 12, 50, 0, 3, 0, 3);
			g.endFill();
			mtx.createGradientBox(12, 48, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 11, 48, 0, 2, 0, 2);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(12, 50, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 0, 12, 50, 0, 3, 0, 3);
			g.endFill();
			mtx.createGradientBox(12, 48, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 11, 48, 0, 2, 0, 2);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(12, 50, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 0, 12, 50, 0, 3, 0, 3);
			g.endFill();
			mtx.createGradientBox(12, 48, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xD9F0FE, 0x99D7FE], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 11, 48, 0, 2, 0, 2);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(1, 1, 12 - 4, 50 - 4);
			_caches[SCROLL_BAR_THUMB_SKIN] = result;
			return result;
		}

		public function get scrollBarThumbIcon() : BitmapData {
			var result:BitmapData=_icons[SCROLL_BAR_THUMB_ICON];
			if(result!=null){
				return result;
			}
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			g.beginFill(0x5A6165,1);
			g.drawRect(0, 0, 5, 1);
			g.drawRect(0,2,5,1);
			g.drawRect(0,4,5,1);
			g.drawRect(0,6,5,1);
			result=GBDUtil.shapeToBD(skin);
			_icons[SCROLL_BAR_THUMB_ICON]=result;
			return result;
		}

		public function get scrollBarArrowUpSkin() : IGSkin {
			var result : IGSkin = _caches[SCROLL_BAR_ARROW_UP_SKIN];
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
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0,1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0,1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
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
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0,1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [0.3, 0.3], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0x888888,1);
			g.moveTo(7.5, 4);
			g.lineTo(11, 8);
			g.lineTo(4, 8);
			g.lineTo(7.5, 4);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(1,1,13,12);
			_caches[SCROLL_BAR_ARROW_UP_SKIN]=result;
			return result;
		}
		
		public function get scrollBarArrowDownSkin() : IGSkin {
			var result : IGSkin = _caches[SCROLL_BAR_ARROW_DOWN_SKIN];
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
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0,1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0,1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
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
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0,1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(15, 14, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xB7BABC, 0x5B5D5E], [0.3, 0.3], [0, 255], mtx);
			g.drawRect(0, 0, 15, 14);
			g.endFill();
			mtx.createGradientBox(13, 12, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xE6E6E6], [1, 1], [0, 255], mtx);
			g.drawRect(1, 1, 13, 12);
			g.endFill();
			mtx.createGradientBox(13, 6, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xEEEEEE], [0.3, 0], [0, 255], mtx);
			g.drawRect(1, 1, 13,6);
			g.endFill();
			g.beginFill(0x888888,1);
			g.moveTo(7.5, 9);
			g.lineTo(11, 5);
			g.lineTo(4, 5);
			g.lineTo(7.5, 9);
			g.endFill();
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(1,1,13,12);
			_caches[SCROLL_BAR_ARROW_DOWN_SKIN]=result;
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
			result.setAt(GPhase.UP, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.OVER, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.DOWN, GBDUtil.shapeToBD(skin));
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
			result.setAt(GPhase.DISABLED, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [0x009DFF, 0x0075BF], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xCCCCCC, 0.6), GColorUtil.getAlphaColor(0xCCCCCC, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			result.setAt(GPhase.SELECTED_UP, GBDUtil.shapeToBD(skin));
			g.clear();
			mtx.createGradientBox(60, 22, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0x009DFF, 0.4), GColorUtil.getAlphaColor(0x0075BF, 0.4)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(0, 0, 60, 22, 3, 3, 3, 3);
			g.endFill();
			mtx.createGradientBox(58, 20, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(GradientType.LINEAR, [GColorUtil.getAlphaColor(0xCCCCCC, 0.3), GColorUtil.getAlphaColor(0xCCCCCC, 0.2)], [1, 1], [0, 255], mtx);
			g.drawRoundRectComplex(1, 1, 58, 20, 2, 2, 2, 2);
			g.endFill();
			result.setAt(GPhase.SELECTED_DISABLED, GBDUtil.shapeToBD(skin));
			result.scale9Grid = new Rectangle(4, 4, 60 - 8, 22 - 8);
			_caches[TOGGLE_BUTTON_SKIN] = result;
			return result;
		}

		public function get textInputSkin() : IGSkin {
			return null;
		}
	}
}
