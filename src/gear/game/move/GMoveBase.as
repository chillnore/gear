package gear.game.move {
	/**
	 * 移动基类
	 * 
	 * @author bright
	 * @version 20130107
	 */
	public class GMoveBase implements IGMove {
		// 模式
		protected var _mode : int;
		// 开始值
		protected var _start : int;
		// 距离
		protected var _dist : int;
		// 结束值
		protected var _end : Number;
		// 速度
		protected var _speed : Number;
		// 步长
		protected var _step : Number;
		// 当前值
		protected var _current : Number;
		// 加速度
		protected var _g : Number;
		// 当前速度
		protected var _s : Number;
		// 时间
		protected var _time : int;
		// 总时间
		protected var _total : int;

		public function GMoveBase() : void {
		}

		public function set mode(value : int) : void {
			_mode = value;
		}

		public function set speed(value : Number) : void {
			_speed = value;
		}

		public function setTo(start : int, dist : int) : void {
			_start = start;
			_dist = dist;
		}

		public function get total() : int {
			return 0;
		}

		public function set total(value : int) : void {
		}

		public function next() : void {
		}

		public function get step() : int {
			return _step + 0.5 | 0;
		}

		public function get current() : int {
			return _current + 0.5 | 0;
		}

		public function set dist(value : int) : void {
			_dist = value;
		}

		public function get dist() : int {
			return _dist;
		}
	}
}
