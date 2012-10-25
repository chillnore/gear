package gear.game.hit {
	import flash.geom.Rectangle;

	/**
	 * 攻击碰撞
	 * 
	 * @author bright
	 * @version 20120418
	 */
	public final class AttackHit {
		public static const PHYSIC : int = 1;
		public static const MAGIC : int = 2;
		private var _mode : int;
		private var _type : int;
		private var _source : Rectangle;
		private var _hitRect : Rectangle;
		private var _halfH : int;
		private var _dist : Number;
		private var _high : Number;
		private var _percent : int;
		private var _fixed : int;
		private var _x : int;
		private var _y : int;
		private var _z : int;
		private var _backSpeed : int;
		private var _airSpeedX : int;
		private var _airSpeedY : int;

		/**
		 * AttakHit
		 * 
		 * @param mode 攻击模式-@see gear.game.HitMode
		 * @param type 攻击类型-PHYSIC物理攻击,MAGIC魔法攻击
		 * @param hitRect 碰撞矩形
		 * @param halfH 碰撞Y轴差值范围
		 * @param percent 伤害百分比
		 * @param fixed 伤害修正值
		 * @param dist 击退距离
		 * @param high 击飞高度
		 */
		public function AttackHit(mode : int = 0, type : int = 1, hitRect : Rectangle = null, halfH : int = 35, percent : int = 17, fixed : int = 0, dist : Number = 50, high : Number = 0, backSpeed : int = 4, airSpeedX : int = 4, airSpeedY : int = 4) {
			_mode = mode;
			_type = type;
			_source = hitRect;
			if (hitRect != null) {
				_hitRect = _source.clone();
			}
			_halfH = halfH;
			_percent = percent;
			_fixed = fixed;
			_dist = dist;
			_high = high;
			_backSpeed = backSpeed;
			_airSpeedX = airSpeedX;
			_airSpeedY = airSpeedY;
		}

		/**
		 * 为方便调整参数加的重设碰撞区域函数
		 */
		public function resetRect(hitRect : Rectangle, halfH : uint = 10, dist : Number = 0, high : Number = 0, backSpeed : int = 4, flySpeedX : int = 4, flySpeedY : int = 4) : void {
			_source = hitRect;
			_hitRect = _source.clone();
			_dist = dist;
			_high = high;
			_halfH = halfH;
			_backSpeed = backSpeed;
			_airSpeedX = flySpeedX;
			_airSpeedY = flySpeedY;
		}

		public function get mode() : int {
			return _mode;
		}

		public function get type() : int {
			return _type;
		}

		public function get percent() : int {
			return _percent;
		}

		public function get fixed() : int {
			return _fixed;
		}

		public function get hitRect() : Rectangle {
			return _hitRect;
		}

		public function get dist() : Number {
			return _dist;
		}

		public function get high() : Number {
			return _high;
		}

		public function reset(nx : int, ny : int, nz : int = 0, flipH : Boolean = false) : void {
			_x = nx;
			_y = ny;
			_z = nz;
			if (flipH) {
				_hitRect.x = _x - _source.x - _source.width;
			} else {
				_hitRect.x = _x + _source.x;
			}
			_hitRect.y = _y + _source.y + _z;
		}

		public function set x(value : int) : void {
			_x = value;
		}

		public function get x() : int {
			return _x;
		}

		public function set y(value : int) : void {
			_y = value;
		}

		public function get y() : int {
			return _y;
		}

		public function hit(value : BlockData) : Boolean {
			var dy : int = _y - value.y;
			if (_halfH != -1 && ((dy > 0 ? dy : -dy) > _halfH)) {
				return false;
			}
			return _hitRect.intersects(value.hitRect);
		}

		public function get halfH() : int {
			return _halfH;
		}

		public function get source() : Rectangle {
			return _source;
		}

		public function get backSpeed() : int {
			return _backSpeed;
		}

		public function get airSpeedX() : int {
			return _airSpeedX;
		}

		public function get airSpeedY() : int {
			return _airSpeedY;
		}

		public function set mode(mode : int) : void {
			_mode = mode;
		}

		public function set type(type : int) : void {
			_type = type;
		}

		public function set source(source : Rectangle) : void {
			_source = source;
		}

		public function set hitRect(hitRect : Rectangle) : void {
			_hitRect = hitRect;
		}

		public function set halfH(halfH : int) : void {
			_halfH = halfH;
		}

		public function set dist(dist : Number) : void {
			_dist = dist;
		}

		public function set high(high : Number) : void {
			_high = high;
		}

		public function set percent(percent : int) : void {
			_percent = percent;
		}

		public function set fixed(fixed : int) : void {
			_fixed = fixed;
		}

		public function set backSpeed(backSpeed : int) : void {
			_backSpeed = backSpeed;
		}

		public function set airSpeedX(airSpeedX : int) : void {
			_airSpeedX = airSpeedX;
		}

		public function set airSpeedY(airSpeedY : int) : void {
			_airSpeedY = airSpeedY;
		}

		public function parseObj(object : Object) : void {
			_mode = object.mode;
			_type = object.type;
			_source = new Rectangle(object.source.x, object.source.y, object.source.width, object.source.height);
			_hitRect = _source.clone();
			_halfH = object.halfH;
			_dist = object.dist;
			_high = object.high;
			_percent = object.percent;
			_fixed = object.fixed;
			_backSpeed = object.backSpeed;
			_airSpeedX = object.flySpeedX;
			_airSpeedY = object.flySpeedY;
		}
	}
}