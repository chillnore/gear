package gear.codec.swf {
	import gear.codec.swf.data.GSwfRect;

	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * @author bright
	 */
	public final class GSwfStream {
		private var _data : ByteArray;
		private var _bitPos : int;
		private var _bitBuf : int;

		public function GSwfStream() {
		}

		public function get bitPos() : int {
			return _bitPos;
		}

		public function resetBitPos() : void {
			_bitPos = 0;
		}

		public function set data(value : ByteArray) : void {
			_data = value;
			_data.endian = Endian.LITTLE_ENDIAN;
			_bitPos = 0;
		}

		public function uncompress(compressType : int, fileLength : int) : void {
			var body : ByteArray = new ByteArray();
			body.endian = Endian.LITTLE_ENDIAN;
			_data.readBytes(body, 0, _data.length - _data.position);
			if (compressType == GSwf.ZLIB) {
				body.uncompress();
			} else if (compressType == GSwf.LZMA) {
				/**
				 * LZMA compressed SWF:
				 * 0000 5A 57 53 0F   (ZWS, Version 15)
				 * 0004 DF 52 00 00   (Uncompressed size: 21215)
				 * 0008 94 3B 00 00   (Compressed size: 15252)
				 * 000C 5D 00 00 00 01   (LZMA Properties)
				 * 0011 00 3B FF FC A6 14 16 5A ...   (15252 bytes of LZMA Compressed Data, until EOF)
				 * 7z LZMA format:
				 * 0000 5D 00 00 00 01   (LZMA Properties)
				 * 0005 D7 52 00 00 00 00 00 00   (Uncompressed size: 21207, 64 bit)
				 * 000D 00 3B FF FC A6 14 16 5A ...   (15252 bytes of LZMA Compressed Data, until EOF) 
				 */
				for (var i : uint = 0; i < 5; i++) {
					body.writeByte(_data[i + 12]);
				}
				body.writeUnsignedInt(fileLength - 8);
				body.writeUnsignedInt(0);
				_data.position = 17;
				_data.readBytes(body, 0, 13);
				body.position = 0;
				// body.uncompress(CompressionAlgorithm.LZMA);
			}
			_data.clear();
			_data = body;
		}

		public function readUI8() : int {
			_bitPos = 0;
			return _data.readUnsignedByte();
		}

		public function readUI16() : int {
			_bitPos = 0;
			return _data.readUnsignedShort();
		}

		public function readUI32() : uint {
			_bitPos = 0;
			return _data.readUnsignedInt();
		}

		public function readSI32() : uint {
			_bitPos = 0;
			return _data.readInt();
		}

		public function readUB(bits : int) : uint {
			if (bits == 0) {
				return 0;
			}
			var bitsLeft : int = bits;
			var result : int = 0;
			if (_bitPos == 0) {
				_bitBuf = _data.readUnsignedByte();
				_bitPos = 8;
			}
			while (true) {
				var shift : int = bitsLeft - _bitPos;
				if (shift > 0) {
					result |= _bitBuf << shift;
					bitsLeft -= _bitPos;
					_bitBuf = _data.readUnsignedByte();
					_bitPos = 8;
				} else {
					result |= _bitBuf >> -shift;
					_bitPos -= bitsLeft;
					_bitBuf &= 0xff >> (8 - _bitPos);
					return result;
				}
			}
			return result;
		}

		public function readFIXED8() : Number {
			_bitPos = 0;
			return _data.readShort() / 256;
		}

		public function readRECT() : GSwfRect {
			_bitPos = 0;
			var rect : GSwfRect = new GSwfRect();
			rect.nbits = readUB(5);
			rect.xmin = readSB(rect.nbits);
			rect.xmax = readSB(rect.nbits);
			rect.ymin = readSB(rect.nbits);
			rect.ymax = readSB(rect.nbits);
			return rect;
		}

		public function readSB(bits : int) : int {
			var shift : int = 32 - bits;
			return (readUB(bits) << shift) >> shift;
		}

		public function readFB(bits : int) : Number {
			return Number(readSB(bits)) / 0x10000;
		}

		public function readEncodedU32() : int {
			_bitPos = 0;
			var result : uint = _data.readUnsignedByte();
			var temp : uint;
			if (!(result & 0x00000080)) {
				return result;
			}
			temp = _data.readUnsignedByte();
			result = (result & 0x0000007f) | temp << 7;
			if (!(result & 0x00004000)) {
				return result;
			}
			temp = _data.readUnsignedByte();
			result = (result & 0x00003fff) | temp << 14;
			if (!(result & 0x00200000)) {
				return result;
			}
			temp = _data.readUnsignedByte();
			result = (result & 0x001fffff) | temp << 21;
			if (!(result & 0x10000000)) {
				return result;
			}
			temp = _data.readUnsignedByte();
			result = (result & 0x0fffffff) | temp << 28;
			return result;
		}

		public function readString() : String {
			/**
			 * var s:String = "";
			 * var c:int;
			 * while (c=data.readUnsignedByte()) {
			 *   s += String.fromCharCode(c);
			 * }
			 */
			var index : uint = _data.position;
			while (_data[index++] != 0) {
			}
			return _data.readUTFBytes(index - _data.position);
		}

		public function readRGB() : uint {
			_bitPos = 0;
			var r : int = _data.readUnsignedByte();
			var g : int = _data.readUnsignedByte();
			var b : int = _data.readUnsignedByte();
			return r << 16 | g << 8 | b;
		}

		public function readRGBA() : uint {
			_bitPos = 0;
			var r : int = _data.readUnsignedByte();
			var g : int = _data.readUnsignedByte();
			var b : int = _data.readUnsignedByte();
			var a : int = _data.readUnsignedByte();
			return a << 24 | r << 16 | g << 8 | b;
		}

		public function readBytes(value : ByteArray, length : int) : void {
			_data.readBytes(value, 0, length);
		}

		/**
		 * FillStyleArrayLength
		 */
		public function readArrayLength() : uint {
			var count : uint = readUI8();
			if (count == 0xFF) {
				count = readUI16();
			}
			return count;
		}

		public function set position(value : uint) : void {
			_data.position = value;
		}

		public function get position() : uint {
			return _data.position;
		}
	}
}
