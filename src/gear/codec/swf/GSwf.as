package gear.codec.swf {
	import gear.codec.swf.tags.GTagUndecode;
	import gear.codec.swf.data.GSwfRect;
	import gear.codec.swf.tags.GTagFactory;
	import gear.codec.swf.tags.IGSwfTag;
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;

	/**
	 * Swf格式
	 * 
	 * @author bright
	 * @version 20121120
	 */
	public final class GSwf {
		public static const ZLIB : int = 0;
		public static const LZMA : int = 1;
		public static const NONE : int = 2;
		public var signature : String;
		public var compressType : int;
		public var version : int;
		public var fileLength : uint;
		public var frameSize : GSwfRect;
		public var frameRate : Number;
		public var frameCount : int;
		private var _input : GSwfStream;
		private var _filters : Vector.<int>;

		private function decodeHeader() : void {
			var signatureByte : int = _input.readUI8();
			if (signatureByte == 0x43) {
				compressType = GSwf.ZLIB;
			} else if (signatureByte == 0x5A) {
				compressType = GSwf.LZMA;
			} else if (signatureByte == 0x46) {
				compressType = GSwf.NONE;
			} else {
				throw new GLogError("无效的SWF文件头");
			}
			signatureByte = _input.readUI8();
			if (signatureByte != 0x57) {
				throw new GLogError("无效的SWF文件头");
			}
			signatureByte = _input.readUI8();
			if (signatureByte != 0x53) {
				throw new GLogError("无效的SWF文件头");
			}
			version = _input.readUI8();
			fileLength = _input.readUI32();
			_input.uncompress(compressType, fileLength);
			frameSize = _input.readRECT();
			frameRate = _input.readFIXED8();
			frameCount = _input.readUI16();
		}
		
		/**
		 * 如果Swf标签被过滤将不进行解码
		 */
		private function decodeTags() : void {
			var tagTypeAndLength : int;
			var tagLength : int;
			var tagType : int = -1;
			var tag : IGSwfTag;
			var end : int;
			while (tagType != 0) {
				tagTypeAndLength = _input.readUI16();
				tagLength = tagTypeAndLength & 0x3f;
				if (tagLength == 0x3f) {
					tagLength = _input.readSI32();
				}
				tagType = tagTypeAndLength >> 6;
				end = _input.position + tagLength;
				if (_filters.indexOf(tagType) != -1) {
					tag = new GTagUndecode(tagType);
					tag.decode(_input, tagLength);
				} else {
					tag = GTagFactory.create(tagType);
					if (tag != null) {
						tag.decode(_input, tagLength);
					} else {
						GLogger.warn("未解码的Swf标签类型:" + tagType);
					}
				}
				if (_input.position != end) {
					GLogger.warn("解码标签长度不匹配!标签类型=" + tagType + ",当前位置=" + _input.position + ",结束位置=" + end);
					_input.position = end;
				}
			}
		}

		public function GSwf() {
			_input = new GSwfStream();
			_filters = new Vector.<int>();
		}

		public function decode(value : ByteArray) : void {
			_input.data = value;
			decodeHeader();
			decodeTags();
		}
	}
}
