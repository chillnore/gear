package gear.codec.gpk {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import gear.codec.gpk.tag.AGpkTag;
	import gear.codec.gpk.tag.GpkTagFactory;
	import gear.gui.bd.GBDList;
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;


	/**
	 * Gpk 资源包
	 * 
	 * @author bright
	 * @version 20121219
	 */
	public final class Gpk {
		private var _magic : String;
		private var _version : int;
		private var _output : ByteArray;
		private var _input : ByteArray;
		private var _tags : Vector.<AGpkTag>;
		private var _total : int;
		private var _count : int;
		private var _onFinish : Function;
		private var _content : Dictionary;

		private function encodeHeader() : void {
			_output.writeUTFBytes("gpk");
			_output.writeByte(_version);
		}

		private function decodeHeader() : void {
			var magic : String = _input.readUTFBytes(3);
			if (magic != _magic) {
				throw new GLogError("无效的文件头");
			}
			_version = _input.readByte();
		}

		private function encodeTags() : void {
			_output.writeShort(_tags.length);
			for each (var tag:AGpkTag in _tags) {
				tag.encode(_output);
			}
		}

		private function decodeTags() : void {
			_total = _input.readUnsignedShort();
			_count = 0;
			var tagType : String;
			var tagSize : uint;
			var tag : AGpkTag;
			var end : int;
			for (var i : int = 0;i < _total;i++) {
				tagType = _input.readUTF();
				tagSize = _input.readUnsignedInt();
				end = _input.position + tagSize;
				tag = GpkTagFactory.create(tagType);
				tag.decode(_input, onTagFinish);
				if (_input.position != end) {
					GLogger.warn("解码标签长度不匹配!标签类型=" + tagType + ",当前位置=" + _input.position + ",结束位置=" + end);
					_input.position = end;
				}
			}
			_input.clear();
		}

		private function onTagFinish(tag : AGpkTag) : void {
			addTag(tag);
			tag.addTo(_content);
			if (++_count<_total) {
				return;
			}
			if (_onFinish == null) {
				return;
			}
			try {
				_onFinish();
			} catch(e : Error) {
				GLogger.debug(e.getStackTrace());
			}
		}

		public function Gpk() {
			_magic = "gpk";
			_version = 1;
			_output = new ByteArray();
			_tags = new Vector.<AGpkTag>();
			_content = new Dictionary();
		}

		public function decode(input : ByteArray, onFinish : Function) : void {
			_input = input;
			_onFinish = onFinish;
			decodeHeader();
			decodeTags();
		}

		public function encode() : void {
			_output.clear();
			encodeHeader();
			encodeTags();
		}

		public function get output() : ByteArray {
			return _output;
		}

		public function addTag(value : AGpkTag) : void {
			_tags.push(value);
		}
		
		public function getTag(key:String):AGpkTag{
			for each(var tag:AGpkTag in _tags){
				if(tag.key==key){
					return tag;
				}
			}
			return null;
		}
		
		public function getAMF(key : String) : * {
			return _content[key];
		}
		
		public function getSBD(key : String) :BitmapData{
			return _content[key] as BitmapData;
		}

		public function getLBD(key : String) : GBDList {
			return _content[key] as GBDList;
		}
	}
}
