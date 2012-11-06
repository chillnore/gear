package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GTextInputData;
	import gear.ui.manager.GUIUtil;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	/**
	 * 文本输入框控件
	 * 
	 * @author bright
	 * @version 20101012
	 */
	public class GTextInput extends GBase {
		/**
		 * @eventType gear.ui.controls.GTextInput.ENTER
		 */
		public static const ENTER : String = "enter";
		/**
		 * @private
		 */
		protected var _data : GTextInputData;
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _textField : TextField;
		/**
		 * @private
		 */
		protected var _current : DisplayObject;

		/**
		 * @private
		 */
		override protected function create() : void {
			_current = _data.borderSkin;
			if (_data.textField == null) {
				_textField = GUIUtil.getInputTextField();
				_textField.defaultTextFormat = _data.textFormat;
				_textField.condenseWhite = true;
				_textField.textColor = _data.color.upColor;
				_textField.filters = _data.textFieldFilters;
				_textField.maxChars = _data.maxChars;
				_textField.displayAsPassword = _data.displayAsPassword;
				_textField.text = _data.text;
				if (_data.restrict.length > 0) {
					_textField.restrict = _data.restrict;
				}
			} else {
				_textField = _data.textField;
			}
			_textField.x = 3;
			if (_data.labelData != null) {
				_label = new GLabel(_data.labelData);
				addChild(_label);
				_current.x = _label.width + 3;
				_textField.x = _label.width + 6;
			}
			addChild(_current);
			addChild(_textField);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_data.borderSkin.width = _width;
			_data.borderSkin.height = _height;
			_data.disabledSkin.width = _width;
			_data.disabledSkin.height = _height;
			_textField.y = Math.floor((_height - _textField.textHeight - 4) / 2);
			_textField.width = _width - 4;
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			if (_enabled) {
				GUIUtil.replace(_current, _data.borderSkin);
				_current = _data.borderSkin;
				_textField.textColor = _data.color.upColor;
			} else {
				GUIUtil.replace(_current, _data.disabledSkin);
				_current = _data.disabledSkin;
				_textField.textColor = _data.color.disabledColor;
			}
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			if (Capabilities.hasIME) {
				IME.enabled = _data.allowIME;
			}
			_textField.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			if (_data.maxChars > 0) {
				_textField.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			}
			_textField.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			_textField.removeEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			if (_data.maxChars > 0) {
				_textField.removeEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			}
			_textField.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			_textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			if (Capabilities.hasIME) {
				IME.enabled = false;
			}
			if (stage.focus == _textField) {
				stage.focus = null;
			}
		}

		private function textInputHandler(event : TextEvent) : void {
			var newEvent : TextEvent = new TextEvent(TextEvent.TEXT_INPUT, false, true);
			newEvent.text = event.text;
			dispatchEvent(newEvent);
			if (newEvent.isDefaultPrevented()) {
				event.preventDefault();
			}
		}

		private function focusInHandler(event : FocusEvent) : void {
			if (Capabilities.hasIME) {
				IME.enabled = _data.allowIME;
			}
			dispatchEvent(event);
		}

		private function focusOutHandler(event : FocusEvent) : void {
			if (Capabilities.hasIME) {
				IME.enabled = false;
			}
			dispatchEvent(event);
		}

		private function keyDownHandler(event : KeyboardEvent) : void {
			if (event.keyCode == Keyboard.ENTER) {
				if (stage.focus == _textField) {
					dispatchEvent(new Event(GTextInput.ENTER));
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GTextInput(data : GTextInputData) {
			_data = data;
			super(data);
		}

		/**
		 * 选择所有输入文本
		 */
		public function selectAll() : void {
			if (_textField.text.length > 0) {
				_textField.setSelection(0, _textField.text.length);
			}
			GUIUtil.root.stage.focus = _textField;
		}

		/**
		 * @param focus 设置焦点
		 */
		public function setFocus(focus : Boolean = true) : void {
			if (focus) {
				if (GUIUtil.root.stage.focus != _textField) {
					GUIUtil.root.stage.focus = _textField;
				}
			} else {
				if (GUIUtil.root.stage.focus == _textField) {
					GUIUtil.root.stage.focus = null;
				}
			}
		}

		/**
		 * @return Boolean 是否为焦点
		 */
		public function isFocus() : Boolean {
			return GUIUtil.root.stage.focus == _textField;
		}

		/**
		 * 设置输入文本
		 * 
		 * @param value 输入文本
		 */
		public function set text(value : String) : void {
			_textField.text = value;
		}

		/**
		 * 获得输入文本
		 * 
		 * @return 输入文本
		 */
		public function get text() : String {
			return _textField.text;
		}

		/**
		 * return 文本字段
		 */
		public function get textField() : TextField {
			return _textField;
		}

		/**
		 * 清除输入文本
		 */
		public function clear() : void {
			_textField.text = "";
		}
	}
}
