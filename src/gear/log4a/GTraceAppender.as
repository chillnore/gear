package gear.log4a {
	/**
	 * trace日志输入源
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GTraceAppender extends GAppender {
		public function GTraceAppender() {
			super();
			_formatter = new GSimpleLogFormatter();
		}

		/**
		 * @inheritDoc
		 */
		override public function append(data : GLogData) : void {
			var message : String = _formatter.format(data, "");
			trace(message);
		}
	}
}