package gear.log4a {
	/**
	 * 日志输出源抽象类 
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GAppender implements IAppender {
		/**
		 * @private
		 */
		protected var _formatter : ILogFormatter;

		public function GAppender() {
		}

		/**
		 * @inheritDoc
		 */
		public function append(data : GLoggingData) : void {
			data;
			throw new GLogError("You muse override append");
		}
	}
}