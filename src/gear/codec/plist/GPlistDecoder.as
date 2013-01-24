package gear.codec.plist {
	import gear.core.IDispose;
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;

	/**
	 * plist文件解码
	 * 
	 * @author bright
	 * @version 20121025
	 */
	public class GPlistDecoder implements IDispose {
		private var _data : ByteArray;
		private var _offsetSize : int;
		private var _objectRefSize : int;
		private var _numObjects : int;
		private var _topObject : int;
		private var _tableOffset : int;
		private var _offsetTable : Array;
		private var _plistObj : Object;

		private function readObject(obj : int) : * {
			var offset : int = _offsetTable[obj];
			var type : int = _data[offset];
			// First 4 bits
			var objType : int = (type & 0xF0) >> 4;
			// Second 4 bits
			var objInfo : int = (type & 0x0F);
			// primitive
			if (objType == 0x0) {
				return readPrimitive(objInfo);
			}
			// integer
			if (objType == 0x1) {
				return readInt(objInfo, offset);
			}
			// Number
			if (objType == 0x2) {
				return readNumber(objInfo, offset);
			}
			// Date
			if (objType == 0x3) {
				return readDate(objInfo, offset);
			}
			// Data
			if (objType == 0x4) {
				return readData(objInfo, offset);
			}
			// ascii
			if (objType == 0x5) {
				return readAscii(objInfo, offset);
			}
			// Array
			if (objType == 0xA) {
				return readArray(objInfo, offset);
			}
			// Dictionary
			if (objType == 0xD) {
				return readDict(objInfo, offset);
			}
			GLogger.error("Unknown object type:" + objType);
		}

		private function readPrimitive(objInfo : int) : * {
			if (objInfo == 0x8) {
				return false;
			}
			if (objInfo == 0x9) {
				return true;
			}
			return null;
		}

		private function readInt(objInfo : int, offset : int) : * {
			var length : int = Math.pow(2, objInfo);
			_data.position = offset + 1;
			if (length == 1) {
				return _data.readByte();
			}
			if (length == 2) {
				return _data.readShort();
			}
			if (length == 4) {
				return _data.readInt();
			}
			if (length == 8) {
				var high : int = _data.readInt();
				var low : int = _data.readInt();
				return ((high * 0x100000000 + low) << 32);
			}
			GLogger.error("parseInt length error", length);
			return null;
		}

		private function readNumber(objInfo : int, offset : int) : * {
			var length : int = Math.pow(2, objInfo);
			_data.position = offset + 1;
			if (length == 4) {
				return _data.readFloat();
			}
			if (length == 8) {
				return _data.readDouble();
			}
			GLogger.error("parseReal length error", length);
			return null;
		}

		private function readDate(objInfo : int, offset : int) : * {
			if (objInfo != 0x3) {
				return null;
			}
			_data.position = offset + 1;
			var time : Number = _data.readDouble();
			var date : Date = new Date((time + 0x3A4FC880) * 1000);
			return date;
		}

		private function readData(objInfo : int, offset : int) : * {
			var dataOffset : int = 1;
			var length : int = objInfo;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				dataOffset = 2 + intLength;
				length = readUnsignedInt(readBytes(_data, offset + 2, intLength));
			}
			if (intLength < 1) {
				return null;
			}
			var bytes : ByteArray = new ByteArray();
			_data.position = offset + 2;
			_data.readBytes(bytes, 0, intLength);
			return bytes;
		}

		private function readAscii(objInfo : int, offset : int) : * {
			var length : int = objInfo;
			var strOffset : int = 1;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				strOffset = 2 + intLength;
				length = readUnsignedInt(readBytes(_data, offset + 2, intLength));
			}
			_data.position = offset + strOffset;
			return _data.readUTFBytes(length);
		}

		private function readArray(objInfo : int, offset : int) : * {
			var length : int = objInfo;
			var arrayOffset : int = 1;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				arrayOffset = 2 + intLength;
				length = readUnsignedInt(readBytes(_data, offset + 2, intLength));
			}
			var array : Array = new Array();
			var objRef : int;
			for (var i : int = 0;i < length;i++) {
				objRef = readUnsignedInt(readBytes(_data, offset + arrayOffset + i * _objectRefSize, _objectRefSize));
				array[i] = readObject(objRef);
			}
			return array;
		}

		private function readDict(objInfo : int, offset : int) : * {
			var length : int = objInfo;
			var dictOffset : int = 1;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				dictOffset = 2 + intLength;
				length = readUnsignedInt(readBytes(_data, offset + 2, intLength));
			}
			var dict : Object = new Object();
			var keyRef : int;
			var valRef : int;
			for (var i : int = 0; i < length; i++) {
				keyRef = readUnsignedInt(readBytes(_data, offset + dictOffset + i * _objectRefSize, _objectRefSize));
				valRef = readUnsignedInt(readBytes(_data, offset + dictOffset + (length * _objectRefSize) + i * _objectRefSize, _objectRefSize));
				var key : * = readObject(keyRef);
				var val : *= readObject(valRef);
				dict[key] = val;
			}
			return dict;
		}

		private function readUnsignedInt(value : ByteArray) : int {
			var len : int = 0;
			for (var i : int = 0;i < value.length;i++) {
				len <<= 8;
				len |= value[i] & 0xFF;
			}
			return len;
		}

		private function readBytes(src : ByteArray, startIndex : int, length : int) : ByteArray {
			var dest : ByteArray = new ByteArray();
			src.position = startIndex;
			src.readBytes(dest, 0, length);
			return dest;
		}

		public function GPlistDecoder() {
		}

		public function decode(data : ByteArray) : void {
			_data = data;
			var sig : String = _data.readUTFBytes(6);
			if (sig != "bplist") {
				return;
			}
			var trailer : ByteArray = readBytes(_data, _data.length - 32, 32);
			_offsetSize = readUnsignedInt(readBytes(trailer, 6, 1));
			_objectRefSize = readUnsignedInt(readBytes(trailer, 7, 1));
			_numObjects = readUnsignedInt(readBytes(trailer, 8, 8));
			_topObject = readUnsignedInt(readBytes(trailer, 16, 8));
			_tableOffset = readUnsignedInt(readBytes(trailer, 24, 8));
			_offsetTable = new Array();
			for (var i : int = 0; i < _numObjects; i++) {
				_offsetTable[i] = readUnsignedInt(readBytes(_data, _tableOffset + i * _offsetSize, _offsetSize));
			}
			_plistObj = readObject(_topObject);
		}

		public function get plistObj() : Object {
			return _plistObj;
		}

		public function dispose() : void {
			_plistObj = null;
		}
	}
}