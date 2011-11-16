package gear.motion {
	/**
	 * 抽象缓动类
	 * 
	 * @author bright
	 * @version 20101020
	 */
	public class AGTween implements IGTween {
		/**
		 * @private
		 */
		protected var _target : Object;
		/**
		 * @private
		 */
		protected var _duration : int;
		/**
		 * @private
		 */
		protected var _ease : Function;
		/**
		 * @private
		 */
		protected var _start : int;
		/**
		 * @private
		 */
		protected var _time : int;
		/**
		 * @private
		 */
		protected var _position : Number;

		public function AGTween(duration : int, ease : Function, start : int) {
			_duration = duration;
			_ease = ease;
			_start = start;
		}

		public function set target(value : Object) : void {
			_target = value;
			reset();
		}

		public function init(target : Object, duration : int, ease : Function) : void {
			_target = target;
			if (_duration == 0) _duration = duration;
			if (_ease == null) _ease = ease;
			reset();
		}

		public function next() : Boolean {
			return false;
		}

		public function get position() : Number {
			return _position;
		}

		public function reset() : void {
			_time = 0;
		}
	}
}
