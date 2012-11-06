package gear.ui.controls {
	import gear.ui.core.PhaseState;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GTabData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.UIManager;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * Tab控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GTab extends GToggleBase {
		/**
		 * @private
		 */
		protected var _data : GTabData;
		/**
		 * @private
		 */
		protected var _upSkin : Sprite;
		/**
		 * @private
		 */
		protected var _overSkin : Sprite;
		/**
		 * @private
		 */
		protected var _disabledSkin : Sprite;
		/**
		 * @private
		 */
		protected var _selectedUpSkin : Sprite;
		/**
		 * @private
		 */
		protected var _selectedDisabledSkin : Sprite;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _current : Sprite;
		/**
		 * @private
		 */
		protected var _phase : int = PhaseState.UP;
		/**
		 * @private
		 */
		protected var _rollOver : Boolean = false;

		/**
		 * @private
		 */
		override protected function create() : void {
			_upSkin = UIManager.getSkin(_data.upAsset);
			_overSkin = UIManager.getSkin(_data.overAsset);
			_disabledSkin = UIManager.getSkin(_data.disabledAsset);
			_selectedUpSkin = UIManager.getSkin(_data.selectedUpAsset);
			_selectedDisabledSkin = UIManager.getSkin(_data.selectedDisabledAsset);
			_label = new  GLabel(_data.labelData);
			_current = _upSkin;
			addChild(_upSkin);
			addChild(_label);
			switch(_data.scaleMode) {
				case ScaleMode.WIDTH_ONLY:
					_height = _upSkin.height;
					break;
				case ScaleMode.NONE:
					_width = _upSkin.width;
					_height = _upSkin.height;
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			GLayout.layout(_label);
			_upSkin.width = _width;
			_upSkin.height = _height;
			if (_overSkin) {
				_overSkin.width = _width;
				_overSkin.height = _height;
			}
			if (_disabledSkin) {
				_disabledSkin.width = _width;
				_disabledSkin.height = _height;
			}
			if (_selectedUpSkin) {
				_selectedUpSkin.width = _width;
				_selectedUpSkin.height = _height;
			}
			if (_selectedDisabledSkin) {
				_selectedDisabledSkin.width = _width;
				_selectedDisabledSkin.height = _height;
			}
		}

		/**
		 * @private
		 */
		override protected  function onShow() : void {
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		/**
		 * @private
		 */
		override protected function onSelect() : void {
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function rollOverHandler(event : MouseEvent) : void {
			if (!_enabled)
				return;
			_rollOver = true;
			_phase = PhaseState.OVER;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function rollOutHandler(event : MouseEvent) : void {
			if (!_enabled)
				return;
			_rollOver = false;
			_phase = PhaseState.UP;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function mouseDownHandler(event : MouseEvent) : void {
			if (!_enabled)
				return;
			_phase = PhaseState.DOWN;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function mouseUpHandler(event : MouseEvent) : void {
			if (!_enabled)
				return;
			_phase = PhaseState.UP;
			if (_group) {
				if (!_selected)
					selected = true;
			} else {
				selected = !_selected;
			}
		}

		/**
		 * @private
		 */
		protected function viewSkin() : void {
			if (!_enabled) {
				if (selected) {
					if (_selectedDisabledSkin)
						_current = replace(_current, _selectedDisabledSkin);
				} else {
					_current = replace(_current, _disabledSkin);
				}
			} else if (_phase == PhaseState.UP) {
				if (_selected) {
					if (_selectedUpSkin)
						_current = replace(_current, _selectedUpSkin);
					_label.textColor = _data.labelData.color.selectedColor;
				} else {
					_current = replace(_current, _upSkin);
					_label.textColor = _data.labelData.color.upColor;
				}
			} else if (_phase == PhaseState.OVER) {
				if (_selected) {
				} else {
					if (_overSkin)
						_current = replace(_current, _overSkin);
				}
				_label.textColor = _data.labelData.color.overColor;
			} else if (_phase == PhaseState.DOWN) {
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GTab(data : GTabData) {
			_data = data;
			super(_data);
			selected = _data.selected;
		}

		/**
		 * 设置显示文本
		 * 
		 * @param value 显示文本
		 */
		public function set text(value : String) : void {
			_label.text = value;
			if (_data.scaleMode == ScaleMode.AUTO_WIDTH) {
				_width = _label.width + _data.padding * 2;
			} else {
				GLayout.layout(_label);
			}
		}
	}
}
