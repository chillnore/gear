package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
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
	 * @version 20121205
	 */
	public class GTextInput extends GBase {
		protected var _borderSkin : IGSkin;
		protected var _textField : TextField;
		protected var _label : GLabel;
		protected var _phase : int;
		protected var _text : String;
		protected var _onEnter : Function;

		override protected function preinit() : void {
			_padding.left = _padding.right = 2;
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
			addEvent(_textField, FocusEvent.FOCUS_IN, focusInHandler);
			addEvent(_textField, FocusEvent.FOCUS_OUT, focusOutHandler);
			addEvent(_textField, TextEvent.TEXT_INPUT, textInputHandler);
			addEvent(this, KeyboardEvent.KEY_UP, keyUpHandler);
		}

		override protected function onEnabled() : void {
			if (!_enabled) {
				_phase = GPhase.DISABLED;
				addRender(updatePhase);
			}
		}

		protected function updateLabel() : void {
			_borderSkin.moveTo(_label.width < 1 ? 0 : _label.width + 3, 0);
			_borderSkin.setSize(_width - _borderSkin.x, _height);
			_textField.x = _borderSkin.x + _padding.left;
			_textField.width = _width - _borderSkin.x - _padding.left - _padding.right;
		}

		protected function updateText() : void {
			_textField.text = _text;
		}

		protected function focusInHandler(event : FocusEvent) : void {
			_phase = GPhase.FOCUS;
			addRender(updatePhase);
		}

		protected function focusOutHandler(event : FocusEvent) : void {
			_phase = _enabled ? GPhase.UP : GPhase.DISABLED;
			addRender(updatePhase);
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
			addRender(updatePhase);
		}

		public function set label(value : String) : void {
			_label.text = value;
			addRender(updateLabel);
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
					_phase=GPhase.FOCUS;
					addRender(updatePhase);
				}
			} else {
				if (GUIUtil.root.stage.focus == _textField) {
					GUIUtil.root.stage.focus = null;
					_phase=GPhase.UP;
					addRender(updatePhase);
				}
			}
		}

		public function set text(value : String) : void {
			_text = value;
			addRender(updateText);
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
		
		public function clear():void{
			_text="";
			addRender(updateText);
		}
	}
}
