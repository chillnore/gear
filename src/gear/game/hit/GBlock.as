package gear.game.hit {
	import flash.geom.Rectangle;

	/**
	 * 障碍定义
	 * 
	 * @author bright
	 * @version 20130105
	 */
	public class GBlock {
		protected var _halfW : int;
		protected var _halfH : int;
		protected var _hitRect : Rectangle;
		protected var _x : int;
		protected var _y : int;

		public function GBlock(halfW : int = 10, halfH : int = 10) {
			setTo(halfW, halfH);
		}

		public function setTo(halfW : int, halfH : int) : void {
			_halfW = halfW;
			_halfH = halfH;
			_hitRect = new Rectangle(-halfW, -halfH, _halfW << 1, _halfH << 1);
		}

		public function moveTo(nx : int, ny : int) : void {
			_x = nx;
			_hitRect.x = _x - _halfW;
			_y = ny;
			_hitRect.y = _y - _halfH;
		}

		public function get halfW() : int {
			return _halfW;
		}

		public function get halfH() : int {
			return _halfH;
		}

		public function get x() : int {
			return _x;
		}

		public function get y() : int {
			return _y;
		}

		/**
		 * 障碍矩形-处理寻路
		 * 
		 * @return Rectangle
		 */
		public function get hitRect() : Rectangle {
			return _hitRect;
		}

		public function isHit(value : GBlock) : Boolean {
			return _hitRect.intersects(value.hitRect);
		}
	}
}