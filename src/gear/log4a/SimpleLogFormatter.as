package gear.log4a {
	/**
	 * 简单日志格式化
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class SimpleLogFormatter implements ILogFormatter {
		public function SimpleLogFormatter() {
		}

		/**
		 * @inheritDoc
		 */
		public function format(data : GLoggingData, separator : String = "\n"):String {
			var result : String = "[" + data.level.name + "]";
			result += data.toString() + separator;
			return result;
		}
	}
}