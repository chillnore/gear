package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;
	import gear.codec.swf.data.GSwfColorTransformWithAlpha;
	import gear.codec.swf.data.GSwfMatrix;
	import gear.codec.swf.data.action.GSwfClipActions;

	/**
	 * @author bright
	 */
	public class GTagPlaceObject2 implements IGSwfTag {
		public static const TYPE : int = 26;
		protected var _hasClipActions : Boolean;
		protected var _hasClipDepth : Boolean;
		protected var _hasName : Boolean;
		protected var _hasRatio : Boolean;
		protected var _hasColorTransform : Boolean;
		protected var _hasMatrix : Boolean;
		protected var _hasCharacter : Boolean;
		protected var _hasMove : Boolean;
		protected var _depth : int;
		protected var _characterId : int;
		protected var _matrix : GSwfMatrix;
		protected var _colorTransform : GSwfColorTransformWithAlpha;
		protected var _ratio : int;
		protected var _name : String;
		protected var _clipDepth : int;
		protected var _clipActions : GSwfClipActions;

		public function GTagPlaceObject2() {
		}

		public function decode(data : GSwfStream, length : uint) : void {
			_hasClipActions = (data.readUB(1) == 1);
			_hasClipDepth = (data.readUB(1) == 1);
			_hasName = (data.readUB(1) == 1);
			_hasRatio = (data.readUB(1) == 1);
			_hasColorTransform = (data.readUB(1) == 1);
			_hasMatrix = (data.readUB(1) == 1);
			_hasCharacter = (data.readUB(1) == 1);
			_hasMove = (data.readUB(1) == 1);
			_depth = data.readUI16();
			if (_hasCharacter) {
				_characterId = data.readUI16();
			}
			if (_hasMatrix) {
				_matrix = new GSwfMatrix();
				_matrix.decode(data);
			}
			if (_hasColorTransform) {
				_colorTransform = new GSwfColorTransformWithAlpha();
				_colorTransform.decode(data);
			}
			if (_hasRatio) {
				_ratio = data.readUI16();
			}
			if (_hasName) {
				_name = data.readString();
			}
			if (_hasClipDepth) {
				_clipDepth = data.readUI16();
			}
			if (_hasClipActions) {
				_clipActions = new GSwfClipActions();
				_clipActions.decode(data);
			}
		}
	}
}
