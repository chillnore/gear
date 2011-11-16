package gear.log4a {
	/**
	 * 日志错误类
	 * 
	 * @author bright
	 * @version 20101012
	 * @example
	 * throw new LogError("System Error");
	 */
	public class LogError extends Error {
		public function LogError(...log : Array) {
			super(LoggingData.toCode(log));
			GLogger.error(log);
		}
	}
}