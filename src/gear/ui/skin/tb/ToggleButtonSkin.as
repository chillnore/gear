package gear.ui.skin.tb {
	import gear.log4a.LogError;
	import gear.ui.core.PhaseState;
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 模组按钮皮肤
	 * 
	 * @author bright
	 * @version 20110222
	 */
	public class ToggleButtonSkin implements IToggleButtonSkin {
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
				_current = UIManager.replace(_current, (_selected ? _selectedUpSkin : _upSkin));
			} else if (_phase == PhaseState.OVER) {
				_current = UIManager.replace(_current, (_selected ? _selectedOverSkin : _overSkin));
			} else if (_phase == PhaseState.DOWN) {
				_current = UIManager.replace(_current, (_selected ? _selectedDownSkin : _downSkin));
			} else if (_phase == PhaseState.DISABLED) {
				_current = UIManager.replace(_current, (_selected ? _selectedDisabledSkin : _disabledSkin));
			}
		}

		public function ToggleButtonSkin(upSkin : DisplayObject, overSkin : DisplayObject, downSkin : DisplayObject, disabledSkin : DisplayObject, selectedUpSkin : DisplayObject, selectedOverSkin : DisplayObject, selectedDownSkin : DisplayObject, selectedDisabledSkin : DisplayObject) {
			_upSkin = upSkin;
			if (_upSkin == null) {
				throw new LogError("upSkin is null!");
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
			return new ToggleButtonSkin(UIManager.cloneSkin(_upSkin), UIManager.cloneSkin(_overSkin), UIManager.cloneSkin(_downSkin), UIManager.cloneSkin(_disabledSkin), UIManager.cloneSkin(_selectedUpSkin), UIManager.cloneSkin(_selectedOverSkin), UIManager.cloneSkin(_selectedDownSkin), UIManager.cloneSkin(_selectedDisabledSkin));
		}

		public function get width() : int {
			return 0;
		}

		public function get height() : int {
			return 0;
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
