package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	import flash.utils.ByteArray;

	/**
	 * @author bright
	 */
	public final class GTagDefineBitsJPEG3 extends GTagDefineBitsJPEG2 {
		public static const TYPE : int = 35;
		protected var _bitmapAlphaData : ByteArray;

		public function GTagDefineBitsJPEG3() {
			_bitmapAlphaData = new ByteArray();
		}

		override public function decode(data : GSwfStream, length : uint) : void {
			_characterId = data.readUI16();
			var alphaDataOffset : uint = data.readUI32();
			data.readBytes(_data, alphaDataOffset);
			if (_data[0] == 0xff && (_data[1] == 0xd8 || _data[1] == 0xd9)) {
				_bitmapType = JPEG;
			} else if (_data[0] == 0x89 && _data[1] == 0x50 && _data[2] == 0x4e && _data[3] == 0x47 && _data[4] == 0x0d && _data[5] == 0x0a && _data[6] == 0x1a && _data[7] == 0x0a) {
				_bitmapType = PNG;
			} else if (_data[0] == 0x47 && _data[1] == 0x49 && _data[2] == 0x46 && _data[3] == 0x38 && _data[4] == 0x39 && _data[5] == 0x61) {
				_bitmapType = GIF89A;
			}
			var alphaDataSize : uint = length - alphaDataOffset - 6;
			if (alphaDataSize > 0) {
				data.readBytes(_bitmapAlphaData, alphaDataSize);
			}
		}
	}
}
