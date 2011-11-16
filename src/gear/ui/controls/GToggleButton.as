package gear.ui.controls {
	import gear.log4a.LogError;
	import gear.ui.core.PhaseState;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GToggleButtonData;
	import gear.ui.layout.GLayout;

	import flash.events.MouseEvent;

	/**
	 * 双模按钮控件
	 * 
	 * @author bright
	 * @verison 20101015
	 */
	public class GToggleButton extends GToggleBase {
		/**
		 * @private
		 */
		protected var _data : GToggleButtonData;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _phase : int = PhaseState.UP;

		/**
		 * @private
		 */
		override protected function create() : void {
			if (_data.skin == null) {
				throw LogError("GToggleButtonData.skin is null!");
			}
			_data.skin.addTo(this);
			_data.skin.selected = _data.selected;
			_data.skin.phase = PhaseState.UP;
			_label = new GLabel(_data.labelData);
			addChild(_label);
			switch(_data.scaleMode) {
				case ScaleMode.WIDTH_ONLY:
					_height = _data.skin.height;
					break;
				case ScaleMode.NONE:
					_width = _data.skin.width;
					_height = _data.skin.height;
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			if (_data.scaleMode == ScaleMode.NONE) {
				GLayout.layout(_label);
				return;
			}
			_width = Math.max(_width, _label.width + _data.padding * 2);
			_height = Math.max(_height, _label.height + _data.padding * 2);
			_data.skin.setSize(_width, _height);
			GLayout.layout(_label);
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_label.enabled = _enabled;
			viewSkin();
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
			_data.skin.selected = _selected;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function rollOverHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_phase = PhaseState.OVER;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function rollOutHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_phase = PhaseState.UP;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function mouseDownHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_phase = PhaseState.DOWN;
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function mouseUpHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_phase = ((event.currentTarget == this) ? PhaseState.OVER : PhaseState.UP);
			if (_group) {
				if (!_selected) {
					selected = true;
				}
			} else {
				selected = !_selected;
			}
		}

		/**
		 * @private
		 */
		protected function viewSkin() : void {
			if (!_enabled) {
				_label.textColor = _data.textDisabledColor;
			} else if (_phase == PhaseState.UP) {
				_label.textColor = _data.labelData.color.upColor;
			} else if (_phase == PhaseState.OVER) {
				_label.textColor = _data.labelData.color.overColor;
			} else if (_phase == PhaseState.DOWN) {
				_label.textColor = _data.labelData.color.downColor;
			}
			_data.skin.phase = _phase;
		}

		/**
		 * @inheritDoc
		 */
		public function GToggleButton(data : GToggleButtonData) {
			_data = data;
			super(data);
			selected = _data.selected;
		}
	}
}
