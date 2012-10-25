package gear.game.hit {
	import flash.geom.Rectangle;

	/**
	 * 攻击碰撞
	 * 
	 * @author bright
	 * @version 20111206
	 */
	public final class AttackHitObject {
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
		private var _flySpeedX : int;
		private var _flySpeedY : int;

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
		public function AttackHitObject() {

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

		public function get flySpeedX() : int {
			return _flySpeedX;
		}

		public function get flySpeedY() : int {
			return _flySpeedY;
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

		public function set flySpeedX(flySpeedX : int) : void {
			_flySpeedX = flySpeedX;
		}

		public function set flySpeedY(flySpeedY : int) : void {
			_flySpeedY = flySpeedY;
		}
	}
}