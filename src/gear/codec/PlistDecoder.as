package gear.codec {
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;

	/**
	 * plist文件解码
	 * 
	 * @author bright
	 * @version 20121025
	 */
	public class PlistDecoder {
		private var _data : ByteArray;
		private var _offsetSize : int;
		private var _objectRefSize : int;
		private var _numObjects : int;
		private var _topObject : int;
		private var _tableOffset : int;
		private var _offsetTable : Array;
		private var _plistObj : Object;

		private function parseObject(obj : int) : * {
			var offset : int = _offsetTable[obj];
			var type : int = _data[offset];
			// First 4 bits
			var objType : int = (type & 0xF0) >> 4;
			// Second 4 bits
			var objInfo : int = (type & 0x0F);
			// primitive
			if (objType == 0x0) {
				return parsePrimitive(objInfo);
			}
			// integer
			if (objType == 0x1) {
				return parseInt(objInfo, offset);
			}
			// Number
			if (objType == 0x2) {
				return parseNumber(objInfo, offset);
			}
			// Date
			if (objType == 0x3) {
				return parseDate(objInfo, offset);
			}
			// Data
			if (objType == 0x4) {
				return parseData(objInfo, offset);
			}
			// ascii
			if (objType == 0x5) {
				return parseAscii(objInfo, offset);
			}
			// Array
			if (objType == 0xA) {
				return parseArray(objInfo, offset);
			}
			// Dictionary
			if (objType == 0xD) {
				return parseDict(objInfo, offset);
			}
			GLogger.error("Unknown object type:" + objType);
		}

		private function parsePrimitive(objInfo : int) : * {
			if (objInfo == 0x8) {
				return false;
			}
			if (objInfo == 0x9) {
				return true;
			}
			return null;
		}

		private function parseInt(objInfo : int, offset : int) : * {
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

		private function parseNumber(objInfo : int, offset : int) : * {
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

		private function parseDate(objInfo : int, offset : int) : * {
			if (objInfo != 0x3) {
				return null;
			}
			_data.position = offset + 1;
			var time : Number = _data.readDouble();
			var date : Date = new Date((time + 0x3A4FC880) * 1000);
			return date;
		}

		private function parseData(objInfo : int, offset : int) : * {
			var dataOffset : int = 1;
			var length : int = objInfo;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				dataOffset = 2 + intLength;
				length = parseUnsignedInt(getBytes(_data, offset + 2, intLength));
			}
			if (intLength < 1) {
				return null;
			}
			var bytes : ByteArray = new ByteArray();
			_data.position = offset + 2;
			_data.readBytes(bytes, 0, intLength);
			return bytes;
		}

		private function parseAscii(objInfo : int, offset : int) : * {
			var length : int = objInfo;
			var strOffset : int = 1;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				strOffset = 2 + intLength;
				length = parseUnsignedInt(getBytes(_data, offset + 2, intLength));
			}
			_data.position = offset + strOffset;
			return _data.readUTFBytes(length);
		}

		private function parseArray(objInfo : int, offset : int) : * {
			var length : int = objInfo;
			var arrayOffset : int = 1;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				arrayOffset = 2 + intLength;
				length = parseUnsignedInt(getBytes(_data, offset + 2, intLength));
			}
			var array : Array = new Array();
			var objRef : int;
			for (var i : int = 0;i < length;i++) {
				objRef = parseUnsignedInt(getBytes(_data, offset + arrayOffset + i * _objectRefSize, _objectRefSize));
				array[i] = parseObject(objRef);
			}
			return array;
		}

		private function parseDict(objInfo : int, offset : int) : * {
			var length : int = objInfo;
			var dictOffset : int = 1;
			if (objInfo == 0xF) {
				var int_type : int = _data[offset + 1];
				var intInfo : int = int_type & 0x0F;
				var intLength : int = Math.pow(2, intInfo);
				dictOffset = 2 + intLength;
				length = parseUnsignedInt(getBytes(_data, offset + 2, intLength));
			}
			var dict : Object = new Object();
			var keyRef : int;
			var valRef : int;
			for (var i : int = 0; i < length; i++) {
				keyRef = parseUnsignedInt(getBytes(_data, offset + dictOffset + i * _objectRefSize, _objectRefSize));
				valRef = parseUnsignedInt(getBytes(_data, offset + dictOffset + (length * _objectRefSize) + i * _objectRefSize, _objectRefSize));
				var key : * = parseObject(keyRef);
				var val : *= parseObject(valRef);
				dict[key] = val;
			}
			return dict;
		}

		private function parseUnsignedInt(value : ByteArray) : int {
			var len : int = 0;
			for (var i : int = 0;i < value.length;i++) {
				len <<= 8;
				len |= value[i] & 0xFF;
			}
			return len;
		}

		private function getBytes(src : ByteArray, startIndex : int, length : int) : ByteArray {
			var dest : ByteArray = new ByteArray();
			src.position = startIndex;
			src.readBytes(dest, 0, length);
			return dest;
		}

		public function parse(data : ByteArray) : void {
			_data = data;
			var magic : String = _data.readUTFBytes(6);
			if (magic != "bplist") {
				return;
			}
			var trailer : ByteArray = getBytes(_data, _data.length - 32, 32);
			_offsetSize = parseUnsignedInt(getBytes(trailer, 6, 1));
			_objectRefSize = parseUnsignedInt(getBytes(trailer, 7, 1));
			_numObjects = parseUnsignedInt(getBytes(trailer, 8, 8));
			_topObject = parseUnsignedInt(getBytes(trailer, 16, 8));
			_tableOffset = parseUnsignedInt(getBytes(trailer, 24, 8));
			_offsetTable = new Array();
			for (var i : int = 0; i < _numObjects; i++) {
				_offsetTable[i] = parseUnsignedInt(getBytes(_data, _tableOffset + i * _offsetSize, _offsetSize));
			}
			_plistObj = parseObject(_topObject);
		}

		public function get plistObj() : Object {
			return _plistObj;
		}
	}
}