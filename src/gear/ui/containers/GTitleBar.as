package gear.ui.containers {
	import gear.log4a.GLogger;
	import gear.ui.controls.GLabel;
	import gear.ui.core.GBase;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GTitleBarData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.UIManager;

	import flash.display.Sprite;

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
		protected var _bgSkin : Sprite;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _layout : GLayout;

		/**
		 * @private
		 */
		override protected function create() : void {
			_bgSkin = UIManager.getSkin(_data.bgAsset);
			_label = new GLabel(_data.labelData);
			addChild(_bgSkin);
			addChild(_label);
			switch(_data.scaleMode) {
				case ScaleMode.WIDTH_ONLY:
					_height = _bgSkin.height;
					break;
				case ScaleMode.NONE:
					_width = _bgSkin.width;
					_height = _bgSkin.height;
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			switch(_data.scaleMode) {
				case ScaleMode.SCALE9GRID:
					_bgSkin.width = _width;
					_bgSkin.height = _height;
					break;
				case ScaleMode.WIDTH_ONLY:
					_bgSkin.width = _width;
					break;
				case ScaleMode.NONE:
					break;
				default:
					GLogger.error("scale mode is invalid!");
					break;
			}
			GLayout.layout(_label);
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
	}
}
