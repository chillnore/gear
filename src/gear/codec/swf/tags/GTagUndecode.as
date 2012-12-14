package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	import flash.utils.ByteArray;

	/**
	 * @author bright
	 */
	public class GTagUndecode implements IGSwfTag {
		protected var _type : int;
		protected var _data : ByteArray;

		public function GTagUndecode(type : int) {
			_type = type;
			
		}

		public function decode(data : GSwfStream, length : uint) : void {
			_data = new ByteArray();
			data.readBytes(_data, length);
		}
	}
}
