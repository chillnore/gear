package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GPhaseColor;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;

	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	/**
	 * 文本输入框控件
	 * 
	 * @author bright
	 * @version 20130307
	 */
	public class GTextInput extends GBase {
		protected var _borderSkin : IGSkin;
		protected var _textField : TextField;
		protected var _label : GLabel;
		protected var _phase : int;
		protected var _phaseColor : GPhaseColor;
		protected var _text : String;
		protected var _onEnter : Function;

		override protected function preinit() : void {
			_padding.left = _padding.right = 2;
			_phaseColor = new GPhaseColor();
			_phaseColor.setAt(GPhase.UP, 0x111111);
			_phaseColor.setAt(GPhase.DISABLED, 0x666666);
			setSize(100, 22);
		}

		override protected function create() : void {
			_borderSkin = GUIUtil.theme.textInputBorderSkin;
			_borderSkin.addTo(this, 0);
			_textField = GUIUtil.getInputTextField();
			addChild(_textField);
			_label = new GLabel();
			addChild(_label);
		}

		override protected function resize() : void {
			_textField.y = (_height - (_textField.textHeight + 1)) >> 1;
			_borderSkin.moveTo(_label.width < 1 ? 0 : _label.width + 3, 0);
			_borderSkin.setSize(_width - _borderSkin.x, _height);
			_textField.x = _borderSkin.x + _padding.left;
			_textField.width = _width - _borderSkin.x - _padding.left - _padding.right;
		}

		override protected function onShow() : void {
			addEvent(_textField, FocusEvent.FOCUS_IN, focusHandler);
			addEvent(_textField, FocusEvent.FOCUS_OUT, focusHandler);
			addEvent(_textField, TextEvent.TEXT_INPUT, textInputHandler);
			addEvent(this, KeyboardEvent.KEY_UP, keyUpHandler);
		}

		override protected function onHide() : void {
			setFocus(false);
		}

		override protected function onEnabled() : void {
			if (!_enabled) {
				_phase = GPhase.DISABLED;
				callLater(updatePhase);
			}
		}

		protected function updateLabel() : void {
			_borderSkin.moveTo(_label.width < 1 ? 0 : _label.width + 3, 0);
			_borderSkin.setSize(_width - _borderSkin.x, _height);
			_textField.x = _borderSkin.x + _padding.left;
			_textField.width = _width - _borderSkin.x - _padding.left - _padding.right;
		}

		protected function updateText() : void {
			_textField.text = (_text == null ? "" : _text);
			var end : int = _textField.text.length + 1;
			_textField.setSelection(end, end);
		}

		protected function focusHandler(event : FocusEvent) : void {
			if (event.type == FocusEvent.FOCUS_IN) {
				_phase = GPhase.FOCUS;
			} else if (event.type == FocusEvent.FOCUS_OUT) {
				_phase = _enabled ? GPhase.UP : GPhase.DISABLED;
			}
			callLater(updatePhase);
		}

		protected function textInputHandler(event : TextEvent) : void {
			if (_textField.text.length > 100) {
				event.preventDefault();
			}
		}

		protected function keyUpHandler(event : KeyboardEvent) : void {
			if (event.keyCode != Keyboard.ENTER || stage.focus != _textField || _onEnter == null) {
				return;
			}
			try {
				_onEnter();
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		protected function updatePhase() : void {
			_borderSkin.phase = _phase;
		}

		public function GTextInput() {
		}

		public function setPhaseColor(phase : int, color : uint) : void {
			_phaseColor.setAt(phase, color);
			_textField.textColor = _phaseColor.getBy(_phase);
		}

		public function set skin(value : IGSkin) : void {
			if (_borderSkin == value) {
				return;
			}
			if (_borderSkin != null) {
				_borderSkin.remove();
			}
			_borderSkin = value;
			_borderSkin.addTo(this);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_borderSkin.width, _borderSkin.height);
			}
			callLater(updatePhase);
		}

		public function set displayAsPassword(value : Boolean) : void {
			_textField.displayAsPassword = value;
		}

		public function set label(value : String) : void {
			_label.text = value;
			callLater(updateLabel);
		}

		/**
		 * 选择所有输入文本
		 */
		public function selectAll() : void {
			if (_textField.text.length > 0) {
				_textField.setSelection(0, _textField.text.length);
			}
			GUIUtil.stage.focus = _textField;
		}

		/**
		 * @param focus 设置焦点
		 */
		public function setFocus(focus : Boolean = true) : void {
			if (focus) {
				if (GUIUtil.stage.focus != _textField) {
					GUIUtil.stage.focus = _textField;
					_phase = GPhase.FOCUS;
					callLater(updatePhase);
				}
			} else {
				if (GUIUtil.stage.focus == _textField) {
					GUIUtil.stage.focus = null;
					_phase = GPhase.UP;
					callLater(updatePhase);
				}
			}
		}

		public function set text(value : String) : void {
			_text = value;
			callLater(updateText);
		}

		/**
		 * 获得输入文本
		 * 
		 * @return 输入文本
		 */
		public function get text() : String {
			render();
			return _textField.text;
		}

		public function set onEnter(value : Function) : void {
			_onEnter = value;
		}

		public function clear() : void {
			_text = null;
			callLater(updateText);
		}
	}
}
