package gear.utils {
	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public class GBAUtil {
		public static function readU24(value : ByteArray) : int {
			return (value.readUnsignedByte() << 16) + (value.readUnsignedByte() << 8) + value.readUnsignedByte();
		}
	}
}
