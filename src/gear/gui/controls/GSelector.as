package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.model.GListModel;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;
	import gear.utils.GMathUtil;

	/**
	 * 选择器控件
	 * 
	 * @author bright
	 * @version 20130110
	 */
	public class GSelector extends GBase{
		protected var _label : GLabel;
		protected var _content : GLabel;
		protected var _prev_btn : GButton;
		protected var _next_btn : GButton;
		protected var _selectedIndex : int;
		protected var _model : GListModel;
		protected var _onChange : Function;

		override protected function preinit() : void {
			_selectedIndex = -1;
			_model = new GListModel();
			_model.onReset = onModelReset;
			setSize(160, 22);
		}

		override protected function create() : void {
			_label = new GLabel();
			addChild(_label);
			_content = new GLabel();
			addChild(_content);
			_prev_btn = new GButton();
			_prev_btn.icon = GUIUtil.theme.leftArrowIcon;
			_prev_btn.setSize(17, 17);
			addChild(_prev_btn);
			_next_btn = new GButton();
			_next_btn.icon = GUIUtil.theme.rightArrowIcon;
			_next_btn.setSize(17, 17);
			addChild(_next_btn);
			_prev_btn.onClick = onPrevClick;
			_next_btn.onClick = onNextClick;
		}

		override protected function resize() : void {
			_label.y = (_height - _label.height) >> 1;
			_content.y = (_height - _content.height) >> 1;
			_prev_btn.y = (_height - _prev_btn.height) >> 1;
			_next_btn.x = _width - _next_btn.width;
			_next_btn.y = (_height - _next_btn.height) >> 1;
		}

		protected function onPrevClick() : void {
			if (_selectedIndex > 0) {
				_selectedIndex--;
			} else {
				_selectedIndex = _model.length - 1;
			}
			_content.text = String(_model.getAt(_selectedIndex));
			addRender(updateContent);
		}

		protected function onNextClick() : void {
			if (_selectedIndex < _model.length - 1) {
				_selectedIndex++;
			} else {
				_selectedIndex = 0;
			}
			_content.text = String(_model.getAt(_selectedIndex));
			addRender(updateContent);
		}

		protected function onModelReset() : void {
			_selectedIndex = GMathUtil.clamp(_selectedIndex, 0, _model.length - 1);
			_content.text = String(_model.getAt(_selectedIndex));
			addRender(updateContent);
		}

		protected function updateLabel() : void {
			_prev_btn.x = _label.width + 3;
		}

		protected function updateContent() : void {
			_content.x = _prev_btn.right + ((_next_btn.x - _prev_btn.right - _content.width) >> 1);
			if (_onChange != null) {
				try {
					_onChange();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GSelector() {
		}

		public function set onChange(value : Function) : void {
			_onChange = value;
		}

		public function get model() : GListModel {
			return _model;
		}

		public function set label(value : String) : void {
			_label.text = value;
			addRender(updateLabel);
		}

		public function get selection() : Object {
			return _model.getAt(_selectedIndex);
		}
	}
}
