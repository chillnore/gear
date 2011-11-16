package gear.motion {
	/**
	 * @author bright
	 * @version 20101019
	 */
	public class GOffsetTween extends AGTween {
		private var _property : String;
		private var _from : Number;
		private var _to : Number;
		private var _begin : Number;
		private var _end : Number;
		private var _change : Number;

		public function GOffsetTween(property : String, from : Number, to : Number, duration : int, ease : Function, start : int) {
			super(duration, ease, start);
			_property = property;
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
				_begin = _target[_property] + _from;
				_end = _target[_property] + _to;
				_change = _end - _begin;
			} else if (_time < (_start + _duration)) {
				_target[_property] = _ease(_time - _start, _begin, _change, _duration);
			} else {
				_target[_property] = _end;
			}
			return true;
		}
	}
}
