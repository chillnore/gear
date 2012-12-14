package gear.codec.swf.data.shape {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GSwfGradient {
		protected var _spreadMode : int;
		protected var _interpolationMode : int;
		protected var _gradRecords : Vector.<GSwfGradRecord>;

		public function GSwfGradient() {
		}

		public function decode(data : GSwfStream, level : int) : void {
			/**
			 * 0 = Pad mode
			 * 1 = Reflect mode
			 * 2 = Repeat mode
			 * 3 = Reserved
			 */
			_spreadMode = data.readUB(2);
			_interpolationMode = data.readUB(2);
			var numGradients : int = data.readUB(4);
			_gradRecords = new Vector.<GSwfGradRecord>(numGradients);
			var gradRecord : GSwfGradRecord;
			for (var i : int = 0;i < numGradients;i++) {
				gradRecord = new GSwfGradRecord();
				gradRecord.decode(data, level);
				_gradRecords[i] = gradRecord;
			}
		}
	}
}
