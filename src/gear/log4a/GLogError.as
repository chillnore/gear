package gear.log4a {
	import gear.utils.GStringUtil;
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
			super(GStringUtil.toString(log));
			GLogger.error(log);
		}
	}
}