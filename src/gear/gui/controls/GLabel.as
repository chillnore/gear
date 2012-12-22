package gear.gui.controls {
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GAlignMode;
	import gear.gui.core.GAutoSizeMode;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GPhaseColor;
	import gear.gui.utils.GUIUtil;

	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author bright
	 * @version 20121129
	 */
	public class GLabel extends GBase {
		protected var _textAlignIcon : int;
		protected var _hgap : int;
		protected var _vgap : int;
		protected var _textFormat : TextFormat;
		protected var _icon : GIcon;
		protected var _textField : TextField;
		protected var _text : String;
		protected var _phase:int;
		protected var _phaseColor : GPhaseColor;
		protected var _textChanged : Boolean;

		override protected function preinit() : void {
			_autoSize = GAutoSizeMode.AUTO_SIZE;
			_textAlignIcon = GAlignMode.RIGHT_CENTER;
			_hgap = _vgap = 1;
			_phaseColor = new GPhaseColor();
			_phaseColor.setAt(GPhase.UP, 0x111111);
			_phaseColor.setAt(GPhase.DISABLED, 0x666666);
		}

		override protected function create() : void {
			_icon = new GIcon();
			addChild(_icon);
			_textField = GUIUtil.getTextField();
			_textField.textColor = _phaseColor.getBy(GPhase.UP);
			addChild(_textField);
		}

		protected function update() : void {
			if (_textChanged) {
				_textChanged = false;
				_textField.text = _text;
			}
			if (_autoSize == GAutoSizeMode.AUTO_SIZE) {
				var tw : int = _textField.x + _textField.textWidth + 3;
				var th : int = _textField.y + _textField.textHeight+1;
				if (_icon.width == 0) {
					forceSize(tw, th);
				} else {
					_icon.x = 0;
					_icon.y = 0;
					GAlignLayout.layoutTarget(_textField, _icon, _textAlignIcon, _hgap, _vgap);
					if (_textField.x < 0) {
						_icon.x += -_textField.x;
						_textField.x = 0;
					}
					if (_textField.y < 0) {
						_icon.y += -_textField.y;
						_textField.y = 0;
					}
					tw = _textField.x + _textField.textWidth + 3;
					th = _textField.y + _textField.textHeight+1;
					var w : int = Math.max(_icon.x + _icon.width, tw);
					var h : int = Math.max(_icon.y + _icon.height, th);
					forceSize(w, h);
				}
			}
		}

		public function GLabel() {
		}

		override public function get width() : Number {
			render();
			return _width;
		}

		override public function get height() : Number {
			render();
			return _height;
		}

		public function setPhaseColor(phase : int, color : uint) : void {
			_phaseColor.setAt(phase, color);
			_textField.textColor = _phaseColor.getBy(_phase);
		}

		internal function set phase(value : int) : void {
			if(_phase==value){
				return;
			}
			_phase=value;
			_textField.textColor = _phaseColor.getBy(_phase);
		}

		public function set icon(value : BitmapData) : void {
			_icon.bitmapData = value;
			addRender(update);
		}

		public function set text(value : String) : void {
			if (_text == value) {
				return;
			}
			_text = value;
			_textChanged = true;
			addRender(update);
		}
		
		public function set textFieldFilters(value:Array):void{
			_textField.filters=value;
		}
	}
}
