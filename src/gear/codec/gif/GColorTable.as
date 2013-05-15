package gear.codec.gif {
	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public class GColorTable {
		public var data : ByteArray;

		public function GColorTable() {
		}

		public function decode(value : ByteArray, numColors : int) : void {
			data = new ByteArray();
			value.readBytes(data, 0, 3 * (2 << numColors));
		}
	}
}
