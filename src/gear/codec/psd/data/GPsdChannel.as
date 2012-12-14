package gear.codec.psd.data {
	import flash.utils.ByteArray;

	/**
	 * Psd通道
	 * 
	 * @author bright
	 * @version 20121109
	 */
	public class GPsdChannel {
		public var id : int;
		public var length : int;
		public var compression : int;
		public var source : ByteArray;
		public var target : ByteArray;

		public function GPsdChannel() {
		}
	}
}
