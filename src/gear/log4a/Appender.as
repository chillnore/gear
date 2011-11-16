package gear.log4a {
	/**
	 * 日志输出源抽象类 
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class Appender implements IAppender {
		/**
		 * @private
		 */
		protected var _formatter : ILogFormatter;

		public function Appender() {
		}

		/**
		 * @inheritDoc
		 */
		public function append(data : LoggingData) : void {
			data;
			throw new LogError("You muse override append");
		}
	}
}