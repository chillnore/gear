package gear.codec.swf.data.shape {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GSwfGradRecord {
		protected var _ratio : int;
		protected var _color : uint;

		public function GSwfGradRecord() {
		}

		public function decode(data : GSwfStream, level : int) : void {
			_ratio = data.readUI8();
			_color = (level < 2) ? data.readRGB() : data.readRGBA();
		}
	}
}
