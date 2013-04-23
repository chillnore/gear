package gear.gui.game {
	import gear.gui.core.GBase;
	import gear.gui.core.GColor;
	import gear.gui.core.GPhase;
	import gear.gui.model.GRangeModel;
	import gear.gui.skins.GPhaseSkin;
	import gear.gui.skins.IGSkin;
	import gear.motion.easing.Cubic;
	import gear.render.GFrameRender;
	import gear.render.GRenderCall;
	import gear.utils.GBDUtil;
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;
	import gear.utils.GMathUtil;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 血条控件
	 * 
	 * @author bright
	 * @version 20121212
	 */
	public class GBloodBar extends GBase {
		protected var _trackSkin : IGSkin;
		protected var _oldBarSkin : IGSkin;
		protected var _barSkin : IGSkin;
		protected var _ease : Function;
		protected var _model : GRangeModel;
		protected var _fade : GRenderCall;
		protected var _isSub : Boolean;
		protected var _autoHide : Boolean;
		protected var _hide : uint;

		override protected function preinit() : void {
			_trackSkin = new GPhaseSkin();
			var skin : Shape = new Shape();
			var g : Graphics = skin.graphics;
			GDrawUtil.drawFillBorder(g, 0x000000, 0.6, 0, 0, 50, 50);
			GDrawUtil.drawFillRect(g, 0x000000, 0.05, 1, 1, 48, 48);
			GDrawUtil.drawFillRect(g, 0x000000, 0.2, 1, 1, 48, 1);
			_trackSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			_trackSkin.scale9Grid = new Rectangle(2, 2, 46, 46);
			_oldBarSkin = new GPhaseSkin();
			g.clear();
			GDrawUtil.drawFillBorder(g, 0, 0.6, 0, 0, 50, 50);
			var color : uint = GColorUtil.adjustBrightness(GColor.GREEN, 127);
			GDrawUtil.drawFillRect(g, color, 0.7, 1, 1, 48, 48);
			_oldBarSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			_oldBarSkin.scale9Grid = new Rectangle(1, 1, 48, 48);
			_barSkin = new GPhaseSkin();
			g.clear();
			GDrawUtil.drawFillBorder(g, 0, 0.6, 0, 0, 50, 50);
			color = GColor.GREEN;
			GDrawUtil.drawFillRect(g, color, 0.7, 1, 1, 48, 48);
			_barSkin.setAt(GPhase.UP, GBDUtil.toBD(skin));
			_barSkin.scale9Grid = new Rectangle(1, 1, 48, 48);
			_ease = Cubic.easeIn;
			_model = new GRangeModel();
			_model.onChange = modelOnChange;
			_fade = new GRenderCall(checkFade);
			_autoHide = true;
			setSize(60, 6);
		}

		override protected function create() : void {
			_trackSkin.addTo(this, 0);
			_oldBarSkin.addTo(this, 1);
			_barSkin.addTo(this, 2);
		}

		override protected function resize() : void {
			_trackSkin.setSize(_width, _height);
			var bw : int = GMathUtil.round((_width - _padding.left - _padding.right) * _model.percent);
			var bh : int = _height - _padding.top - _padding.bottom;
			_oldBarSkin.setSize(bw, bh);
			_barSkin.setSize(bw, bh);
		}

		private function modelOnChange() : void {
			resetFade();
		}

		protected function resetFade() : void {
			var bw : int = GMathUtil.round((_width - _padding.left - _padding.right) * _model.percent);
			if (_model.value < _model.oldValue) {
				_barSkin.setSize(bw, _barSkin.height);
				_isSub = true;
			} else {
				_oldBarSkin.setSize(bw, _oldBarSkin.height);
				_isSub = false;
			}
			_fade.reset();
			GFrameRender.instance.add(_fade);
			if (_autoHide) {
				hideWait();
			}
		}

		protected function resetBars() : void {
			var bw : int = GMathUtil.round((_width - _padding.left - _padding.right) * _model.percent);
			_oldBarSkin.setSize(bw, _oldBarSkin.height);
			_barSkin.setSize(bw, _barSkin.height);
		}

		protected function checkFade() : void {
			if (_fade.count > 19) {
				GFrameRender.instance.remove(_fade);
			} else {
				var b : int;
				var c : int;
				if (_isSub) {
					b = _oldBarSkin.width;
					c = _barSkin.width - _oldBarSkin.width;
					_oldBarSkin.setSize(GMathUtil.round(_ease(_fade.count + 1, b, c, 20)), _oldBarSkin.height);
				} else {
					b = _barSkin.width;
					c = _oldBarSkin.width - _barSkin.width;
					_barSkin.setSize(GMathUtil.round(_ease(_fade.count + 1, b, c, 20)), _barSkin.height);
				}
			}
		}

		protected function hideWait() : void {
			if (_hide != 0) {
				clearTimeout(_hide);
				_hide = 0;
			}
			_hide = setTimeout(hide, 3000);
		}

		public function GBloodBar() {
		}

		public function set autoHide(value : Boolean) : void {
			_autoHide = value;
		}

		/**
		 * @return 范围模型
		 */
		public function get model() : GRangeModel {
			return _model;
		}

		public function reset(max : int) : void {
			GFrameRender.instance.remove(_fade);
			_model.setTo(max, 0, max);
			callLater(resetBars);
		}

		/**
		 * 设置血条颜色
		 */
		public function set color(value : uint) : void {
		}
	}
}
