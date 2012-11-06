package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GScrollBarData;
	import gear.ui.events.GScrollBarEvent;

	import flash.events.MouseEvent;

	/**
	 * 滚动条控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GScrollBar extends GBase {
		/**
		 * @private
		 */
		protected var _data : GScrollBarData;
		/**
		 * @private
		 */
		protected var _thumb_btn : GButton;
		/**
		 * @private
		 */
		protected var _direction : int;
		/**
		 * @private
		 */
		protected var _pageSize : int = 10;
		/**
		 * @private
		 */
		protected var _min : int = 0;
		/**
		 * @private
		 */
		protected var _max : int = 0;
		/**
		 * @private
		 */
		protected var _value : int = 0;
		/**
		 * @private
		 */
		protected var _old : int = 0;
		/**
		 * @private
		 */
		protected var _thumbScrollOffset : Number;
		/**
		 * @private
		 */
		protected var _fireEvent : Boolean = false;
		protected var _up_btn : GButton;
		protected var _down_btn : GButton;

		/**
		 * @private
		 */
		override protected function create() : void {
			_thumb_btn = new GButton(_data.thumbButtonData);
			_up_btn = new GButton(_data.upButtonData);
			_down_btn = new GButton(_data.downButtonData);
			addChild(_data.trackSkin);
			addChild(_thumb_btn);
			addChild(_up_btn);
			addChild(_down_btn);
			direction = _data.direction;
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_data.trackSkin.y = _up_btn.height + _data.padding - 2;
			_data.trackSkin.width = _width - 1;
			_data.trackSkin.height = _height - _up_btn.height - _down_btn.height - _data.padding * 2 ;
			_thumb_btn.width = _width - 1;
			reset();
		}

		/**
		 * @private
		 */
		protected function reset() : void {
			var per : Number = _max - _min + _pageSize;
			if (_max <= _min) {
				_thumb_btn.height = 12;
				_thumb_btn.visible = false;
			} else {
				_thumb_btn.height = Math.max(12, Math.round(_pageSize / per * _data.trackSkin.height));
				_thumb_btn.y = Math.round((_data.trackSkin.height - _thumb_btn.height) * (_value - _min) / (_max - _min)) + _up_btn.height + _data.padding - 2;
				_thumb_btn.visible = true;
			}
			_up_btn.y = -4;
			_down_btn.y = _height - _down_btn.height;
		}

		/**
		 * @private
		 */
		protected function set direction(value : int) : void {
			_direction = value;
			if (_direction == GScrollBarData.HORIZONTAL) {
				rotation = -90;
				scaleX = -1;
			} else {
				rotation = 0;
				scaleX = 1;
			}
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			_up_btn.addEventListener(MouseEvent.CLICK, upHandler);
			_down_btn.addEventListener(MouseEvent.CLICK, downHandler);
			_thumb_btn.addEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
		}

		private function downHandler(event : MouseEvent) : void {
			resetValue(pageSize, min, max, value + 10);
		}

		private function upHandler(event : MouseEvent) : void {
			resetValue(pageSize, min, max, value - 10);
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			_up_btn.removeEventListener(MouseEvent.CLICK, upHandler);
			_down_btn.removeEventListener(MouseEvent.CLICK, downHandler);
			_thumb_btn.removeEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		/**
		 * @private
		 */
		protected function thumb_mouseDownHandler(event : MouseEvent) : void {
			_thumbScrollOffset = mouseY - _thumb_btn.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			_thumb_btn.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		/**
		 * @private
		 */
		protected function stage_mouseMoveHandler(event : MouseEvent) : void {
			var position : int = Math.max(0, Math.min(_data.trackSkin.height - _thumb_btn.height, mouseY - _thumbScrollOffset - _up_btn.height));
			var newScrollPosition : int = Math.round(position / (_data.trackSkin.height - _thumb_btn.height) * (_max - _min) + _min);
			if (_value != newScrollPosition) {
				var oldScrollPosition : int = _value;
				_value = newScrollPosition;
				reset();
				dispatchEvent(new GScrollBarEvent(_direction, _value - oldScrollPosition, _value));
			}
		}

		/**
		 * @private
		 */
		protected function stage_mouseUpHandler(event : MouseEvent) : void {
			trace("mouse up");
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			_thumb_btn.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		/**
		 * @inheritDoc
		 */
		public function GScrollBar(data : GScrollBarData) {
			_data = data;
			super(data);
		}

		/**
		 * @return 是否激活事件
		 */
		public function set fireEvent(value : Boolean) : void {
			_fireEvent = value;
		}

		/**
		 * @return 页面尺寸
		 */
		public function get pageSize() : int {
			return _pageSize;
		}

		public function get min() : int {
			return _min;
		}

		public function get max() : int {
			return _max;
		}

		public function get value() : int {
			return _value;
		}

		/**
		 * 重置参数
		 * 
		 * @param pageSize 页尺寸
		 * @param min 最小值
		 * @param max 最大值
		 * @param value 当前值
		 */
		public function resetValue(pageSize : int, min : int, max : int, value : int) : void {
			var isUpdate : Boolean = false;
			var isChange : Boolean = false;
			if (_pageSize != pageSize) {
				_pageSize = pageSize;
				isUpdate = true;
			}
			if (_min != min) {
				_min = min;
				isUpdate = true;
			}
			if (_max != max) {
				_max = max;
				isUpdate = true;
			}
			value = Math.max(_min, Math.min(value, _max));
			if (_value != value) {
				_old = _value;
				_value = value;
				isUpdate = true;
				isChange = true;
			}
			if (isUpdate) {
				reset();
			}
			if (isChange) {
				dispatchEvent(new GScrollBarEvent(_direction, _value - _old, _value));
			}
		}

		/**
		 * 获得滚动位置
		 * 
		 * @return 滚动位置
		 */
		public function get scrollPosition() : int {
			return _value;
		}

		/**
		 * 滚动
		 * 
		 * @param delta 滚动值
		 */
		public function scroll(delta : int) : void {
			var newValue : int = Math.max(_min, Math.min(_value - delta * _data.wheelSpeed, _max));
			if (_value == newValue) {
				return;
			}
			_old = _value;
			_value = newValue;
			reset();
			dispatchEvent(new GScrollBarEvent(_direction, _value - _old, _value));
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override public function setSize(width : int, height : int) : void {
			if (_direction == GScrollBarData.HORIZONTAL) {
				super.setSize(height, width);
			} else {
				super.setSize(width, height);
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override public function set width(value : Number) : void {
			if (_direction == GScrollBarData.HORIZONTAL) {
				super.height = value;
			} else {
				super.width = value;
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override public function get width() : Number {
			return (_direction == GScrollBarData.HORIZONTAL) ? _height : _width;
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override public function set height(value : Number) : void {
			if (_direction == GScrollBarData.HORIZONTAL) {
				super.width = value;
			} else {
				super.height = value;
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override public function get height() : Number {
			return (_direction == GScrollBarData.HORIZONTAL) ? _width : _height;
		}
	}
}
