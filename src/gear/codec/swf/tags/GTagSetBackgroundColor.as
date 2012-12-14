package gear.codec.swf.tags {
	import gear.codec.swf.tags.IGSwfTag;
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GTagSetBackgroundColor implements IGSwfTag {
		public static const TYPE : int = 9;
		public var backgroundColor : uint;

		public function GTagSetBackgroundColor() {
		}

		public function decode(data : GSwfStream,length:uint) : void {
			backgroundColor = data.readRGB();
		}
	}
}
