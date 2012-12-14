package gear.codec.swf.data.action {
	import gear.codec.swf.GSwfStream;
	import gear.codec.swf.data.GSwfEventFlags;

	/**
	 * @author bright
	 */
	public class GSwfClipActions {
		protected var _eventFlags : GSwfEventFlags;
		protected var _records : Vector.<GSwfClipActionRecord>;

		public function GSwfClipActions() {
			_records = new Vector.<GSwfClipActionRecord>();
		}

		public function decode(data : GSwfStream) : void {
			// 保留2字节
			data.readUI16();
			_eventFlags = new GSwfEventFlags();
			_eventFlags.decode(data);
			var end : int;
			var endFlag : uint;
			var record : GSwfClipActionRecord;
			while (true) {
				end = data.position;
				// version>=6 UI32 <=5 UI16
				endFlag = data.readUI32();
				if (endFlag == 0) {
					data.position = end;
					break;
				}
				record = new GSwfClipActionRecord();
				record.decode(data);
				_records.push(record);
			}
		}
	}
}
