package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GScrollBarData;
	import gear.ui.data.GTextAreaData;
	import gear.ui.events.GScrollBarEvent;
	import gear.ui.manager.GUIUtil;

	import flash.events.Event;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	/**
	 * 文本框控件
	 * 
	 * @author bright
	 * @version 20100727
	 */
	public class GTextArea extends GBase {
		/**
		 * @private
		 */
		protected var _data : GTextAreaData;
		/**
		 * @private
		 */
		protected var _textField : TextField;
		/**
		 * @private
		 */
		protected var _vScrollBar : GScrollBar;
		/**
		 * @private
		 */
		protected var _hScrollBar : GScrollBar;
		/**
		 * @private
		 */
		protected var _textWidth : Number;
		/**
		 * @private
		 */
		protected var _textHeight : Number;
		/**
		 * @private
		 */
		protected var _lock : Boolean = false;

		/**
		 * @private
		 */
		override protected function create() : void {
			if(_data.bgSkin!=null){
				addChild(_data.bgSkin);
			}
			if (_data.textField == null) {
				_textField = GUIUtil.getTextField();
				_textField.defaultTextFormat = _data.textFormat;
				_textField.styleSheet = _data.styleSheet;
				_textField.textColor = _data.textColor;
				_textField.filters = _data.textFieldFilters;
			} else {
				_textField = _data.textField;
			}
			_textField.x = _textField.y = _data.padding;
			_textField.multiline = true;
			_textField.wordWrap = true;
			_textField.condenseWhite = true;
			_textField.maxChars = _data.maxChars;
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.antiAliasType = AntiAliasType.ADVANCED;
			if (_data.editable) {
				_textField.styleSheet = null;
				_textField.type = TextFieldType.INPUT;
			} else {
				_textField.type = TextFieldType.DYNAMIC;
				_textField.styleSheet = _data.styleSheet;
			}
			_textField.selectable = _data.selectable;
			addChild(_textField);
			var data : GScrollBarData = new GScrollBarData();
			data.visible = false;
			_vScrollBar = new GScrollBar(data);
			addChild(_vScrollBar);
			data = new GScrollBarData();
			data.direction = GScrollBarData.HORIZONTAL;
			data.visible = false;
			_hScrollBar = new GScrollBar(data);
			addChild(_hScrollBar);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_data.bgSkin.width = _width;
			_data.bgSkin.height = _height;
			_textField.width = _width - _data.padding * 2;
			_textField.height = _height - _data.padding * 2;
			reset();
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			reset();
			_textField.addEventListener(Event.SCROLL, textFieldScrollHandler);
			_textField.addEventListener(Event.CHANGE, textInputHandler);
		}

		protected function textInputHandler(event : Event) : void {
			// if (_data.maxChars > 0 && GStringUtil.getDwordLength(_textField.text) >= _data.maxChars) {
			// event.preventDefault();
			// _textField.text=GStringUtil.truncateToFit(_textField.text,_data.maxChars);
			// return;
			// }
			// event.stopImmediatePropagation();
			if (_textField.numLines > 3) {
				var lines : Array = _textField.htmlText.split("</P>");
				trace(lines);
				event.preventDefault();
			}
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			_textField.removeEventListener(Event.SCROLL, textFieldScrollHandler);
		}

		/**
		 * @private
		 */
		protected function reset() : void {
			var needHScroll : Boolean = _textField.maxScrollH > 0;
			var needVScroll : Boolean = vScrollMax > 0;
			var newWidth : int = _width - (needVScroll ? _vScrollBar.width : 0);
			var newHeight : int = _height - (needHScroll ? _hScrollBar.height : 0);
			_textField.width = newWidth - _data.padding * 2;
			_textWidth = _textField.textWidth;
			_textField.height = newHeight - _data.padding * 2;
			_textHeight = _textField.textHeight;
			if (needVScroll) {
				_vScrollBar.x = _width - _vScrollBar.width;
				_vScrollBar.height = newHeight;
				_vScrollBar.resetValue(_textField.bottomScrollV - _textField.scrollV + 1, 0, vScrollMax, _textField.scrollV - 1);
				if (!_vScrollBar.visible) {
					_vScrollBar.visible = true;
					_vScrollBar.addEventListener(GScrollBarEvent.SCROLL, scrollHandler, false, 0, true);
				}
			} else if (_vScrollBar.visible) {
				_vScrollBar.removeEventListener(GScrollBarEvent.SCROLL, scrollHandler, false);
				_vScrollBar.visible = false;
			}
			if (needHScroll) {
				_hScrollBar.y = _height - _hScrollBar.height;
				_hScrollBar.width = newWidth;
				_hScrollBar.resetValue(_textField.width, 0, _textField.maxScrollH, Math.min(_textField.maxScrollH, _textField.scrollH));
				if (!_hScrollBar.visible) {
					_hScrollBar.visible = true;
					_hScrollBar.addEventListener(GScrollBarEvent.SCROLL, scrollHandler, false, 0, true);
				}
			} else if (_hScrollBar.visible) {
				_hScrollBar.removeEventListener(GScrollBarEvent.SCROLL, scrollHandler, false);
				_hScrollBar.visible = false;
			}
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_textField.type = (_enabled ? (_data.editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC) : TextFieldType.DYNAMIC);
		}

		/**
		 * @private
		 */
		protected function get vScrollMax() : int {
			var max : int = _textField.numLines - _textField.bottomScrollV + _textField.scrollV - 1;
			return Math.min(max, _textField.maxScrollV - 1);
		}

		/**
		 * @private
		 */
		protected function scrollHandler(event : GScrollBarEvent) : void {
			if (event.direction == GScrollBarData.VERTICAL) {
				_textField.scrollV = event.position + 1;
			} else {
				_textField.scrollH = event.position;
			}
		}

		/**
		 * @private
		 */
		protected function textFieldScrollHandler(event : Event) : void {
			reset();
		}

		/**
		 * @inheritDoc
		 */
		public function GTextArea(data : GTextAreaData) {
			_data = data;
			super(data);
		}

		/**
		 * 追加HTML文本
		 * 
		 * @param value HTML文本
		 */
		public function appendHtmlText(value : String) : void {
			_textField.htmlText += value;
			if (_data.maxLines > 0) {
				var lines : Array = _textField.htmlText.split(_data.edlim);
				if (lines.length - 1 > _data.maxLines) {
					_textField.htmlText = _textField.htmlText.slice(String(lines[0]).length + _data.edlim.length);
				}
			}
			if (!_lock) {
				_textField.scrollV = vScrollMax + 1;
			}
		}

		/**
		 * 追加显示文本
		 * 
		 * @param value 显示文本
		 * @param color 文本颜色 
		 */
		public function appendText(value : String, color : uint = 0xCCCCCC) : void {
			var begin : int = _textField.text.length;
			_textField.appendText(value);
			_data.textFormat.color = color;
			_textField.setTextFormat(_data.textFormat, begin, _textField.text.length);
			_textField.scrollV = vScrollMax + 1;
		}

		/**
		 * 设置HTML文本
		 * 
		 * @param value HTML文本
		 */
		public function set htmlText(value : String) : void {
			_textField.htmlText = value;
			if (!_lock) {
				_textField.scrollV = vScrollMax + 1;
			}
		}

		/**
		 * 获得HTML文本
		 * 
		 * @return HTML文本
		 */
		public function get htmlText() : String {
			return _textField.htmlText;
		}

		/**
		 * 设置文本
		 * 
		 * @param value 文本
		 */
		public function set text(value : String) : void {
			_textField.text = value;
			if (!_lock) {
				_textField.scrollV = vScrollMax + 1;
			}
		}

		/**
		 * 获得文本 
		 * 
		 * @return 文本
		 */
		public function get text() : String {
			return _textField.text;
		}

		/**
		 * 获得文本字段
		 * 
		 * @return 文本字段
		 */
		public function get textField() : TextField {
			return _textField;
		}

		/**
		 * 清除文本
		 */
		public function clear() : void {
			_textField.text = "";
		}

		/**
		 * 向上滚动
		 */
		public function upScroll() : void {
			_lock = true;
			if (_textField.scrollV > 0) {
				_textField.scrollV -= 1;
			}
		}

		/**
		 * 向下滚动
		 */
		public function downScroll() : void {
			_lock = true;
			if (_textField.scrollV < vScrollMax + 1) {
				_textField.scrollV += 1;
			}
		}

		/**
		 * 置底
		 */
		public function scrollToBottom() : void {
			_lock = false;
			_textField.scrollV = vScrollMax + 1;
		}
	}
}
