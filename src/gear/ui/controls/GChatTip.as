package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GChatTipData;
	import gear.ui.manager.UIManager;

	import flash.display.Sprite;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 聊天提示框控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GChatTip extends GBase {
		private var _data : GChatTipData;
		private var _bodySkin : Sprite;
		private var _tailSkin : Sprite;
		private var _label : GLabel;
		private var _timeout : uint;

		/**
		 * @private
		 */
		override protected function create() : void {
			_bodySkin = UIManager.getSkin(_data.bodyAsset);
			_tailSkin = UIManager.getSkin(_data.tailAsset);
			_tailSkin.x = -int(_tailSkin.width * 0.5);
			_tailSkin.y = -_tailSkin.height - 1;
			_data.labelData.width = _data.maxWidth - _data.gap * 2;
			_label = new GLabel(_data.labelData);
			addChild(_bodySkin);
			addChild(_tailSkin);
			addChild(_label);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_width = Math.max(_data.minWidth, Math.min(_data.maxWidth, _label.width + _data.gap * 2));
			_height = Math.max(_data.minHeight, Math.min(_data.maxHeight, _label.height + _data.gap * 2));
			_bodySkin.width = _width;
			_bodySkin.height = _height - _tailSkin.height;
			_bodySkin.x = -int(_width * 0.5);
			_bodySkin.y = -_height;
			_label.x = -int(_label.width * 0.5);
			_label.y = -_height + int((_bodySkin.height - _label.height) * 0.5);
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			super.onShow();
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_timeout = setTimeout(hide, _data.timeout * 1000);
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			super.onHide();
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GChatTip(data : GChatTipData) {
			_data = data;
			super(_data);
		}

		/**
		 * @param value 设置聊天文本
		 */
		public function set text(value : String) : void {
			_label.text = value;
			layout();
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_timeout = setTimeout(hide, _data.timeout * 1000);
		}

		/**
		 * @return 聊天文本
		 */
		public function get text() : String {
			return _label.text;
		}

		/**
		 * 设置HTML格式的聊天文本
		 * 
		 * @param value HTML格式的聊天文本
		 */
		public function set htmlText(value : String) : void {
			_label.htmlText = value;
		}

		/**
		 * @return 格式的聊天文本
		 */
		public function get htmlText() : String {
			return _label.htmlText;
		}
	}
}
