package gear.ui.game {
	import gear.render.FrameRender;
	import gear.render.RenderCall;
	import gear.ui.core.GBase;
	import gear.ui.model.RangeModel;
	import gear.utils.GColorUtil;

	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 血条组件
	 * 
	 * @author bright
	 * @version 20120627
	 */
	public class BloodBar extends GBase {
		protected var _data : BloodBarData;
		protected var _model : RangeModel;
		protected var _fade : RenderCall;
		protected var _isSub : Boolean;
		protected var _hide : uint;

		override protected function create() : void {
			addChild(_data.trackSkin);
			_data.oldBarSkin.x = _data.padding;
			_data.oldBarSkin.y = _data.padding;
			addChild(_data.oldBarSkin);
			_data.barSkin.x = _data.padding;
			_data.barSkin.y = _data.padding;
			addChild(_data.barSkin);
		}

		override protected function layout() : void {
			_data.trackSkin.width = _width;
			_data.trackSkin.height = _height;
			var bw : int = Math.round((_width - _data.padding * 2) * _model.percent);
			var bh : int = _height - _data.padding * 2;
			_data.oldBarSkin.width = bw;
			_data.barSkin.width = bw;
			_data.oldBarSkin.height = bh;
			_data.barSkin.height = bh;
		}

		private function model_changeHandler(event : Event) : void {
			resetFade();
		}

		private function resetFade() : void {
			var bw : int = Math.round((_width - _data.padding * 2) * _model.percent);
			if (_model.value < _model.oldValue) {
				_data.barSkin.width = bw;
				_isSub = true;
			} else {
				_data.oldBarSkin.width = bw;
				_isSub = false;
			}
			_fade.reset();
			FrameRender.instance.add(_fade);
			hideWait();
		}

		private function resetBars() : void {
			var bw : int = Math.round((_width - _data.padding * 2) * _model.percent);
			_data.oldBarSkin.width = bw;
			_data.barSkin.width = bw;
		}

		private function checkFade() : void {
			if (_fade.count > 19) {
				FrameRender.instance.remove(_fade);
			} else {
				var b : int;
				var c : int;
				if (_isSub) {
					b = _data.oldBarSkin.width;
					c = _data.barSkin.width - _data.oldBarSkin.width;
					_data.oldBarSkin.width = Math.round(_data.ease(_fade.count + 1, b, c, 20));
				} else {
					b = _data.barSkin.width;
					c = _data.oldBarSkin.width - _data.barSkin.width;
					_data.barSkin.width = Math.round(_data.ease(_fade.count + 1, b, c, 20));
				}
			}
		}

		private function hideWait() : void {
			if (_hide != 0) {
				clearTimeout(_hide);
				_hide = 0;
			}
			_hide = setTimeout(hide, 3000);
		}

		public function BloodBar(data : BloodBarData) {
			_data = data;
			_model = new RangeModel();
			super(data);
			_model.addEventListener(Event.CHANGE, model_changeHandler);
			_fade = new RenderCall(checkFade);
		}

		/**
		 * @return 范围模型
		 */
		public function get model() : RangeModel {
			return _model;
		}

		public function reset(max : int) : void {
			FrameRender.instance.remove(_fade);
			_model.fireEvent = false;
			_model.resetRange(max, 0, max);
			resetBars();
			_model.fireEvent = true;
		}

		public function resetColor(value : uint) : void {
			_data.barSkin.color = value;
			_data.oldBarSkin.color = GColorUtil.adjustBrightness(value, 127);
		}
	}
}
