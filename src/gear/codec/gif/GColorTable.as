package gear.codec.gif {
	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public final class GColorTable {
		private var _numColors : uint;
		private var _table : ByteArray;

		public function GColorTable() {
		}

		public function decode(value : ByteArray, numColors : uint) : void {
			_table = new ByteArray();
			_numColors = numColors;
			value.readBytes(_table, 0, 3 * (2 << _numColors));
		}

		public function get numColors() : uint {
			return _numColors;
		}

		public function get table() : ByteArray {
			return _table;
		}
	}
}
