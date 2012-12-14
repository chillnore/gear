package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public interface IGSwfTag {
		function decode(data : GSwfStream, length : uint) : void;
	}
}
