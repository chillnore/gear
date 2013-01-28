package gear.game.move {
	/**
	 * @author bright
	 */
	public class GLineMove extends GMoveBase {
		override public function get total() : int {
			var count : Number = _dist / _speed;
			_total = Math.ceil(count > 0 ? count : -count);
			return _total;
		}

		override public function set total(value : int) : void {
			_total = value;
			_current = _start;
			_step = 0;
			_time = 0;
			if (_dist == 0) {
				return;
			}
			if (_mode == GMoveMode.UNIFORM) {
				_step = _dist / (_total - 1);
			} else if (_mode == GMoveMode.SUB) {
				_g = (-_dist << 1) / (_total * (_total - 1));
				_s = -_total * _g;
			} else if (_mode == GMoveMode.ADD) {
				_g = (_dist << 1) / (_total * (_total - 1));
				_s = 0;
			}
		}

		override public function next() : void {
			_time++;
			if (_dist == 0) {
				return;
			}
			if (_mode != GMoveMode.UNIFORM) {
				_s += _g;
				_step = _s;
			}
			_current += _step;
		}
	}
}
