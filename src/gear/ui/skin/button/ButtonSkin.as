package gear.ui.skin.button {
	import gear.ui.core.PhaseState;
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 按钮皮肤
	 * 
	 * @author bright
	 * @version 20111125
	 */
	public class ButtonSkin implements IButtonSkin {
		protected var _upSkin : DisplayObject;
		protected var _overSkin : DisplayObject;
		protected var _downSkin : DisplayObject;
		protected var _disabledSkin : DisplayObject;
		protected var _current : DisplayObject;

		public function ButtonSkin(upSkin : DisplayObject, overSkin : DisplayObject = null, downSkin : DisplayObject = null, disabledSkin : DisplayObject = null) {
			_upSkin = upSkin;
			_overSkin = overSkin;
			_downSkin = downSkin;
			_disabledSkin = disabledSkin;
		}

		public function addTo(parent : DisplayObjectContainer) : void {
			if (_current == null) {
				_current = _upSkin;
			}
			if (_current.parent != parent) {
				parent.addChild(_current);
			}
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
		}

		public function get width() : int {
			return _upSkin.width;
		}

		public function get height() : int {
			return _upSkin.height;
		}

		public function set phase(value : int) : void {
			if (value == PhaseState.UP) {
				_current = UIManager.replace(_current, _upSkin);
			} else if (value == PhaseState.OVER) {
				_current = UIManager.replace(_current, _overSkin);
			} else if (value == PhaseState.DOWN) {
				_current = UIManager.replace(_current, _downSkin);
			} else if (value == PhaseState.DISABLED) {
				_current = UIManager.replace(_current, _disabledSkin);
			}
		}

		public function clone() : IButtonSkin {
			return new ButtonSkin(UIManager.cloneSkin(_upSkin), UIManager.cloneSkin(_overSkin), UIManager.cloneSkin(_downSkin), UIManager.cloneSkin(_disabledSkin));
		}
	}
}