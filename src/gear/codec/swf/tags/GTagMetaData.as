package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GTagMetaData implements IGSwfTag {
		public static const TYPE : int = 77;
		public var metaData : String;

		public function GTagMetaData() {
		}

		public function decode(value : GSwfStream, length : uint) : void {
			metaData = value.readString();
		}
	}
}
