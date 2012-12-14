package gear.codec.swf.data {
	import gear.codec.swf.GSwfStream;

	import flash.geom.Matrix;

	/**
	 * @author bright
	 * @version 20121122
	 */
	public class GSwfMatrix {
		protected var _scaleX : Number;
		protected var _scaleY : Number;
		protected var _rotateSkew0 : Number;
		protected var _rotateSkew1 : Number;
		protected var _translateX : Number;
		protected var _translateY : Number;
		protected var _matrix : Matrix;

		public function GSwfMatrix() {
		}


		public function decode(data : GSwfStream) : void {
			var hasScale : Boolean = (data.readUB(1) == 1);
			var offset : int = 1;
			if (hasScale) {
				var scaleBits : uint = data.readUB(5);
				_scaleX = data.readFB(scaleBits);
				_scaleY = data.readFB(scaleBits);
				offset += 5 + scaleBits * 2;
			} else {
				_scaleX = 1;
				_scaleY = 1;
			}
			var hasRotate : Boolean = (data.readUB(1) == 1);
			if (hasRotate) {
				var rotateBits : uint = data.readUB(5);
				_rotateSkew0 = data.readFB(rotateBits);
				_rotateSkew1 = data.readFB(rotateBits);
				offset += 5 + rotateBits * 2;
			} else {
				_rotateSkew0 = 0;
				_rotateSkew1 = 0;
			}
			var translateBits : uint = data.readUB(5);
			_translateX = data.readSB(translateBits);
			_translateY = data.readSB(translateBits);
			offset += 5 + translateBits * 2;
			_matrix = new Matrix(_scaleX * 0.05, _rotateSkew0, _rotateSkew1, _scaleY * 0.05, _translateX * 0.05, _translateY * 0.05);
		}

		public function getMatrix() : Matrix {
			return _matrix;
		}
	}
}
