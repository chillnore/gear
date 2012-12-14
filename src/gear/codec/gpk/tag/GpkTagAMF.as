package gear.codec.gpk.tag {
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @author bright
	 * @version 20121225
	 */
	public final class GpkTagAMF extends AGpkTag {
		public static const TYPE : String = "amf";
		private var _ba : ByteArray;
		private var _content : *;

		public function GpkTagAMF(key : String = "none", content : *=null) {
			_key = key;
			_ba = new ByteArray();
			if (content != null) {
				_ba.writeObject(content);
				_ba.compress();
			}
		}

		override public function encode(output : ByteArray) : void {
			output.writeUTF(TYPE);
			var start : int = output.position;
			output.writeUnsignedInt(0);
			output.writeUTF(_key);
			output.writeUnsignedInt(_ba.length);
			output.writeBytes(_ba);
			var end : int = output.position;
			output.position = start;
			output.writeUnsignedInt(end - start - 4);
			output.position = end;
		}

		override public function decode(input : ByteArray, onComplete : Function) : void {
			_onComplete = onComplete;
			_key = input.readUTF();
			var size : uint = input.readUnsignedInt();
			if (size > 0) {
				var ba : ByteArray = new ByteArray();
				input.readBytes(ba, 0, size);
				try {
					ba.uncompress();
					_content = ba.readObject();
					ba.clear();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
			complete();
		}

		override public function addTo(content : Dictionary) : void {
			content[key] = _content;
		}
	}
}
