package gear.gui.core {
	/**
	 * 对齐定义
	 * 
	 * @author bright
	 * @version 20121217
	 */
	public final class GAlign {
		// 居中对齐
		public static const CENTER : GAlign = new GAlign(-1, -1, -1, -1, 0, 0);
		// 铺满
		public static const FULL : GAlign = new GAlign(0, 0, 0, 0, -1, -1);
		// 左对齐
		protected var _left : int;
		// 右对齐
		protected var _right : int;
		// 顶对齐
		protected var _top : int;
		// 底对齐
		protected var _bottom : int;
		// 水平居中
		protected var _horizontalCenter : int;
		// 垂直居中
		protected var _verticalCenter : int;

		/**
		 * 构造函数
		 * 
		 * @param left 距离左侧的距离
		 * @param right 距离右侧的距离
		 * @param top 距离顶部的距离
		 * @param bottom 距离底部的距离
		 * @param horizontalCenter 是否水平居中
		 * @param verticalCenter 是否垂直居中
		 */
		public function GAlign(left : int = -1, right : int = -1, top : int = -1, bottom : int = -1, horizontalCenter : int = -1, verticalCenter : int = -1) {
			_left = left;
			_right = right;
			_top = top;
			_bottom = bottom;
			_horizontalCenter = horizontalCenter;
			_verticalCenter = verticalCenter;
		}

		public function set left(value : int) : void {
			_left = value;
			if (_left != -1) {
				_horizontalCenter = -1;
			}
		}

		public function get left() : int {
			return _left;
		}

		public function set right(value : int) : void {
			_right = value;
			if (_right != -1) {
				_horizontalCenter = -1;
			}
		}

		public function get right() : int {
			return _right;
		}

		public function set top(value : int) : void {
			_top = value;
			if (_top != -1) {
				_verticalCenter = -1;
			}
		}

		public function get top() : int {
			return _top;
		}

		public function set bottom(value : int) : void {
			_bottom = value;
			if (_bottom != -1) {
				_verticalCenter = -1;
			}
		}

		public function get bottom() : int {
			return _bottom;
		}

		public function set horizontalCenter(value : int) : void {
			_horizontalCenter = value;
			_left = -1;
			_right = -1;
		}

		public function get horizontalCenter() : int {
			return _horizontalCenter;
		}

		public function set verticalCenter(value : int) : void {
			_verticalCenter = value;
			_top = -1;
			_bottom = -1;
		}

		public function get verticalCenter() : int {
			return _verticalCenter;
		}

		public function clone() : GAlign {
			var align : GAlign = new GAlign(_left, _right, _top, _bottom, _horizontalCenter, _verticalCenter);
			return align;
		}

		public function toString() : String {
			return _left + "," + _right + "," + _top + "," + _bottom + "," + _horizontalCenter + "," + _verticalCenter;
		}
	}
}
