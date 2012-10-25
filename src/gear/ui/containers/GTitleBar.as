package gear.ui.containers {
	import gear.gui.controls.GButton;
	import gear.log4a.GLogger;
	import gear.ui.controls.GLabel;
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GTitleBarData;
	import gear.ui.layout.GLayout;

	/**
	 * 标题条控件
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GTitleBar extends GBase {
		/**
		 * @private
		 */
		protected var _data : GTitleBarData;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _layout : GLayout;
		protected var _close_Btn : GButton;

		/**
		 * @private
		 */
		override protected function create() : void {
			_label = new GLabel(_data.labelData);
			_close_Btn = new GButton(_data.closeButtonData);
			if (_data.bgSkin != null) {
				addChild(_data.bgSkin);
			}
			addChild(_label);
			addChild(_close_Btn);
			switch(_data.scaleMode) {
				case GScaleMode.WIDTH_ONLY:
					_height = _data.bgSkin.height;
					break;
				case GScaleMode.NONE:
					_width = _data.bgSkin.width;
					_height = _data.bgSkin.height;
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			switch(_data.scaleMode) {
				case GScaleMode.SCALE9GRID:
					_data.bgSkin.width = _width;
					_data.bgSkin.height = _height;
					break;
				case GScaleMode.WIDTH_ONLY:
					_data.bgSkin.width = _width;
					break;
				case GScaleMode.NONE:
					break;
				default:
					GLogger.error("scale mode is invalid!");
					break;
			}
			GLayout.layout(_label);
			GLayout.layout(_close_Btn);
		}

		public function GTitleBar(data : GTitleBarData) {
			_data = data;
			super(data);
		}

		/**
		 * 设置标题文本
		 * 
		 * @param value 标题文本
		 */
		public function set text(value : String) : void {
			_label.text = value;
			GLayout.layout(_label);
		}

		public function get close_Btn() : GButton {
			return _close_Btn;
		}
	}
}
