package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.core.PhaseState;
	import gear.ui.data.GButtonData;
	import gear.ui.layout.GLayout;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * 按钮控件
	 * 
	 * @author bright
	 * @version 20111120
	 */
	public class GButton extends GBase {
		/**
		 * @private
		 */
		protected var _data : GButtonData;
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
		protected var _phase : int ;

		/**
		 * @private
		 */
		override protected function create() : void {
			_data.skin.addTo(this);
			_phase = PhaseState.UP;
			_data.skin.phase = _phase;
			_label = new  GLabel(_data.labelData);
			addChild(_label);
			switch(_data.scaleMode) {
				case GScaleMode.WIDTH_ONLY:
					_height = _data.skin.height;
					break;
				case GScaleMode.NONE:
					if (_data.skin != null) {
						_width = _data.skin.width;
						_height = _data.skin.height;
					}
					break;
				default:
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			if (_data.scaleMode == GScaleMode.NONE) {
				GLayout.layout(_label);
				return;
			}
			_data.skin.setSize(_width, _height);
			GLayout.layout(_label);
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_label.enabled = _enabled;
			_phase = (_enabled ? PhaseState.UP : PhaseState.DISABLED);
			viewSkin();
		}

		/**
		 * @private
		 */
		override protected  function onShow() : void {
			super.onShow();
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			super.onHide();
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			var reset : int = (_enabled ? PhaseState.UP : PhaseState.DISABLED);
			if (_phase != reset) {
				_phase = reset;
				viewSkin();
			}
		}

		/**
		 * @private
		 */
		protected function rollOverHandler(event : MouseEvent) : void {
			event.stopPropagation();
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
			event.stopPropagation();
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
			event.stopPropagation();
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
			event.stopPropagation();
			if (!_enabled) {
				return;
			}
			_phase = ((event.currentTarget == this) ? PhaseState.OVER : PhaseState.UP);
			viewSkin();
		}

		/**
		 * @private
		 */
		protected function viewSkin() : void {
			if (!_enabled) {
				_label.textColor = _data.labelData.color.disabledColor;
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
		 * @private
		 */
		public function GButton(data : GButtonData = null) {
			if (data == null) {
				data = new GButtonData();
			}
			_data = data;
			super(_data);
		}

		/**
		 * 设置文本
		 * 
		 * @param value 文本
		 */
		public function set text(value : String) : void {
			_label.text = value;
			GLayout.layout(_label);
		}

		/**
		 * 获得标签控件
		 * 
		 * @return 标签控件
		 */
		public function get label() : GLabel {
			return _label;
		}

		/**
		 * 设置图标
		 * 
		 * @param value 位图
		 */
		public function set icon(value : BitmapData) : void {
			_label.icon.bitmapData = value;
			GLayout.layout(_label);
		}

		/**
		 * 设置图标灰度
		 * 
		 * @param value 是否为灰度
		 */
		public function set iconGray(value : Boolean) : void {
			_label.icon.gray = value;
		}
	}
}
