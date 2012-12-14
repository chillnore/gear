package gear.codec.swf.data.shape {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GSwfLineStyle {
		protected var _width : int;
		protected var _color : uint;

		public function GSwfLineStyle() {
		}

		public function decode(data : GSwfStream) : void {
			_width = data.readUI16();
		}
	}
}
