package gear.codec.atf {
	import gear.codec.core.GBytesLoader;
	import gear.codec.core.IGDecoder;
	import gear.log4a.GLogger;
	import gear.utils.GBAUtil;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * ATF-Adobe Texture Format 纹理文件解码器
	 * 
	 * @author bright
	 * @version 20130509
	 */
	public class GAtfDecoder implements IGDecoder {
		protected var _data : ByteArray;
		protected var _onFinish : Function;
		protected var _onFailed : Function;
		/**
		 * 0-RGB 888
		 * 1-RGBA 8888
		 * 3-RAW Compressed (DXT1+ETC1+PVRTV4bpp)
		 */
		protected var _format : int;
		protected var _width : int;
		protected var _height : int;
		protected var _count : int;
		protected var _bitmapData : BitmapData;

		protected function failed() : void {
			if (_onFailed != null) {
				try {
					_onFailed();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		protected function finish() : void {
			if (_onFinish != null) {
				try {
					_onFinish.apply(null, _onFinish.length < 1 ? null : [this]);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		protected function decodeLZMA() : void {
			var length : int ;
			var block : ByteArray;
			for (var i : int = 0; i < _count * 3; i++) {
				length = GBAUtil.readU24(_data);
				if (length > 0) {
					block = new ByteArray();
					_data.readBytes(block, 0, length);
					if (i == 0) {
						decodeDXT1(block);
					}
				}
			}
		}

		protected function decodeDXT1(value : ByteArray) : void {
			// TODO LZMA
			value;
		}

		protected function decodeJXR() : void {
			var length : int = GBAUtil.readU24(_data);
			if (length > 0) {
				var block : ByteArray = new ByteArray();
				_data.readBytes(block, 0, length);
				var loader : GBytesLoader = new GBytesLoader(block, onLoadFinish);
				loader.load();
			}
			for (var i : int = 1; i < _count; i++) {
				length = GBAUtil.readU24(_data);
				_data.position += length;
			}
		}

		protected function onLoadFinish(value : BitmapData) : void {
			if (value != null) {
				_bitmapData = value;
				finish();
			} else {
				failed();
			}
		}

		public function GAtfDecoder() {
		}

		public function get format() : int {
			return _format;
		}

		public function get width() : int {
			return _width;
		}

		public function get height() : int {
			return _height;
		}

		public function get count() : int {
			return _count;
		}

		public function decode(data : ByteArray, onFinish : Function, onFailed : Function) : void {
			_data = data;
			_data.position = 0;
			_onFinish = onFinish;
			_onFailed = onFailed;
			var signature : String = _data.readUTFBytes(3);
			if (signature != "ATF") {
				failed();
				return;
			}
			var length : int = GBAUtil.readU24(data);
			if (length != _data.length - 6) {
				failed();
				return;
			}
			_format = data.readUnsignedByte();
			_width = Math.pow(2, data.readUnsignedByte());
			_height = Math.pow(2, data.readUnsignedByte());
			_count = data.readUnsignedByte();
			GLogger.debug("格式", _format, "宽度", _width, "高度", _height, "块数", _count);
			if (_format == 3) {
				decodeLZMA();
				return;
			}
			decodeJXR();
		}

		public function get bitmapData() : BitmapData {
			return _bitmapData;
		}
	}
}
