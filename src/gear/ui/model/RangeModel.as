package gear.ui.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * RangeModel 范围模型
	 * 
	 * @author bright
	 * @version 20101009
	 */
	public class RangeModel extends EventDispatcher {
		protected var _key : Object;
		protected var _min : Number;
		protected var _max : Number;
		protected var _value : Number;
		protected var _oldValue : Number;
		protected var _percent : Number;
		protected var _oldPercent : Number;
		protected var _zeroPercent : Number;
		protected var _fireEvent : Boolean;

		protected function reset() : void {
			_oldPercent = _percent;
			_percent = (_value - _min) / (_max - _min);
			_zeroPercent = (0 - _min) / (_max - _min);
			if (_fireEvent) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		/**
		 * RangeModel 构造函数
		 * 
		 * @param min Number 最小值 @default 0
		 * @param max Number 最大值 @default 100
		 * @param value Number 当前值 @defalut 0
		 */
		public function RangeModel(min : Number = 0, max : Number = 100, value : Number = 0) {
			_min = min;
			_max = max;
			_value = value;
			_oldValue = _value;
			_percent = (_value - _min) / (_max - _min);
			_oldPercent = _percent;
			_zeroPercent = (0 - _min) / (_max - _min);
			_fireEvent = true;
		}

		public function resetRange(value : Number, min : Number, max : Number) : void {
			_value = value;
			_min = min;
			_max = max;
			reset();
		}

		public function set key(o : Object) : void {
			_key = o;
		}

		public function get key() : Object {
			return _key;
		}

		public function set min(n : Number) : void {
			if (_min == n) {
				return;
			}
			_min = n;
			reset();
		}

		public function get min() : Number {
			return _min;
		}

		public function set max(n : Number) : void {
			if (_max == n) {
				return;
			}
			_max = n;
			reset();
		}

		public function get max() : Number {
			return _max;
		}

		public function set value(n : Number) : void {
			n = Math.max(_min, Math.min(_max, n));
			if (_value == n) {
				return;
			}
			_oldValue = _value;
			_value = n;
			reset();
		}

		public function get value() : Number {
			return _value;
		}

		public function get oldValue() : Number {
			return _oldValue;
		}

		public function get percent() : Number {
			return _percent;
		}

		public function get oldPercent() : Number {
			return _oldPercent;
		}

		public function get zeroPercenr() : Number {
			return _zeroPercent;
		}

		public function set fireEvent(value : Boolean) : void {
			_fireEvent = value;
		}
	}
}