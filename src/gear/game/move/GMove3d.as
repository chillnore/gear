package gear.game.move {
	/**
	 * 移动控制
	 * 
	 * @author bright
	 * @version 20121225
	 */
	public class GMove3d {
		protected var _moveX : IGMove;
		protected var _moveY : IGMove;
		protected var _moveZ : IGMove;
		protected var _speedX : Number;
		protected var _speedY : Number;
		protected var _speedZ : Number;
		protected var _wait : int;
		protected var _total : int;
		protected var _time : int;

		public function GMove3d() {
			_moveX = new GLineMove();
			_moveY = new GLineMove();
			_moveZ = new GAirMove();
		}
		
		public function setMode(modeX: int, modeY : int) : void {
			_moveX.mode=modeX;
			_moveY.mode=modeY;
		}

		public function setSpeed(speed : Number, speedZ : Number, scaleY : Number = 0.8) : void {
			_speedX = speed;
			_speedY = _speedX * scaleY;
			_moveZ.speed = speedZ;
		}

		public function reset(startX : int, distX : int, startY : int, distY : int, startZ : int = 0, distZ : int = 0, wait : int = 0) : void {
			var angle : Number = Math.atan2(distY, distX);
			_moveX.speed = _speedX * Math.cos(angle);
			_moveY.speed = _speedY * Math.sin(angle);
			_moveX.setTo(startX, distX);
			_moveY.setTo(startY, distY);
			_moveZ.setTo(startZ, distZ);
			_wait = wait;
			_total = Math.max(_moveX.total, _moveY.total, _moveZ.total);
			_moveX.total = _moveY.total = _moveZ.total = _total;
			_time = 1;
		}
		
		public function bounce(percent : Number, distZ : int, total : int) : void {
			_moveX.dist=_moveX.dist * percent;
			_moveY.dist = Math.round(_moveY.dist * percent);
			_moveZ.setTo(0,distZ);
			_total = Math.max(_moveX.total, _moveY.total, _moveZ.total);
			if (_total < total) {
				_total = total;
			}
			_total = total;
			_moveX.total=_moveY.total=_moveZ.total=_total;
			_time = 1;
		}

		public function get hasNext() : Boolean {
			if (_wait > 0) {
				_wait--;
				return true;
			}
			if (_time >= _total) {
				return false;
			}
			_moveX.next();
			_moveY.next();
			_moveZ.next();
			_time++;
			return true;
		}

		public function get moveX() : IGMove {
			return _moveX;
		}

		public function get moveY() : IGMove {
			return _moveY;
		}

		public function get moveZ() : IGMove {
			return _moveZ;
		}
	}
}
