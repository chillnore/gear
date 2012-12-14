package gear.geom {
	/**
	 * @author bright
	 * @version 20121204
	 */
	public class GSize {
		private var _width : int;
		private var _height : int;

		public function GSize(width : int, height : int) {
			_width = width;
			_height = height;
		}

		public function get width() : int {
			return _width;
		}

		public function get height() : int {
			return _height;
		}
	}
}
