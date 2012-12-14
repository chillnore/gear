package gear.codec.swf.data.shape {
	import gear.codec.swf.GSwfStream;
	import gear.codec.swf.data.GSwfFocalGradient;
	import gear.codec.swf.data.GSwfMatrix;

	/**
	 * 填充类型
	 * 
	 * Solid fill 单色填充
	 * Gradient fill 渐变色填充
	 * Bitmap fill 位图填充
	 * 
	 * @author bright
	 * @version 20121121
	 */
	public class GSwfFillStyle {
		protected var _type : int;
		protected var _color : uint;
		protected var _gradientMatrix : GSwfMatrix;
		protected var _gradient : GSwfGradient;
		protected var _focalGradient : GSwfFocalGradient;
		protected var _bitmapId : int;
		protected var _bitmapMatrix : GSwfMatrix;

		public function GSwfFillStyle() {
		}


		public function decode(data : GSwfStream, level : int) : void {
			_type = data.readUI8();
			switch(_type) {
				// solid fill
				case 0x00:
					_color = (level < 2) ? data.readRGB() : data.readRGBA();
					break;
				// inear gradient fill
				case 0x10:
					_gradientMatrix = new GSwfMatrix();
					_gradientMatrix.decode(data);
					_gradient = new GSwfGradient();
					_gradient.decode(data, level);
					break;
				// radial gradient fill
				case 0x12:
					_gradientMatrix = new GSwfMatrix();
					_gradientMatrix.decode(data);
					_gradient = new GSwfGradient();
					_gradient.decode(data, level);
					break;
				// focal radial gradient fill (SWF 8 file format and later only)
				case 0x13:
					_gradientMatrix = new GSwfMatrix();
					_gradientMatrix.decode(data);
					_focalGradient = new GSwfFocalGradient();
					_focalGradient.decode(data, level);
					break;
				// repeating bitmap fill
				case 0x40:
					_bitmapId = data.readUI16();
					_bitmapMatrix = new GSwfMatrix();
					_bitmapMatrix.decode(data);
					break;
				// clipped bitmap fill
				case 0x41:
					_bitmapId = data.readUI16();
					_bitmapMatrix = new GSwfMatrix();
					_bitmapMatrix.decode(data);
					break;
				// non-smoothed repeating bitmap
				case 0x42:
					_bitmapId = data.readUI16();
					_bitmapMatrix = new GSwfMatrix();
					_bitmapMatrix.decode(data);
					break;
				// non-smoothed clipped bitmap
				case 0x43:
					_bitmapId = data.readUI16();
					_bitmapMatrix = new GSwfMatrix();
					_bitmapMatrix.decode(data);
					break;
			}
		}
	}
}
