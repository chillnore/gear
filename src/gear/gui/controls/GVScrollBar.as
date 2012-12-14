package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.utils.GMathUtil;

	import flash.display.BitmapData;
	import flash.events.MouseEvent;

	/**
	 * 滚动条控件
	 * 
	 * @author bright
	 * @version 20121209
	 */
	public class GVScrollBar extends GBase {
		protected var _trackSkin : IGSkin;
		protected var _thumbSkin : IGSkin;
		protected var _thumbIcon : BitmapData;
		protected var _arrowUpSkin : IGSkin;
		protected var _arrowDownSkin : IGSkin;
		protected var _thumb_btn : GButton;
		protected var _up_btn : GButton;
		protected var _down_btn : GButton;
		protected var _direction : int;
		protected var _thumbScrollOffset : int;
		protected var _position : int;
		protected var _range : int;
		protected var _min : int;
		protected var _max : int;
		protected var _old : int;
		protected var _value : int;
		protected var _pageSize : int;
		protected var _step : int;
		protected var _repeatDelay : int;

		override protected function preinit() : void {
			_trackSkin = GUIUtil.theme.scrollBarTrackSkin;
			_trackSkin.name = "trackSkin";
			_thumbSkin = GUIUtil.theme.scrollBarThumbSkin;
			_thumbIcon = GUIUtil.theme.scrollBarThumbIcon;
			_arrowUpSkin = GUIUtil.theme.scrollBarArrowUpSkin;
			_arrowDownSkin = GUIUtil.theme.scrollBarArrowDownSkin;
			_scaleMode = GScaleMode.FIT_WIDTH;
			forceSize(15, 100);
			_min = 0;
			_max = 20;
			_pageSize = 10;
			_value = 0;
			_step = 1;
		}

		override protected function create() : void {
			_trackSkin.addTo(this, 0);
			_thumb_btn = new GButton();
			_thumb_btn.skin = _thumbSkin;
			_thumb_btn.icon = _thumbIcon;
			_up_btn = new GButton();
			_up_btn.skin = _arrowUpSkin;
			_up_btn.height = _arrowUpSkin.height;
			_down_btn = new GButton();
			_down_btn.skin = _arrowDownSkin;
			_down_btn.height = _arrowDownSkin.height;
			addChild(_up_btn);
			addChild(_down_btn);
			addChild(_thumb_btn);
		}

		override protected function resize() : void {
			_up_btn.width = _width;
			_down_btn.width = _width;
			_down_btn.y = _height - _down_btn.height;
			_trackSkin.y = _up_btn.height;
			_range = _height - _up_btn.height - _down_btn.height;
			_trackSkin.setSize(_width, _range);
			_thumb_btn.x = 1;
			_thumb_btn.y = _up_btn.height;
			_thumb_btn.width = _trackSkin.width - 2;
			updateThumb();
		}

		override protected function onEnabled() : void {
			_trackSkin.phase = (_enabled ? GPhase.UP : GPhase.DISABLED);
			_up_btn.enabled = _enabled;
			_down_btn.enabled = _enabled;
			_thumb_btn.enabled = _enabled;
			_thumb_btn.visible = _enabled;
		}

		override protected function onShow() : void {
			_up_btn.onClick = onArrowClick;
			_down_btn.onClick = onArrowClick;
			addEvent(this, MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_thumb_btn.addEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
		}

		protected function onArrowClick(target : GButton) : void {
			if (target == _up_btn) {
				value = _value - _step;
			} else if (target == _down_btn) {
				value = _value + _step;
			}
		}

		protected function mouseDownHandler(event : MouseEvent) : void {
			if (mouseY < _thumb_btn.y) {
				value = _value - _pageSize;
			} else if (mouseY > (_thumb_btn.y + _thumb_btn.height)) {
				value = _value + _pageSize;
			}
		}

		protected function thumb_mouseDownHandler(event : MouseEvent) : void {
			mouseChildren = false;
			_thumb_btn.lockPhase = GPhase.DOWN;
			_thumbScrollOffset = mouseY - _thumb_btn.y;
			addEvent(stage, MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			addEvent(stage, MouseEvent.MOUSE_UP, mouseUpHandler);
			addEvent(_thumb_btn, MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		protected function stage_mouseMoveHandler(event : MouseEvent) : void {
			_position = GMathUtil.clamp(mouseY - _thumbScrollOffset, _up_btn.height, _up_btn.height + _range - _thumb_btn.height);
			value = Math.round((_position - _up_btn.height) / (_range - _thumb_btn.height) * (_max - _min)) + _min;
		}

		/**
		 * @private
		 */
		protected function mouseUpHandler(event : MouseEvent) : void {
			mouseChildren = true;
			_thumb_btn.lockPhase = GPhase.NONE;
			removeEvent(stage, MouseEvent.MOUSE_MOVE);
			removeEvent(stage, MouseEvent.MOUSE_UP);
			removeEvent(_thumb_btn, MouseEvent.MOUSE_UP);
		}

		protected function updateThumb() : void {
			_thumb_btn.height = Math.max(12, Math.round(_pageSize / (_max - _min + _pageSize) * _range));
			_thumb_btn.y = _up_btn.height + (_value - _min) / (_max - _min) * (_range - _thumb_btn.height);
		}

		public function GVScrollBar() {
		}

		public function set min(value : int) : void {
			if (_min == value) {
				return;
			}
			_min = value;
		}

		public function set max(value : int) : void {
			if (_max == value) {
				return;
			}
			_max = value;
		}

		public function set value(n : int) : void {
			n = GMathUtil.clamp(n, _min, _max);
			if (_value == n) {
				return;
			}
			_value = n;
			addRender(updateThumb);
		}

		public function set step(value : int) : void {
			if (_step == value) {
				return;
			}
			_step = value;
		}

		public function set pageSize(value : int) : void {
			if (_pageSize == value) {
				return;
			}
			_pageSize = value;
		}
	}
}