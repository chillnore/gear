package gear.log4a {
	/**
	 * 日志
	 * 
	 * @author bright
	 * @version 20110923
	 * @example
	 * <listing version="3.0"> Logger使用示例:
	 * Logger.addAppender(new TraceAppender());
	 * Logger.setLevel(Level.INFO);
	 * Logger.debug("this is a debug!");
	 * Logger.info("this is a info!");
	 * Logger.warn("this is a warn!");
	 * Logger.error("this is a error!");
	 * Logger.fatal("this is a fatal!");
	 * </listing> 
	 */
	public final class GLogger {
		private static var _appenders : Array;
		private static var _level : Level = Level.ALL_LEVEL;
		private static var _creating : Boolean = false;

		/**
		 * @private
		 * @param level 日志层级
		 * @param message 消息数组
		 */
		private static function forcedLog(level : Level, message : Array) : void {
			if (level.compareTo(GLogger._level)) {
				return;
			}
			GLogger.callAppenders(new LoggingData(level, message));
		}

		private static function callAppenders(event : LoggingData) : void {
			for each (var appender:IAppender in GLogger._appenders) {
				appender.append(event);
			}
		}

		/**
		 * Logger 日志
		 * 
		 * @throws Error 不能实例化
		 */
		public function GLogger() {
			if (!GLogger._creating) {
				throw(new Error(this, "Logger cannot be instantiated."));
			}
		}

		/**
		 * 设置输出层级
		 * 
		 * @param level 层级
		 */
		public static function setLevel(level : Level) : void {
			GLogger._level = level;
		}

		/**
		 * 加入日志输出源
		 * 
		 * @param appender 日志输出源接口
		 */
		public static function addAppender(appender : IAppender) : void {
			if (GLogger._appenders == null) {
				GLogger._appenders = new Array();
			}
			if (GLogger._appenders.indexOf(appender) == -1) {
				GLogger._appenders.push(appender);
			}
		}

		/**
		 * 输出致命消息
		 * 
		 * @param message 消息数组
		 */
		public static function fatal(...message : Array) : void {
			GLogger.forcedLog(Level.FATAL_LEVEL, message);
		}

		/**
		 * 输出错误消息
		 * 
		 * @param message 消息数组
		 */
		public static function error(...message : Array) : void {
			GLogger.forcedLog(Level.ERROR_LEVEL, message);
		}

		/**
		 * 输出警告消息
		 * 
		 * @param message 消息数组
		 */
		public static function warn(...message : Array) : void {
			GLogger.forcedLog(Level.WARN_LEVEL, message);
		}

		/**
		 * 输出信息消息
		 * 
		 * @param message 消息数组
		 */
		public static function info(...message : Array) : void {
			GLogger.forcedLog(Level.INFO_LEVEL, message);
		}

		/**
		 * 输出调试消息
		 * 
		 * @param message 消息数组
		 */
		public static function debug(...message : Array) : void {
			GLogger.forcedLog(Level.DEBUG_LEVEL, message);
		}
	}
}