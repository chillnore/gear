package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;
	import gear.utils.GMathUtil;

	import flash.display.BitmapData;
	import flash.events.MouseEvent;

	/**
	 * 滚动条控件
	 * 
	 * @author bright
	 * @version 20130118
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
		protected var _track_btn : GButton;
		protected var _direction : int;
		protected var _thumbScrollOffset : int;
		protected var _position : int;
		protected var _pageSize : int;
		protected var _min : int;
		protected var _max : int;
		protected var _value : int;
		protected var _step : int;
		protected var _repeatDelay : int;
		protected var _onValueChange : Function;

		override protected function preinit() : void {
			_trackSkin = GUIUtil.theme.vScrollBarTrackSkin;
			_thumbSkin = GUIUtil.theme.vScrollBarThumbSkin;
			_thumbIcon = GUIUtil.theme.vScrollBarThumbIcon;
			_arrowUpSkin = GUIUtil.theme.vScrollBarArrowUpSkin;
			_arrowDownSkin = GUIUtil.theme.vScrollBarArrowDownSkin;
			_scaleMode = GScaleMode.FIT_WIDTH;
			_min = 0;
			_max = 20;
			_pageSize = 10;
			_value = 0;
			_step = 1;
			forceSize(15, 100);
		}

		override protected function create() : void {
			_track_btn = new GButton();
			_track_btn.skin = _trackSkin;
			addChild(_track_btn);
			_thumb_btn = new GButton();
			_thumb_btn.skin = _thumbSkin;
			_thumb_btn.icon = _thumbIcon;
			addChild(_thumb_btn);
			_up_btn = new GButton();
			_up_btn.skin = _arrowUpSkin;
			_up_btn.height = _arrowUpSkin.height;
			addChild(_up_btn);
			_down_btn = new GButton();
			_down_btn.skin = _arrowDownSkin;
			_down_btn.height = _arrowDownSkin.height;
			addChild(_down_btn);
		}

		override protected function resize() : void {
			_up_btn.width = _width;
			_down_btn.width = _width;
			_down_btn.y = _height - _down_btn.height;
			_track_btn.y = _up_btn.height;
			_track_btn.setSize(_width, _height - _up_btn.height - _down_btn.height);
			_thumb_btn.x = 1;
			_thumb_btn.y = _up_btn.height;
			_thumb_btn.width = _track_btn.width - 2;
			addRender(updateThumb);
		}

		override protected function onEnabled() : void {
			_track_btn.enabled = _enabled;
			_thumb_btn.enabled = _enabled;
			_thumb_btn.visible = _enabled;
			_up_btn.enabled = _enabled;
			_down_btn.enabled = _enabled;
		}

		override protected function onShow() : void {
			_up_btn.onClick = onArrowClick;
			_down_btn.onClick = onArrowClick;
			addEvent(_track_btn, MouseEvent.MOUSE_DOWN, track_mouseDownHandler);
			_thumb_btn.addEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
		}

		protected function onArrowClick(target : GButton) : void {
			if (target == _up_btn) {
				value = _value - _step;
			} else if (target == _down_btn) {
				value = _value + _step;
			}
		}

		protected function track_mouseDownHandler(event : MouseEvent) : void {
			if (mouseY < _thumb_btn.y) {
				value = _value - _pageSize;
			} else if (mouseY > _thumb_btn.bottom) {
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
			_position = GMathUtil.clamp(mouseY - _thumbScrollOffset, _up_btn.height, _up_btn.height + _track_btn.height - _thumb_btn.height);
			value = (_position - _up_btn.height) / (_track_btn.height - _thumb_btn.height) * (_max - _min) + _min;
		}

		protected function mouseUpHandler(event : MouseEvent) : void {
			mouseChildren = true;
			_thumb_btn.lockPhase = GPhase.NONE;
			removeEvent(stage, MouseEvent.MOUSE_MOVE);
			removeEvent(stage, MouseEvent.MOUSE_UP);
			removeEvent(_thumb_btn, MouseEvent.MOUSE_UP);
		}

		protected function updateThumb() : void {
			var range : int = _max - _min;
			_thumb_btn.height = Math.max(12, _pageSize / ( range + _pageSize) * _track_btn.height);
			_thumb_btn.y = _up_btn.height + (_value - _min) / range * (_track_btn.height - _thumb_btn.height);
		}

		public function GVScrollBar() {
		}

		public function set onValueChange(value : Function) : void {
			_onValueChange = value;
		}

		public function setTo(newPageSize : int, newMax : int, newValue : int, newMin : int = 0) : void {
			var isUpdate : Boolean = false;
			if (_pageSize != newPageSize) {
				_pageSize = newPageSize;
				isUpdate = true;
			}
			if (_max != newMax) {
				_max = newMax;
				isUpdate = true;
			}
			if (_min != newMin) {
				_min = newMin;
				isUpdate = true;
			}
			newValue = GMathUtil.clamp(newValue, _min, _max);
			if (_value != newValue) {
				value = newValue;
				isUpdate = true;
			}
			if (isUpdate) {
				addRender(updateThumb);
			}
		}

		public function set value(newValue : int) : void {
			newValue = GMathUtil.clamp(newValue, _min, _max);
			if (_value == newValue) {
				return;
			}
			_value = newValue;
			if (_onValueChange != null) {
				try {
					_onValueChange();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
			addRender(updateThumb);
		}

		public function get value() : int {
			return _value;
		}
	}
}