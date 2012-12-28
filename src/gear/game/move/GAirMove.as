package gear.game.move {
	/**
	 * 浮空移动
	 * 
	 * @author bright
	 * @version 20121225
	 */
	public class GAirMove extends GMoveBase {
		protected var _upT : int;
		protected var _upG : Number;
		protected var _upS : Number;
		protected var _dropT : int;
		protected var _dropG : Number;
		protected var _dropS : Number;

		public function GAirMove() {
		}

		override public function get total() : int {
			if (_dist == 0) {
				_total = 0;
				return _total;
			}
			var upH : int = _dist - _start;
			var dropH : int = _dist;
			if (upH < 0) {
				_upT = upH / _speed;
				_upT = Math.ceil(_upT > 0 ? _upT : -_upT);
			} else {
				_upT = 0;
			}
			_dropT = dropH / _speed;
			_dropT = Math.ceil(_dropT > 0 ? _dropT : -_dropT);
			_total = _upT + _dropT;
			return _total;
		}
		
		override public function set total(value : int) : void {
			_total = value;
			_step = 0;
			_current = _start;
			_end = _dist;
			_time = 0;
			if (_dist == 0) {
				return;
			}
			var upH : int = _dist - _start;
			var dropH : int = _dist;
			if (upH < 0) {
				_upT = Math.round(_total * (upH / (upH + dropH)));
				_upG = -upH * 2 / (_upT * (_upT - 1));
				_upS = -_upT * _upG;
			} else {
				_upT = 0;
			}
			_dropT = _total - _upT;
			_dropG = -dropH * 2 / (_dropT * (_dropT - 1));
			_dropS = (_upT > 0 ? -_dropG : 0);
		}

		override public function next() : void {
			_time++;
			if (_dist == 0) {
				return;
			}
			if (_time < _upT) {
				_upS += _upG;
				_step = _upS;
			} else {
				_dropS += _dropG;
				_step = _dropS;
			}
			_current += _step;
		}
	}
}
