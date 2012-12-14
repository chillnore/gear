package gear.codec.swf.data {
	import gear.codec.swf.GSwfStream;
	import gear.codec.swf.data.shape.GSwfGradient;

	/**
	 * @author bright
	 */
	public class GSwfFocalGradient extends GSwfGradient {
		protected var _focalPoint : Number;

		public function GSwfFocalGradient() {
		}

		override public function decode(data : GSwfStream, level : int) : void {
			super.decode(data, level);
			_focalPoint = data.readFIXED8();
		}
	}
}
