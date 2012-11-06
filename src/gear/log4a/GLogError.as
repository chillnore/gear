package gear.log4a {
	/**
	 * 日志错误类
	 * 
	 * @author bright
	 * @version 20101012
	 * @example
	 * throw new LogError("System Error");
	 */
	public class GLogError extends Error {
		public function GLogError(...log : Array) {
			super(GLoggingData.toCode(log));
			GLogger.error(log);
		}
	}
}