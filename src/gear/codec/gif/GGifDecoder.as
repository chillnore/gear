package gear.codec.gif {
	import gear.codec.core.GBytesLoader;
	import gear.codec.core.IGDecoder;
	import gear.gui.bd.GBDFrame;
	import gear.gui.bd.GBDList;
	import gear.log4a.GLogger;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * GIF 纹理文件解码器
	 * 
	 * @author bright
	 * @version 20130514
	 */
	public class GGifDecoder implements IGDecoder {
		protected var _data : ByteArray;
		protected var _onFinish : Function;
		protected var _onFailed : Function;
		protected var _version : String;
		protected var _logical : GLSD;
		protected var _graphicsControl : GGraphicsControl;
		protected var _gct : GColorTable;
		protected var _count : int;
		protected var _total : int;
		protected var _list : GBDList;

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

		protected function onLoadFinish(value : BitmapData) : void {
			if (value != null) {
				finish();
			} else {
				failed();
			}
		}

		protected function decodeHeader() : void {
			// 标识符 3字节
			var signature : String = _data.readUTFBytes(3);
			if (signature != "GIF") {
				failed();
				return;
			}
			// 版本 3字节
			_version = _data.readUTFBytes(3);
			GLogger.debug("标记符", signature, "版本", _version);
		}

		/**
		 * 逻辑视屏描述
		 */
		protected function decodeLogicalScreenDescriptor() : void {
			_logical = new GLSD();
			_logical.decode(_data);
		}

		protected function decodeGCT() : void {
			_gct = new GColorTable();
			_gct.decode(_data, _logical.gctNumColors);
		}

		protected function decodeExtension() : void {
			var code : uint = _data.readUnsignedByte();
			if (code == 0xFF) {
				decodeApplication();
			} else if (code == 0xF9) {
				_graphicsControl = new GGraphicsControl();
				_graphicsControl.decode(_data);
			} else if (code == 0xFE) {
				decodeComment();
			} else {
			}
		}

		protected function decodeComment() : void {
			var length : int = _data.readUnsignedByte();
			while (length > 0) {
				_data.position += length;
				length = _data.readUnsignedByte();
			}
		}

		protected function decodeApplication() : void {
			var length : int = _data.readUnsignedByte();
			var appIdentifier : String = _data.readMultiByte(8, "ascii");
			var appAuthCode : String = _data.readMultiByte(3, "ascii");
			length = _data.readUnsignedByte();
			while (length > 0) {
				_data.position += length;
				length = _data.readUnsignedByte();
			}
			GLogger.debug("应用标识符", appIdentifier, "应用证明码", appAuthCode);
		}

		protected function decodeImage() : void {
			var image : GImageDescriptor = new GImageDescriptor();
			image.decode(_data);
			if (image.lct == 1) {
				var lct : GColorTable = new GColorTable();
				lct.decode(_data, image.lctNumColors);
			}
			var data : GImageData = new GImageData();
			data.decode(_data);
			var gif : ByteArray = new ByteArray();
			gif.endian = Endian.LITTLE_ENDIAN;
			gif.writeUTFBytes("GIF");
			gif.writeUTFBytes(_version);
			var lsd : GLSD = new GLSD();
			lsd.width = image.width;
			lsd.height = image.height;
			lsd.gct = 1;
			lsd.gctSorted = 0;
			lsd.bgColorIndex = _logical.bgColorIndex;
			lsd.gctColorResolution = _logical.gctColorResolution;
			if (image.lct == 1) {
				lsd.gctNumColors = lct.numColors;
			} else {
				lsd.gctNumColors = _gct.numColors;
			}
			lsd.encode(gif);
			if (lct != null) {
				gif.writeBytes(lct.table);
			} else if (_gct != null) {
				gif.writeBytes(_gct.table);
			} else {
			}
			if (_graphicsControl != null) {
				_graphicsControl.encode(gif);
			}
			var x : int = image.offsetLeft;
			var y : int = image.offsetTop;
			image.offsetLeft = 0;
			image.offsetTop = 0;
			image.lct = 0;
			image.lctNumColors = 0;
			image.encode(gif);
			data.encode(gif);
			gif.writeByte(0x3B);
			var loader : GBytesLoader = new GBytesLoader(gif, onLoad, _total++, _graphicsControl.delayTime, x, y);
			loader.load();
		}

		protected function onLoad(index : int, delay : int, offsetX : int, offsetY : int, bd : BitmapData) : void {
			delay = (delay < 1 ? 80 : delay * 12);
			_list.setAt(index, new GBDFrame(offsetX, offsetY, bd, delay));
			_count++;
			if (_count >= _total) {
				finish();
			}
		}

		protected function decodeContents() : void {
			while (true) {
				var code : uint = _data.readUnsignedByte();
				if (code == 0x21) {
					decodeExtension();
				} else if (code == 0x2C) {
					decodeImage();
				} else if (code == 0x3B) {
					break;
				} else {
					trace("错误标志", code);
					break;
				}
			}
		}

		public function GGifDecoder() {
		}

		public function decode(data : ByteArray, onFinish : Function, onFailed : Function) : void {
			_data = data;
			_data.position = 0;
			_data.endian = Endian.LITTLE_ENDIAN;
			_onFinish = onFinish;
			_onFailed = onFailed;
			_count = 0;
			_total = 0;
			_list = new GBDList();
			decodeHeader();
			decodeLogicalScreenDescriptor();
			if (_logical.gct == 1) {
				decodeGCT();
			}
			decodeContents();
		}

		public function get bdList() : GBDList {
			return _list;
		}
	}
}
