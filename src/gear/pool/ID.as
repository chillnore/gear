package gear.pool {
	/**
	 * @author bright
	 */
	public class ID {
		protected var _index : int;
		protected var _free : Vector.<int>;

		public function ID() {
			_index = 0;
			_free = new Vector.<int>();
		}

		public function get id() : int {
			if (_free.length > 0) {
				return _free.shift();
			} else {
				return _index++;
			}
		}

		public function free(value : int) : void {
			_free.push(value);
		}
	}
}
