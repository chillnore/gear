package gear.codec.psd {
	import gear.log4a.GLogError;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * @author bright
	 */
	public class GPsdUtil {
		public static function toRGB(source : ByteArray, colorDepth : int) : ByteArray {
			if (source == null) {
				return null;
			}
			if (colorDepth == 8) {
				return source;
			}
			source.position = 0;
			var target : ByteArray = new ByteArray();
			var len : int;
			var i : int;
			if (colorDepth == 16) {
				len = source.length >> 1;
				for (i = 0;i < len;i++) {
					target.writeByte(source.readUnsignedShort() / 0xFFFF * 0xFF);
				}
			} else if (colorDepth == 32) {
				// 4字节浮点数
				len = source.length >> 2;
				for (i = 0;i < len;i++) {
					target.writeByte(source.readFloat() * 0xFF);
				}
			}
			return target;
		}

		public static function renderToBD(channels : Vector.<ByteArray>, width : int, height : int) : BitmapData {
			var bitmapData : BitmapData;
			var alpha : ByteArray;
			var red : ByteArray;
			var green : ByteArray;
			var blue : ByteArray;
			if (channels.length > 3) {
				bitmapData = new BitmapData(width, height, true, 0x000000);
				red = channels[0];
				green = channels[1];
				blue = channels[2];
				alpha = channels[3];
				alpha.position = red.position = green.position = blue.position = 0;
			} else if (channels.length == 3) {
				bitmapData = new BitmapData(width, height, false, 0x000000);
				red = channels[0];
				green = channels[1];
				blue = channels[2];
				red.position = green.position = blue.position = 0;
			} else {
				return bitmapData;
			}
			bitmapData.lock();
			var color : uint;
			for ( var y : int = 0; y < height; ++y ) {
				for ( var x : int = 0; x < width; ++x ) {
					if (alpha != null) {
						color = alpha.readUnsignedByte() << 24 | red.readUnsignedByte() << 16 | green.readUnsignedByte() << 8 | blue.readUnsignedByte();
						bitmapData.setPixel32(x, y, color);
					} else {
						color = red.readUnsignedByte() << 16 | green.readUnsignedByte() << 8 | blue.readUnsignedByte();
						bitmapData.setPixel(x, y, color);
					}
				}
			}
			bitmapData.unlock();
			return bitmapData;
		}

		public static function decodeRLELine(source : ByteArray) : ByteArray {
			var i : int;
			var n : int;
			var byte : int;
			var target : ByteArray = new ByteArray();
			var count : int;
			while ( source.bytesAvailable ) {
				n = source.readByte();
				if ( n >= 0 ) {
					count = n + 1;
					for ( i = 0; i < count; ++i ) {
						target.writeByte(source.readByte());
					}
				} else {
					byte = source.readByte();
					count = 1 - n;
					for ( i = 0; i < count; ++i ) {
						target.writeByte(byte);
					}
				}
			}
			return target;
		}

		public static function decodeRLE(source : ByteArray, height : int) : ByteArray {
			source.position = 0;
			var lines : Array = new Array(height);
			var i : int = 0;
			var total : int;
			var size : int;
			for ( i = 0; i < height; ++i ) {
				size = source.readUnsignedShort();
				lines[i] = size;
				total += lines[i];
			}
			if (source.position + total != source.length) {
				throw new GLogError("rle decode error");
			}
			var target : ByteArray = new ByteArray();
			var length : int = 0;
			var j : int;
			var k : int;
			var n : int;
			var count : int;
			for ( i = 0; i < height; ++i ) {
				length = lines[i];
				j = 0;
				count = 0;
				while (j < length) {
					n = source.readByte();
					j++;
					if (n >= 0) {
						count = n + 1;
						for (k = 0;k < count;++k) {
							target.writeByte(source.readByte());
						}
						j += count;
					} else {
						count = 1 - n;
						var byte : int = source.readByte();
						for (k = 0;k < count;++k) {
							target.writeByte(byte);
						}
						j++;
					}
				}
			}
			return target;
		}

		public static function parseColor(data : ByteArray) : uint {
			var red : int = data.readUnsignedShort() / 0xFFFF * 0xFF;
			var green : int = data.readUnsignedShort() / 0xFFFF * 0xFF;
			var blue : int = data.readUnsignedShort() / 0xFFFF * 0xFF;
			var alpha : int = data.readUnsignedShort() / 0xFFFF * 0xFF;
			var color : uint = alpha << 24 | red << 16 | green << 8 | blue;
			return color;
		}
	}
}
