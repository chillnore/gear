package gear.motion {
	/**
	 * 属性缓动
	 * 
	 * @author bright
	 * @version 20101019
	 */
	public class GPropTween extends AGTween {
		public static const X : String = "x";
		public static const Y : String = "y";
		public static const WIDTH : String = "width";
		public static const HEIGHT : String = "height";
		public static const ALPHA : String = "alpha";
		private var _property : String;
		private var _begin : Number;
		private var _end : Number;
		private var _change : Number;

		public function GPropTween(property : String, begin : Number, end : Number, duration : int = 0, ease : Function = null, start : int = 0) {
			super(duration, ease, start);
			_property = property;
			_begin = begin;
			_end = end;
			reset();
		}

		public function change(begin : Number, end : Number, duration : int) : void {
			_begin = begin;
			_end = end;
			_duration = duration;
			reset();
		}

		override public function next() : Boolean {
			if (_time > (_start + _duration)) {
				return false;
			}
			_time++;
			if (_time < _start) {
			} else if (_time == _start) {
				_position = _begin;
			} else if (_time < (_start + _duration)) {
				_position = _ease(_time - _start, _begin, _change, _duration);
			} else {
				_position = _end;
			}
			if (_target != null) {
				_target[_property] = _position;
			}
			return true;
		}

		override public function reset() : void {
			_change = _end - _begin;
			_position = _begin;
			_time = 0;
		}
	}
}
