package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GToolTipData;

	/**
	 * 提示框控件
	 * 
	 * @author bright
	 * @version 20101125
	 */
	public class GToolTip extends GBase {
		/**
		 * @private
		 */
		protected var _data : GToolTipData;
		/**
		 * @private
		 */
		protected var _label : GLabel;

		/**
		 * @private
		 */
		override protected function create() : void {
			if (_data.bgSkin != null) {
				addChild(_data.bgSkin);
			}
			_label = new GLabel(_data.labelData);
			_label.x = _label.y = _data.padding;
			addChild(_label);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_width = _label.width + _data.padding * 2;
			_height = _label.height + _data.padding * 2;
			if (_data.bgSkin != null) {
				_data.bgSkin.width = _width;
				_data.bgSkin.height = _height;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GToolTip(data : GToolTipData) {
			_data = data;
			super(data);
			mouseEnabled = mouseChildren = false;
		}

		/**
		 * 获得提示框控件定义
		 * 
		 * @return 提示框控件定义
		 */
		public function get data() : GToolTipData {
			return _data;
		}

		/**
		 * 获得提示文本
		 * 
		 * @return 提示文本
		 */
		public function get text() : String {
			return _label.text;
		}

		/**
		 * @inheritDoc
		 */
		override public function set source(value : *) : void {
			if (value == null) {
				_label.clear();
			} else {
				_label.text = String(value);
				layout();
			}
			_source = value;
		}
	}
}