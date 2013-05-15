package gear.codec.gif {
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public class GImageData {
		// LZW 最小编码尺寸
		public var lzwMinCodeSize : int;
		public var bytes : ByteArray;

		public function GImageData() {
		}

		public function decode(value : ByteArray) : void {
			lzwMinCodeSize = value.readUnsignedByte();
			bytes = new ByteArray();
			var length : int = value.readUnsignedByte();
			while (length > 0) {
				value.readBytes(bytes, bytes.length, length);
				length = value.readUnsignedByte();
			}
			GLogger.debug("LZW 最小编码尺寸", lzwMinCodeSize, "数据长度", bytes.length);
		}

		public function encode(value : ByteArray) : void {
			value.writeByte(lzwMinCodeSize);
			bytes.position = 0;
			var length : int;
			while (bytes.position < bytes.length) {
				length = Math.min(bytes.length - bytes.position, 0xFF);
				value.writeByte(length);
				value.writeBytes(bytes, bytes.position, length);
				bytes.position += length;
			}
			value.writeByte(0);
		}
	}
}
