package gear.game.hit {
	import flash.geom.Rectangle;

	/**
	 * 障碍定义
	 * 
	 * @author bright
	 * @version 20130105
	 */
	public class GBlockData {
		protected var _halfW : int;
		protected var _halfH : int;
		protected var _block : Rectangle;
		protected var _x : int;
		protected var _y : int;
		protected var _width : int;
		protected var _height : int;

		public function GBlockData(halfW : int = 20, halfH : int = 10) {
			setTo(halfW, halfH);
		}

		public function setTo(halfW : int, halfH : int) : void {
			_halfW = halfW;
			_halfH = halfH;
			_width = _halfW << 1;
			_height = _halfH << 1;
			_block = new Rectangle(-halfW, -halfH, _width, _height);
		}

		public function moveTo(nx : int, ny : int) : void {
			_x = nx;
			_block.x = _x - _halfW;
			_y = ny;
			_block.y = _y - _halfH;
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
		
		public function get width():int{
			return _width;
		}
		
		public function get height():int{
			return _height;
		}

		/**
		 * 障碍矩形-处理寻路
		 * 
		 * @return Rectangle
		 */
		public function get blockRect() : Rectangle {
			return _block;
		}

		public function isHit(value : GBlockData) : Boolean {
			return _block.intersects(value.blockRect);
		}
	}
}