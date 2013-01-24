package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	/**
	 * 文本框控件
	 * 
	 * @author bright
	 * @version 20130118
	 */
	public class GTextArea extends GBase {
		protected var _borderSkin : IGSkin;
		protected var _textField : TextField;
		protected var _vScrollBar : GVScrollBar;
		protected var _phase : int;
		protected var _editable : Boolean;
		protected var _maxLines : int;
		protected var _edlim : String;
		protected var _lock : Boolean;
		protected var _appender : String;

		override protected function preinit() : void {
			editable = true;
			_maxLines = 0;
			_edlim = "</p>";
			_appender = "";
			setSize(100, 100);
		}

		override protected function create() : void {
			_borderSkin = GUIUtil.theme.textAreaBorderSkin;
			_borderSkin.addTo(this, 0);
			_textField = GUIUtil.getInputTextField();
			_textField.multiline = true;
			_textField.wordWrap = true;
			addChild(_textField);
			_vScrollBar = new GVScrollBar();
			_vScrollBar.visible = false;
			addChild(_vScrollBar);
		}

		override protected function resize() : void {
			_borderSkin.setSize(_width, _height);
			_textField.width = _width - (_vScrollBar.visible ? _vScrollBar.width : 0) - _padding.left - _padding.right;
			_textField.height = _height - _padding.top - _padding.bottom;
			_vScrollBar.x = _width - _vScrollBar.width;
			_vScrollBar.height = _height;
			addRender(updateScroll);
		}

		override protected function onEnabled() : void {
			addRender(updateType);
		}

		override protected function onShow() : void {
			addEvent(_textField, FocusEvent.FOCUS_IN, focusHandler);
			addEvent(_textField, FocusEvent.FOCUS_OUT, focusHandler);
			addEvent(_textField, Event.SCROLL, textFieldScrollHandler);
		}

		protected function focusHandler(event : FocusEvent) : void {
			if (event.type == FocusEvent.FOCUS_IN) {
				_phase = GPhase.FOCUS;
			} else if (event.type == FocusEvent.FOCUS_OUT) {
				_phase = _enabled ? GPhase.UP : GPhase.DISABLED;
			}
			addRender(updatePhase);
		}

		protected function updatePhase() : void {
			_borderSkin.phase = _phase;
		}

		protected function textFieldScrollHandler(event : Event) : void {
			addRender(updateScroll);
		}

		protected function updateType() : void {
			_textField.type = (_enabled ? (_editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC) : TextFieldType.DYNAMIC);
		}

		protected function updateHtmlText() : void {
			_textField.htmlText += _appender;
			_appender = "";
			if (_maxLines > 0) {
				var lines : Array = _textField.htmlText.split(_edlim);
				if (lines.length - 1 > _maxLines) {
					_textField.htmlText = _textField.htmlText.slice(String(lines[0]).length + _edlim.length);
				}
			}
			addRender(updateScroll);
		}

		protected function updateScroll() : void {
			if (_textField.maxScrollV > 1) {
				var pageSize : int = _textField.numLines - _textField.maxScrollV + 1;
				_vScrollBar.setTo(pageSize, _textField.maxScrollV, _textField.scrollV, 1);
				if (!_vScrollBar.visible) {
					_textField.width = _width - _vScrollBar.width - _padding.left - _padding.right;
					_vScrollBar.onValueChange = onValueChange;
					_vScrollBar.visible = true;
				}
			} else if (_vScrollBar.visible) {
				_vScrollBar.visible = false;
				_vScrollBar.onValueChange = null;
				_textField.width = _width - _padding.left - _padding.right;
			}
		}

		protected function onValueChange() : void {
			_textField.scrollV = _vScrollBar.value;
		}

		public function GTextArea() {
		}

		public function set styleSheet(value : StyleSheet) : void {
			_textField.styleSheet = value;
		}

		public function set maxLines(value : int) : void {
			if (_maxLines == value) {
				return;
			}
			_maxLines = value;
		}

		public function set editable(value : Boolean) : void {
			if (_editable == value) {
				return;
			}
			_editable = value;
			addRender(updateType);
		}

		public function appendHtmlText(value : String) : void {
			_appender += value;
			addRender(updateHtmlText);
		}

		public function clear() : void {
			_textField.text = "";
		}
	}
}
