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
			_formatter = new SimpleLogFormatter();
		}

		/**
		 * @inheritDoc
		 */
		override public function append(data : GLoggingData) : void {
			var message : String = _formatter.format(data, "");
			trace(message);
		}
	}
}