package gear.gui.controls {
	import gear.gui.model.GChange;
	import gear.gui.core.GBase;
	import gear.gui.model.GChangeList;
	import gear.gui.model.GListModel;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;
	import gear.utils.GMathUtil;

	/**
	 * 选择器控件
	 * 
	 * @author bright
	 * @version 20130121
	 */
	public class GSelector extends GBase {
		protected var _label : GLabel;
		protected var _content : GLabel;
		protected var _prev_btn : GButton;
		protected var _next_btn : GButton;
		protected var _selectedIndex : int;
		protected var _changes : GChangeList;
		protected var _model : GListModel;
		protected var _onChange : Function;

		override protected function preinit() : void {
			_selectedIndex = -1;
			_changes = new GChangeList;
			_model = new GListModel();
			_model.onChange = onModelChange;
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
			if (_model.length < 1) {
				return;
			}
			if (_selectedIndex > 0) {
				_selectedIndex--;
			} else {
				_selectedIndex = _model.length - 1;
			}
			_content.text = _model.getAt(_selectedIndex);
			addRender(updateContent);
		}

		protected function onNextClick() : void {
			if (_model.length < 1) {
				return;
			}
			if (_selectedIndex < _model.length - 1) {
				_selectedIndex++;
			} else {
				_selectedIndex = 0;
			}
			_content.text = _model.getAt(_selectedIndex);
			addRender(updateContent);
		}

		protected function onModelChange(change : GChange) : void {
			_changes.add(change);
			addRender(updateChanges);
		}

		protected function updateChanges() : void {
			var change : GChange;
			while (_changes.hasNext) {
				change = _changes.shift();
				switch(change.state) {
					case GChange.RESET:
						selectedIndex = GMathUtil.clamp(_selectedIndex, 0, _model.length - 1);
						addRender(updateContent);
						break;
					case GChange.ADDED:
						if (_selectedIndex == -1) {
							selectedIndex = 0;
						} else if (change.index <= _selectedIndex) {
							_selectedIndex++;
						}
						break;
					case GChange.REMOVED:
						if (change.index < _selectedIndex) {
							_selectedIndex--;
						} else if (change.index == _selectedIndex) {
							if (_selectedIndex > _model.length - 1) {
								_selectedIndex = _model.length - 1;
							}
							addRender(updateContent);
						}
						break;
					case GChange.UPDATE:
						if (_selectedIndex == change.index) {
							addRender(updateContent);
						}
						break;
				}
			}
		}

		protected function updateLabel() : void {
			_prev_btn.x = _label.width + 3;
		}

		protected function updateContent() : void {
			if (_selectedIndex < 0 || _selectedIndex >= _model.length) {
				_content.clear();
				return;
			}
			_content.text = _model.getAt(_selectedIndex);
			_content.x = _prev_btn.right + ((_next_btn.x - _prev_btn.right - _content.width) >> 1);
			_content.y = (_height - _content.height) >> 1;
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

		public function set model(value : GListModel) : void {
			if (_model == value) {
				return;
			}
			if (_model != null) {
				_model.removeOnChange(onModelChange);
			}
			_model = value;
			_model.onChange = onModelChange;
			selectedIndex = GMathUtil.clamp(_selectedIndex, 0, _model.length - 1);
		}

		public function get model() : GListModel {
			return _model;
		}

		public function set label(value : String) : void {
			_label.text = value;
			addRender(updateLabel);
		}

		public function set selectedIndex(value : int) : void {
			if (_selectedIndex == value) {
				return;
			}
			_selectedIndex = value;
			addRender(updateContent);
		}

		public function get selectedIndex() : int {
			return _selectedIndex;
		}

		public function get selection() : Object {
			return _model.getAt(_selectedIndex);
		}
	}
}
