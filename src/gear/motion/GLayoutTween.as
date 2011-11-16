package gear.motion {
	import gear.ui.core.GAlign;
	import gear.ui.core.GBase;
	import gear.ui.layout.GLayout;

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;


	/**
	 * 布局缓动
	 * 
	 * @author bright
	 * @verison 20101019
	 */
	public class GLayoutTween extends AGTween {
		private var _from : GAlign;
		private var _to : GAlign;
		private var _begin_rect : Rectangle;
		private var _end_rect : Rectangle;

		private function getRect(align : GAlign) : Rectangle {
			var target : DisplayObject = _target as DisplayObject;
			if (target == null) {
				return null;
			}
			if (align == null) {
				if (target is GBase && GBase(_target).align != null) {
					return GLayout.getRect(target, GBase(_target).align);
				} else {
					return new Rectangle(target.x, target.y, target.width, target.height);
				}
			} else {
				return GLayout.getRect(target, align);
			}
		}

		public function GLayoutTween(from : GAlign, to : GAlign, duration : int, ease : Function = null, start : int = 0) {
			super(duration, ease, start);
			_from = from;
			_to = to;
		}

		override public function next() : Boolean {
			if (_time > (_start + _duration)) {
				return false;
			}
			_time++;
			if (_time < _start) {
			} else if (_time == _start) {
				_target.x = _begin_rect.x;
				_target.y = _begin_rect.y;
				_target.width = _begin_rect.width;
				_target.height = _begin_rect.height;
			} else if (_time < (_start + _duration)) {
				if (_target.x != _end_rect.x) {
					_target.x = int(_ease(_time - _start, _begin_rect.x, _end_rect.x - _begin_rect.x, _duration));
				}
				if (_target.y != _end_rect.y) {
					_target.y = int(_ease(_time - _start, _begin_rect.y, _end_rect.y - _begin_rect.y, _duration));
				}
				if (_target.width != _end_rect.width) {
					_target.width = int(_ease(_time - _start, _begin_rect.width, _end_rect.width - _begin_rect.width, _duration));
				}
				if (_target.height != _end_rect.height) {
					_target.height = int(_ease(_time - _start, _begin_rect.height, _end_rect.height - _begin_rect.height, _duration));
				}
			} else {
				_target.x = _end_rect.x;
				_target.y = _end_rect.y;
				_target.width = _end_rect.width;
				_target.height = _end_rect.height;
			}
			return true;
		}

		override public function reset() : void {
			if (_target == null) {
				return;
			}
			_begin_rect = getRect(_from);
			_end_rect = getRect(_to);
			_time = 0;
		}
	}
}
