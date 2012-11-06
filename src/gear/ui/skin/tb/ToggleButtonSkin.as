package gear.ui.skin.tb {
	import gear.log4a.GLogError;
	import gear.ui.core.PhaseState;
	import gear.ui.manager.GUIUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 开关按钮皮肤
	 * 
	 * upSkin 正常 必选
	 * overSkin 滑入 可选
	 * downSkin 按下 可选
	 * disabledSkin 禁用 可选
	 * 
	 * selectedUpSkin 选中 必选
	 * selectedOverSkin 选中滑入 可选
	 * selectedDownSkin 选中按下 可选
	 * selectedDisabledSkin 选中禁用 可选
	 * 
	 * @author bright
	 * @version 20120814
	 */
	public final class ToggleButtonSkin implements IToggleButtonSkin {
		private var _upSkin : DisplayObject;
		private var _overSkin : DisplayObject;
		private var _downSkin : DisplayObject;
		private var _disabledSkin : DisplayObject;
		private var _selectedUpSkin : DisplayObject;
		private var _selectedOverSkin : DisplayObject;
		private var _selectedDownSkin : DisplayObject;
		private var _selectedDisabledSkin : DisplayObject;
		private var _current : DisplayObject;
		private var _phase : int;
		private var _selected : Boolean;

		private function update() : void {
			if (_phase == PhaseState.UP) {
				_current = GUIUtil.replace(_current, (_selected ? _selectedUpSkin : _upSkin));
			} else if (_phase == PhaseState.OVER) {
				_current = GUIUtil.replace(_current, (_selected ? _selectedOverSkin : _overSkin));
			} else if (_phase == PhaseState.DOWN) {
				_current = GUIUtil.replace(_current, (_selected ? _selectedDownSkin : _downSkin));
			} else if (_phase == PhaseState.DISABLED) {
				_current = GUIUtil.replace(_current, (_selected ? _selectedDisabledSkin : _disabledSkin));
			}
		}

		public function ToggleButtonSkin(upSkin : DisplayObject, overSkin : DisplayObject, downSkin : DisplayObject, disabledSkin : DisplayObject, selectedUpSkin : DisplayObject, selectedOverSkin : DisplayObject, selectedDownSkin : DisplayObject, selectedDisabledSkin : DisplayObject) {
			_upSkin = upSkin;
			if (_upSkin == null) {
				throw new GLogError("upSkin is null!");
			}
			_overSkin = overSkin;
			_downSkin = downSkin;
			_disabledSkin = disabledSkin;
			_selectedUpSkin = selectedUpSkin;
			_selectedOverSkin = selectedOverSkin;
			_selectedDownSkin = selectedDownSkin;
			_selectedDisabledSkin = selectedDisabledSkin;
		}

		public function set disabledSkin(value : DisplayObject) : void {
			_disabledSkin = value;
		}

		public function setSize(width : int, height : int) : void {
			if (_upSkin != null) {
				_upSkin.width = width;
				_upSkin.height = height;
			}
			if (_overSkin != null) {
				_overSkin.width = width;
				_overSkin.height = height;
			}
			if (_downSkin != null) {
				_downSkin.width = width;
				_downSkin.height = height;
			}
			if (_disabledSkin != null) {
				_disabledSkin.width = width;
				_disabledSkin.height = height;
			}
			if (_selectedUpSkin != null) {
				_selectedUpSkin.width = width;
				_selectedUpSkin.height = height;
			}
			if (_selectedOverSkin != null) {
				_selectedOverSkin.width = width;
				_selectedOverSkin.height = height;
			}
			if (_selectedDownSkin != null) {
				_selectedDownSkin.width = width;
				_selectedDownSkin.height = height;
			}
			if (_selectedDisabledSkin != null) {
				_selectedDisabledSkin.width = width;
				_selectedDisabledSkin.height = height;
			}
		}

		public function addTo(parent : DisplayObjectContainer) : void {
			if (_current == null) {
				_phase = PhaseState.UP;
				_selected = false;
				_current = _upSkin;
			}
			if (_current.parent != parent) {
				parent.addChild(_current);
			}
		}

		public function clone() : IToggleButtonSkin {
			return new ToggleButtonSkin(GUIUtil.cloneSkin(_upSkin), GUIUtil.cloneSkin(_overSkin), GUIUtil.cloneSkin(_downSkin), GUIUtil.cloneSkin(_disabledSkin), GUIUtil.cloneSkin(_selectedUpSkin), GUIUtil.cloneSkin(_selectedOverSkin), GUIUtil.cloneSkin(_selectedDownSkin), GUIUtil.cloneSkin(_selectedDisabledSkin));
		}

		public function get width() : int {
			return _upSkin.width;
		}

		public function get height() : int {
			return _upSkin.height;
		}

		public function set phase(value : int) : void {
			_phase = value;
			update();
		}

		public function set selected(value : Boolean) : void {
			_selected = value;
			update();
		}
	}
}
