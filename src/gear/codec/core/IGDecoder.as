package gear.codec.core {
	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public interface IGDecoder {
		function decode(data : ByteArray, onFinish: Function, onFailed : Function) : void;
	}
}
