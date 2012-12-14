package gear.codec.swf.data.action {
	import gear.codec.swf.GSwfStream;
	import gear.codec.swf.data.GSwfEventFlags;

	/**
	 * @author bright
	 */
	public class GSwfClipActionRecord {
		protected var _eventFlags : GSwfEventFlags;
		protected var _keyCode : int;

		public function GSwfClipActionRecord() {
		}


		public function decode(data : GSwfStream) : void {
			_eventFlags = new GSwfEventFlags();
			_eventFlags.decode(data);
			var size : int = data.readUI32();
			size;
			if (_eventFlags.eventKeyPress) {
				_keyCode = data.readUI8();
			}
			var actionCode : uint = data.readUI8();
			if (actionCode != 0) {
				var actionLength : uint = (actionCode >= 0x80) ? data.readUI16() : 0;
				actionLength;
			}
		}
	}
}
