package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GProgressBarData;
	import gear.ui.layout.GLayout;
	import gear.ui.skin.pb.PolledSkin;

	/**
	 * 进度条控件
	 * 
	 * @author bright
	 * @version 201001015
	 */
	public class GProgressBar extends GBase {
		/**
		 * @private
		 */
		protected var _data : GProgressBarData;
		/**
		 * @private
		 */
		protected var _polledSkin : PolledSkin;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _value : int = 0;
		/**
		 * @private
		 */
		protected var _max : int = 100;
		/**
		 * @private
		 */
		protected var _mode : int;

		/**
		 * @private
		 */
		override protected function create() : void {
			_data.skin.addTo(this, _data.mode, _data.scale, _data.padding);
			_label = new GLabel(_data.labelData);
			_mode = _data.mode;
			_value = _data.value;
			_max = _data.max;
			addChild(_label);
			switch(_data.scaleMode) {
				case GScaleMode.WIDTH_ONLY:
					_height = _data.skin.height;
					break;
				case GScaleMode.NONE:
					if (_data.skin != null) {
						_width = _data.skin.width;
						_height = _data.skin.height;
					}
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_data.skin.setSize(_width, _height);
			GLayout.layout(_label);
			reset();
		}

		/**
		 * @private
		 */
		protected function reset() : void {
			_data.skin.percent = _value / _max;
		}

		/**
		 * @inheritDoc
		 */
		public function GProgressBar(data : GProgressBarData) {
			_data = data;
			super(data);
		}

		/**
		 * @param 模式
		 */
		public function set mode(value : int) : void {
			_data.skin.mode = value;
		}

		/**
		 * @param value 文本
		 */
		public function set text(value : String) : void {
			_label.text = value;
			GLayout.layout(_label);
		}

		/**
		 * @param value 当前值
		 */
		public function set value(value : int) : void {
			if (_value == value) {
				return;
			}
			_value = Math.max(0, Math.min(value, _max));
			reset();
		}

		/**
		 * @return 当前值 
		 */
		public function get value() : int {
			return _value;
		}

		/**
		 * @return 最大值
		 */
		public function set max(value : int) : void {
			if (_max == value) {
				return;
			}
			_max = Math.max(_value, value);
			reset();
		}

		public function get max() : int {
			return _max;
		}
	}
}
