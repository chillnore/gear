package gear.geom {
	/**
	 * @author admin
	 */
	public class Size {
		private var _width : int;
		private var _height : int;

		public function Size(width : int, height : int) {
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
