package gear.codec.xlsx {
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 对Zip文件进行解码
	 * 
	 * @author bright
	 * @version 20120409
	 */
	public class GZipDecoder {
		private var _data : ByteArray;
		private var _uncompressSize : uint;
		private var _fileList : Object;
		private var _fileInflateMark : Object;

		private function parse() : void {
			if (_data == null) {
				return;
			}
			_data.endian = Endian.LITTLE_ENDIAN;
			_data.position = 0;
			while (true) {
				var headValue : int = _data.readUnsignedInt();
				if (headValue != 0x04034b50) {
					break;
				}
				_data.position = _data.position + 14;
				var compressSize : uint = _data.readUnsignedInt();
				_uncompressSize = _data.readUnsignedInt();
				var fileNameLength : int = _data.readUnsignedShort();
				var otherLength : int = _data.readUnsignedShort();
				var fileName : String = _data.readUTFBytes(fileNameLength);
				_data.position = _data.position + otherLength;
				var fileByteArray : ByteArray = new ByteArray();
				_data.readBytes(fileByteArray, 0, compressSize);
				_fileList[fileName] = fileByteArray;
			}
		}

		/**
		 * @param zipFile zip文件的二进制数据
		 * 
		 */
		public function GZipDecoder() {
		}

		/**
		 * 增加文件到zip实例，此方法为new Zip(zipFile)的替代方法。
		 * 如果多次调用此方法,zipFile中相同文件名的文件将被复盖
		 * @param zipFile zip文件的二进制数据
		 */
		public function addZipFile(zipFile : ByteArray) : void {
			_data = zipFile;
			_fileList = {};
			_fileInflateMark = {};
			parse();
		}

		/**
		 * 通过文件名取得解压缩后的文件的二进制数据
		 * @param fileName 文件名
		 * @return 文件的二进制数据
		 */
		public function getFile(fileName : String) : ByteArray {
			var byteArray : ByteArray = _fileList[fileName];
			if (byteArray == null) {
				return null;
			}
			if (_fileInflateMark[fileName] != true) {
				byteArray.position = 0;
				byteArray.inflate();
				_fileInflateMark[fileName] = true;
			}
			return byteArray;
		}

		/**
		 * 取得zip中的文件名的列表
		 * @return 
		 */
		public function getFileNameList() : Array {
			var fileNameList : Array = [];
			for (var name:String in _fileList) {
				fileNameList.push(name);
			}
			return fileNameList;
		}
	}
}