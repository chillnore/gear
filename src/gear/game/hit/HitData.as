package gear.game.hit {

	/**
	 * 碰撞定义
	 * 
	 * @author bright
	 * @version 20120420
	 */
	public final class HitData {
		private var _mode : int;
		private var _type : int;
		private var _dist : Number;
		private var _high : Number;
		private var _percent : int;
		private var _fixed : int;
		private var _backSpeed : int;
		private var _airSpeedX : int;
		private var _airSpeedY : int;

		public function HitData() {
		}

		public function parseObj(value : Object) : void {
			_mode = value.mode;
			_type = value.type;
			_percent = value.percent;
			_fixed = value.fixed;
			_dist = value.dist;
			_high = value.high;
			_backSpeed = value.backSpeed;
			_airSpeedX = value.airSpeedX;
			_airSpeedY = value.airSpeedY;
		}
	}
}
