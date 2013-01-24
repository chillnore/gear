package gear.log4a {
	/**
	 * 日志输出源抽象类 
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GAppender implements IGAppender {
		/**
		 * @private
		 */
		protected var _formatter : IGLogFormatter;

		public function GAppender() {
		}

		/**
		 * @inheritDoc
		 */
		public function append(data : GLogData) : void {
			data;
			throw new GLogError("You muse override append");
		}
	}
}