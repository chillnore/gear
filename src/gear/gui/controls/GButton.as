package gear.gui.controls {
	import gear.gui.core.GBase;
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
	 * @example
	 * @author bright
	 * @version 20120814
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
		protected var _phaseChange : Boolean;

		/**
		 * @private
		 */
		override protected function create() : void {
			_data.skin.addTo(this);
			_phase = PhaseState.UP;
			_phaseChange = true;
			_label = new GLabel(_data.labelData);
			addChild(_label);
			if (_data.scaleMode == GScaleMode.NONE) {
				
			} else {
				_width = _data.width;
				_height = _data.height;
			}
			trace(_width, _height);
			addRender(layout);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			trace("layout");
			_data.skin.setSize(_width, _height);
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_label.enabled = _enabled;
			phase = (_enabled ? PhaseState.UP : PhaseState.DISABLED);
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
				phase = reset;
			}
		}

		/**
		 * @private
		 */
		protected function rollOverHandler(event : MouseEvent) : void {
			event.stopPropagation();
			if (_enabled) {
				phase = PhaseState.OVER;
			}
		}

		/**
		 * @private
		 */
		protected function rollOutHandler(event : MouseEvent) : void {
			event.stopPropagation();
			if (_enabled) {
				phase = PhaseState.UP;
			}
		}

		/**
		 * @private
		 */
		protected function mouseDownHandler(event : MouseEvent) : void {
			event.stopPropagation();
			if (_enabled) {
				phase = PhaseState.DOWN;
			}
		}

		/**
		 * @private
		 */
		protected function mouseUpHandler(event : MouseEvent) : void {
			event.stopPropagation();
			if (!_enabled) {
				return;
			}
			phase = ((event.currentTarget == this) ? PhaseState.OVER : PhaseState.UP);
		}

		/**
		 * @private
		 */
		protected function viewSkin() : void {
			if (_phaseChange) {
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
				_phaseChange = false;
			}
		}

		protected function layoutLabel() : void {
			_label.render();
			GLayout.layout(_label);
		}

		protected function set phase(value : int) : void {
			if (_phase == value) {
				return;
			}
			_phase = value;
			addRender(viewSkin);
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
			addRender(layoutLabel);
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
			addRender(layoutLabel);
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
