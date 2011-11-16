package gear.particle.counter {
	import gear.particle.core.Emitter;

	/**
	 * @author Administrator
	 */
	public class Steady implements ICounter {
		protected var _timeToNext : Number;
		protected var _rate : Number;
		protected var _rateInv : Number;
		protected var _running : Boolean;

		public function Steady(rate : Number = 0) {
			if (rate < 0 ) {
				rate = 0;
			}
			if ( _rate != rate ) {
				_rate = rate;
				_rateInv = rate ? 1000 / rate : Number.MAX_VALUE;
				_timeToNext = _rateInv;
			}
		}

		public function startEmitter(value : Emitter) : int {
			_running = true;
			_timeToNext = _rateInv;
			return 0;
		}

		public function updateEmitter(emitter : Emitter, elapsed : int) : uint {
			if ( !_running ) {
				return 0;
			}
			var count : uint = 0;
			_timeToNext -= elapsed;
			while ( _timeToNext <= 0 ) {
				++count;
				_timeToNext += _rateInv;
			}
			return count;
		}

		public function stop() : void {
			_running = false;
		}

		public function resume() : void {
			_running = true;
		}

		public function get complete() : Boolean {
			return false;
		}

		public function get running() : Boolean {
			return _running;
		}
	}
}
