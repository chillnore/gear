package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GTagShowFrame implements IGSwfTag {
		public static const TYPE : int = 1;

		public function decode(value : GSwfStream, length : uint) : void {
		}
	}
}
