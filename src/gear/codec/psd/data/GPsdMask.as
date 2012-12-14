package gear.codec.psd.data {
	import flash.geom.Rectangle;

	/**
	 * @author bright
	 */
	public class GPsdMask {
		public var bounds : Rectangle;
		public var defaultColor : uint;
		public var relative : Boolean;
		public var disabled : Boolean;
		public var invert : Boolean;
		public var padding : int;

		public function GPsdMask() {
		}
	}
}
