package gear.gui.controls {
	import flash.events.TextEvent;
	import gear.gui.core.GAlign;
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	import flash.events.FocusEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;

	/**
	 * 文本输入框控件
	 * 
	 * @author bright
	 * @version 20121205
	 */
	public class GTextInput extends GBase {
		protected var _skin :IGSkin;
		protected var _textAlign : GAlign;
		protected var _phase : int;
		protected var _textField : TextField;

		override protected function preinit() : void {
			_padding.left = _padding.right = 2;
			_textAlign = new GAlign(0, -1, -1, -1, -1, 0);
			setSize(100, 22);
		}

		override protected function create() : void {
			_textField = GUIUtil.getInputTextField();
			addChild(_textField);
		}

		override protected function resize() : void {
			trace("resize",name,_width,_height);
			if (_skin != null) {
				_skin.setSize(_width, _height);
			}
			_textField.width=_width-_padding.left-_padding.right;
			GAlignLayout.layout(_textField, _textAlign);
		}
		
		override protected function onShow() : void {
			if (Capabilities.hasIME) {
				
			}
			addEvent(_textField,FocusEvent.FOCUS_IN,focusInHandler);
			addEvent(_textField,FocusEvent.FOCUS_OUT,focusOutHandler);
			addEvent(_textField,TextEvent.TEXT_INPUT,textInputHandler);
		}
		
		override protected function onEnabled():void{
			if(!_enabled){
				_phase=GPhase.DISABLED;
				addRender(viewSkin);
			}
		}
		
		protected function focusInHandler(event:FocusEvent):void{
			_phase=GPhase.FOCUS;
			addRender(viewSkin);
		}
		
		protected function focusOutHandler(event:FocusEvent):void{
			_phase=_enabled?GPhase.UP:GPhase.DISABLED;
			addRender(viewSkin);
		}
		
		protected function textInputHandler(event:TextEvent):void{
			if(_textField.text.length>100){
				event.preventDefault();
			}
		}

		protected function viewSkin() : void {
			_skin.phase = _phase;
		}

		public function GTextInput() {
		}

		public function set skin(value :IGSkin) : void {
			if (_skin == value) {
				return;
			}
			if (_skin != null) {
				_skin.remove();
			}
			_skin = value;
			_skin.addTo(this);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_skin.width, _skin.height);
			}
			addRender(viewSkin);
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
		 * 获得输入文本
		 * 
		 * @return 输入文本
		 */
		public function get text() : String {
			return _textField.text;
		}
	}
}
