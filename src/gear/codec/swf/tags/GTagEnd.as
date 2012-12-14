package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GTagEnd implements IGSwfTag {
		public static const TYPE : int = 0;

		public function decode(value : GSwfStream, length : uint) : void {
		}
	}
}
