package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	/**
	 * 文本框控件
	 * 
	 * @author bright
	 * @version 20130110
	 */
	public class GTextArea extends GBase {
		protected var _borderSkin : IGSkin;
		protected var _textField : TextField;
		protected var _vScrollBar : GVScrollBar;
		protected var _editable : Boolean;
		protected var _maxLines : int;
		protected var _edlim : String;
		protected var _lock : Boolean;

		override protected function preinit() : void {
			editable = true;
			_maxLines = 0;
			_edlim = "</p>";
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
			_textField.width = _width - _padding.left - _padding.right;
			_textField.height = _height - _padding.top - _padding.bottom;
		}

		override protected function onEnabled() : void {
			addRender(updateType);
		}

		override protected function onShow() : void {
			addEvent(_textField, Event.SCROLL, textFieldScrollHandler);
		}

		protected function textFieldScrollHandler(event : Event) : void {
			addRender(updateScroll);
		}

		protected function updateType() : void {
			_textField.type = (_enabled ? (_editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC) : TextFieldType.DYNAMIC);
		}

		protected function updateScroll() : void {
			var needVScroll : Boolean = vScrollMax > 0;
			var newWidth : int = _width - (needVScroll ? _vScrollBar.width : 0);
			_textField.width = newWidth - _padding.left - _padding.right;
			if (needVScroll) {
				_vScrollBar.x = _width - _vScrollBar.width;
				_vScrollBar.setTo(_textField.bottomScrollV - _textField.scrollV + 1, vScrollMax, _textField.scrollV - 1);
				if (!_vScrollBar.visible) {
					_vScrollBar.visible = true;
					_vScrollBar.onValueChange = onValueChange;
				}
			} else if (_vScrollBar.visible) {
				_vScrollBar.visible = false;
				_vScrollBar.onValueChange = null;
			}
		}

		protected function onValueChange() : void {
			_textField.scrollV = _vScrollBar.value + 1;
		}

		protected function get vScrollMax() : int {
			var max : int = _textField.numLines - _textField.bottomScrollV + _textField.scrollV - 1;
			return Math.min(max, _textField.maxScrollV - 1);
		}

		public function GTextArea() {
		}
		
		public function set maxLines(value:int):void{
			if(_maxLines==value){
				return;
			}
			_maxLines=value;
		}

		public function set editable(value : Boolean) : void {
			if (_editable == value) {
				return;
			}
			_editable = value;
			addRender(updateType);
		}

		public function appendHtmlText(value : String) : void {
			_textField.htmlText += value;
			if (_maxLines > 0) {
				var lines : Array = _textField.htmlText.split(_edlim);
				if (lines.length - 1 > _maxLines) {
					_textField.htmlText = _textField.htmlText.slice(String(lines[0]).length + _edlim.length);
				}
			}
			if (!_lock) {
				_textField.scrollV = vScrollMax + 1;
			}
		}
		
		public function clear():void{
			_textField.text="";
		}
	}
}
