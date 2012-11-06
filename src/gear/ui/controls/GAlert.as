package gear.ui.controls {
	import gear.ui.containers.GPanel;
	import gear.ui.core.GAlign;
	import gear.ui.data.GAlertData;
	import gear.ui.data.GButtonData;
	import gear.ui.layout.GLayout;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setTimeout;

	/**
	 * 对话框控件
	 * 
	 * @author bright
	 * @version 20111128
	 */
	public class GAlert extends GPanel {
		public static const NONE : uint = 0x0000;
		public static const OK : uint = 0x0004;
		public static const CANCEL : uint = 0x0008;
		public static const YES : uint = 0x0001;
		public static const NO : uint = 0x0002;
		private var _alertData : GAlertData;
		private var _label : GLabel;
		private var _textInput : GTextInput;
		private var _buttons : Array;
		private var _timeout : int = 0;
		private var _detail : uint;

		private function initView() : void {
			addGLabels();
			addGTextInput();
			addGButtons();
			autoSize();
		}

		private function addGLabels() : void {
			_label = new GLabel(_alertData.labelData);
			add(_label);
		}

		private function addGTextInput() : void {
			if (_alertData.textInputData) {
				_alertData.textInputData.align = new GAlign(-1, -1, -1, -1, 0, -1);
				_textInput = new GTextInput(_alertData.textInputData);
				add(_textInput);
			}
		}

		private function addGButtons() : void {
			_buttons = new Array();
			if (_alertData.flag == NONE) {
				return;
			}
			var data : GButtonData;
			var button : GButton;
			if (_alertData.flag & OK) {
				data = _alertData.buttonData.clone();
				data.labelData.text = _alertData.okLabel;
				button = new GButton(data);
				button.source = OK;
				_buttons.push(button);
			}
			if (_alertData.flag & YES) {
				data = _alertData.buttonData.clone();
				data.labelData.text = _alertData.yesLabel;
				button = new GButton(data);
				button.source = YES;
				_buttons.push(button);
			}
			if (_alertData.flag & NO) {
				data = _alertData.buttonData.clone();
				data.labelData.text = _alertData.noLabel;
				button = new GButton(data);
				button.source = NO;
				_buttons.push(button);
			}
			if (_alertData.flag & CANCEL) {
				data = _alertData.buttonData.clone();
				data.labelData.text = _alertData.cancelLabel;
				button = new GButton(data);
				button.source = CANCEL;
				_buttons.push(button);
			}
			for each (button in _buttons) {
				button.addEventListener(MouseEvent.CLICK, clickHandler);
				add(button);
			}
		}

		private function clickHandler(event : MouseEvent) : void {
			var source : uint = GButton(event.currentTarget).source;
			if (source == YES) {
				_detail = YES;
			} else if (source == NO) {
				_detail = NO;
			} else if (source == OK) {
				_detail = OK;
			} else if (source == CANCEL) {
				_detail = CANCEL;
			} else {
				_detail = NONE;
			}
			hide();
			dispatchEvent(new Event(Event.CLOSE));
		}

		/**
		 * @private
		 */
		protected function autoSize() : void {
			var labelW : int = _label.width;
			var labelH : int = _label.height + (_alertData.flag == GAlert.NONE ? 0 : _alertData.vgap);
			var textInputW : int = (_textInput == null ? 0 : _textInput.width);
			var textInputH : int = (_textInput == null ? 0 : _textInput.height + _alertData.vgap);
			var buttonW : int = 0;
			var buttonH : int = 0;
			var button : GButton;
			for each (button in _buttons) {
				buttonW += button.width;
				buttonH = Math.max(buttonH, button.height);
			}
			buttonW += (_buttons.length - 1) * _alertData.hgap;
			var padding : int = _data.padding << 1;
			_width = Math.max(_data.minWidth, Math.max(labelW, textInputW, buttonW) + padding);
			_height = Math.max(_data.minHeight, labelH + textInputH + buttonH + padding);
			var viewW : int = _width - padding;
			var viewH : int = _height - padding;
			_label.x = (viewW - _label.width) >> 1;
			_label.y = (viewH - labelH - textInputH - buttonH) >> 1;
			if (_textInput != null) {
				_textInput.x = (viewW - textInputW) >> 1;
				_textInput.y = _label.height + _alertData.vgap;
				GLayout.layout(_textInput);
			}
			if (_alertData.flag != GAlert.NONE) {
				var newY : int = viewH - buttonH;
				var newW : int = buttonW;
				var newX : int = (viewW - newW) >> 1;
				for each (button in _buttons) {
					button.moveTo(newX, newY);
					newX += button.width + _alertData.hgap;
				}
			}
			super.layout();
		}

		private function textInput_enterHandler(event : Event) : void {
			var source : uint = GButton(event.currentTarget).source;
			if (source == YES) {
				_detail = YES;
			} else if (source == NO) {
				_detail = NO;
			} else if (source == OK) {
				_detail = OK;
			} else if (source == CANCEL) {
				_detail = CANCEL;
			} else {
				_detail = NONE;
			}
			hide();
			dispatchEvent(new Event(Event.CLOSE));
		}

		/**
		 * @private
		 */
		protected function initEvents() : void {
			if (_textInput) {
				_textInput.addEventListener(GTextInput.ENTER, textInput_enterHandler);
			}
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			super.onShow();
			if (_timeout != 0) {
				clearInterval(_timeout);
				_timeout = 0;
			}
			if (_textInput != null) {
				_textInput.setFocus();
				_textInput.selectAll();
			}
			GLayout.layout(this);
		}

		/**
		 * @inheritDoc
		 * @see gear.ui.data.GAlertData
		 */
		public function GAlert(data : GAlertData) {
			_alertData = data;
			super(data);
			initView();
			initEvents();
		}

		/**
		 * @inheritDoc
		 */
		override public function hide() : void {
			super.hide();
			if (_timeout != 0) {
				clearInterval(_timeout);
				_timeout = 0;
			}
		}

		public function set flag(flag : uint) : void {
			if (_alertData.flag == flag) {
				return;
			}
			_alertData.flag = flag;
			for each (var button:GButton in _buttons) {
				button.hide();
			}
			addGButtons();
			autoSize();
			GLayout.layout(this);
		}

		/**
		 * 延迟显示
		 * 
		 * @param delay 延迟时间 @default 500ms
		 */
		public function showWait(delay : int = 500) : void {
			if (_timeout != 0) {
				clearInterval(_timeout);
				_timeout = 0;
			}
			_timeout = setTimeout(show, delay);
		}

		/**
		 * @return 文本
		 */
		public function set label(value : String) : void {
			_label.text = value;
			autoSize();
		}

		/**
		 * @param 输入框控件
		 */
		public function set inputText(value : String) : void {
			if (_textInput != null) {
				_textInput.text = String(value);
			}
		}

		public function get inputText() : String {
			if (_textInput) {
				return _textInput.text;
			}
			return "";
		}

		public function get detail() : uint {
			return _detail;
		}

		public function get textInput() : GTextInput {
			return _textInput;
		}
	}
}
