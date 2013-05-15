package gear.codec.gif {
	import gear.codec.core.GLoadBytes;
	import gear.codec.core.IGDecoder;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;

	import flash.display.Bitmap;
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
		public static const WINDOWS : Vector.<uint> = new <uint>[0xFF000000, 0xFF800000, 0xFF008000, 0xFF808000, 0xFF000080, 0xFF800080, 0xFF008080, 0xFFC0C0C0, 0xFFC0DCC0, 0xFFA6CAF0, 0xFF2A3FAA, 0xFF2A3FFF, 0xFF2A5F00, 0xFF2A5F55, 0xFF2A5FAA, 0xFF2A5FFF, 0xFF2A7F00, 0xFF2A7F55, 0xFF2A7FAA, 0xFF2A7FFF, 0xFF2A9F00, 0xFF2A9F55, 0xFF2A9FAA, 0xFF2A9FFF, 0xFF2ABF00, 0xFF2ABF55, 0xFF2ABFAA, 0xFF2ABFFF, 0xFF2ADF00, 0xFF2ADF55, 0xFF2ADFAA, 0xFF2ADFFF, 0xFF2AFF00, 0xFF2AFF55, 0xFF2AFFAA, 0xFF2AFFFF, 0xFF550000, 0xFF550055, 0xFF5500AA, 0xFF5500FF, 0xFF551F00, 0xFF551F55, 0xFF551FAA, 0xFF551FFF, 0xFF553F00, 0xFF553F55, 0xFF553FAA, 0xFF553FFF, 0xFF555F00, 0xFF555F55, 0xFF555FAA, 0xFF555FFF, 0xFF557F00, 0xFF557F55, 0xFF557FAA, 0xFF557FFF, 0xFF559F00, 0xFF559F55, 0xFF559FAA, 0xFF559FFF, 0xFF55BF00, 0xFF55BF55, 0xFF55BFAA, 0xFF55BFFF, 0xFF55DF00, 0xFF55DF55, 0xFF55DFAA, 0xFF55DFFF, 0xFF55FF00, 0xFF55FF55, 0xFF55FFAA, 0xFF55FFFF, 0xFF7F0000, 0xFF7F0055, 0xFF7F00AA, 0xFF7F00FF, 0xFF7F1F00, 0xFF7F1F55, 0xFF7F1FAA, 0xFF7F1FFF, 0xFF7F3F00, 0xFF7F3F55, 0xFF7F3FAA, 0xFF7F3FFF, 0xFF7F5F00, 0xFF7F5F55, 0xFF7F5FAA, 0xFF7F5FFF, 0xFF7F7F00, 0xFF7F7F55, 0xFF7F7FAA, 0xFF7F7FFF, 0xFF7F9F00, 0xFF7F9F55, 0xFF7F9FAA, 0xFF7F9FFF, 0xFF7FBF00, 0xFF7FBF55, 0xFF7FBFAA, 0xFF7FBFFF, 0xFF7FDF00, 0xFF7FDF55, 0xFF7FDFAA, 0xFF7FDFFF, 0xFF7FFF00, 0xFF7FFF55, 0xFF7FFFAA, 0xFF7FFFFF, 0xFFAA0000, 0xFFAA0055, 0xFFAA00AA, 0xFFAA00FF, 0xFFAA1F00, 0xFFAA1F55, 0xFFAA1FAA, 0xFFAA1FFF, 0xFFAA3F00, 0xFFAA3F55, 0xFFAA3FAA, 0xFFAA3FFF, 0xFFAA5F00, 0xFFAA5F55, 0xFFAA5FAA, 0xFFAA5FFF, 0xFFAA7F00, 0xFFAA7F55, 0xFFAA7FAA, 0xFFAA7FFF, 0xFFAA9F00, 0xFFAA9F55, 0xFFAA9FAA, 0xFFAA9FFF, 0xFFAABF00, 0xFFAABF55, 0xFFAABFAA, 0xFFAABFFF, 0xFFAADF00, 0xFFAADF55, 0xFFAADFAA, 0xFFAADFFF, 0xFFAAFF00, 0xFFAAFF55, 0xFFAAFFAA, 0xFFAAFFFF, 0xFFD40000, 0xFFD40055, 0xFFD400AA, 0xFFD400FF, 0xFFD41F00, 0xFFD41F55, 0xFFD41FAA, 0xFFD41FFF, 0xFFD43F00, 0xFFD43F55, 0xFFD43FAA, 0xFFD43FFF, 0xFFD45F00, 0xFFD45F55, 0xFFD45FAA, 0xFFD45FFF, 0xFFD47F00, 0xFFD47F55, 0xFFD47FAA, 0xFFD47FFF, 0xFFD49F00, 0xFFD49F55, 0xFFD49FAA, 0xFFD49FFF, 0xFFD4BF00, 0xFFD4BF55, 0xFFD4BFAA, 0xFFD4BFFF, 0xFFD4DF00, 0xFFD4DF55, 0xFFD4DFAA, 0xFFD4DFFF, 0xFFD4FF00, 0xFFD4FF55, 0xFFD4FFAA, 0xFFD4FFFF, 0xFFFF0055, 0xFFFF00AA, 0xFFFF1F00, 0xFFFF1F55, 0xFFFF1FAA, 0xFFFF1FFF, 0xFFFF3F00, 0xFFFF3F55, 0xFFFF3FAA, 0xFFFF3FFF, 0xFFFF5F00, 0xFFFF5F55, 0xFFFF5FAA, 0xFFFF5FFF, 0xFFFF7F00, 0xFFFF7F55, 0xFFFF7FAA, 0xFFFF7FFF, 0xFFFF9F00, 0xFFFF9F55, 0xFFFF9FAA, 0xFFFF9FFF, 0xFFFFBF00, 0xFFFFBF55, 0xFFFFBFAA, 0xFFFFBFFF, 0xFFFFDF00, 0xFFFFDF55, 0xFFFFDFAA, 0xFFFFDFFF, 0xFFFFFF55, 0xFFFFFFAA, 0xFFCCCCFF, 0xFFFFCCFF, 0xFF33FFFF, 0xFF66FFFF, 0xFF99FFFF, 0xFFCCFFFF, 0xFF007F00, 0xFF007F55, 0xFF007FAA, 0xFF007FFF, 0xFF009F00, 0xFF009F55, 0xFF009FAA, 0xFF009FFF, 0xFF00BF00, 0xFF00BF55, 0xFF00BFAA, 0xFF00BFFF, 0xFF00DF00, 0xFF00DF55, 0xFF00DFAA, 0xFF00DFFF, 0xFF00FF55, 0xFF00FFAA, 0xFF2A0000, 0xFF2A0055, 0xFF2A00AA, 0xFF2A00FF, 0xFF2A1F00, 0xFF2A1F55, 0xFF2A1FAA, 0xFF2A1FFF, 0xFF2A3F00, 0xFF2A3F55, 0xFFFFFBF0, 0xFFA0A0A4, 0xFF808080, 0xFFFF0000, 0xFF00FF00, 0xFFFFFF00, 0xFF0000FF, 0xFFFF00FF, 0xFF00FFFF, 0xFFFFFFFF];
		protected var _data : ByteArray;
		protected var _onFinish : Function;
		protected var _onFailed : Function;
		protected var _version : String;
		protected var _logical : GLSD;
		protected var _graphicsControl : GGraphicsControl;
		protected var _gct : GColorTable;
		protected var _totalFrames : int;

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
				var color : GColorTable = new GColorTable();
				color.decode(_data, image.lctNumColors);
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
			lsd.gctNumColors = image.lctNumColors;
			lsd.encode(gif);
			if (color != null) {
				gif.writeBytes(color.data);
			} else if (_gct != null) {
				gif.writeBytes(_gct.data);
			} else {
			}
			if (_graphicsControl != null) {
				_graphicsControl.delayTime = 0;
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
			var load : GLoadBytes = new GLoadBytes(gif, function(offsetLeft : int, offsetTop : int, bd : BitmapData) : void {
				var bp : Bitmap = new Bitmap(bd);
				bp.x = offsetLeft;
				bp.y = offsetTop;
				trace(offsetLeft, offsetTop);
				GUIUtil.stage.addChild(bp);
			}, x, y);
			_totalFrames++;
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
			decodeHeader();
			decodeLogicalScreenDescriptor();
			if (_logical.gct == 1) {
				decodeGCT();
			}
			decodeContents();
			finish();
		}
	}
}
