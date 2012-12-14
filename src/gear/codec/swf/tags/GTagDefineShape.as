package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;
	import gear.codec.swf.data.GSwfRect;
	import gear.codec.swf.data.shape.GSwfShapeWithStyle;

	/**
	 * DefineShape
	 * 
	￼ * @author bright
	 */
	public class GTagDefineShape implements IGSwfTag {
		public static const TYPE : int = 2;
		protected var _characterId : int;
		protected var _shapeBounds : GSwfRect;
		protected var _shapes : GSwfShapeWithStyle;

		public function GTagDefineShape() {
		}

		public function decode(data : GSwfStream, length : uint) : void {
			_characterId = data.readUI16();
			_shapeBounds = data.readRECT();
			_shapes = new GSwfShapeWithStyle();
			_shapes.decode(data, 1);
		}
	}
}
