package gear.log4a {
	/**
	 * 日志
	 * 
	 * @author bright
	 * @version 20121025
	 * @example
	 * <listing version="3.0"> 
	 * GLogger使用示例:
	 * GLogger.addAppender(new TraceAppender());
	 * GLogger.setLevel(Level.INFO);
	 * GLogger.debug("this is a debug!");
	 * GLogger.info("this is a info!");
	 * GLogger.warn("this is a warn!");
	 * GLogger.error("this is a error!");
	 * GLogger.fatal("this is a fatal!");
	 * </listing> 
	 */
	public final class GLogger {
		private static var _appenders : Array;
		private static var _level : GLevel = GLevel.ALL_LEVEL;
		private static var _creating : Boolean = false;

		/**
		 * @private
		 * @param level 日志层级
		 * @param message 消息数组
		 */
		private static function forcedLog(level : GLevel, message : Array) : void {
			if (level.compareTo(GLogger._level)) {
				return;
			}
			GLogger.callAppenders(new GLoggingData(level, message));
		}

		private static function callAppenders(event : GLoggingData) : void {
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
		public static function setLevel(level : GLevel) : void {
			GLogger._level = level;
		}

		/**
		 * 加入日志输出源
		 * 
		 * @param appender 日志输出源接口
		 */
		public static function addAppender(appender : IAppender) :void {
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
			GLogger.forcedLog(GLevel.FATAL_LEVEL, message);
		}

		/**
		 * 输出错误消息
		 * 
		 * @param message 消息数组
		 */
		public static function error(...message : Array) : void {
			GLogger.forcedLog(GLevel.ERROR_LEVEL, message);
		}

		/**
		 * 输出警告消息
		 * 
		 * @param message 消息数组
		 */
		public static function warn(...message : Array) : void {
			GLogger.forcedLog(GLevel.WARN_LEVEL, message);
		}

		/**
		 * 输出信息消息
		 * 
		 * @param message 消息数组
		 */
		public static function info(...message : Array) : void {
			GLogger.forcedLog(GLevel.INFO_LEVEL, message);
		}

		/**
		 * 输出调试消息
		 * 
		 * @param message 消息数组
		 */
		public static function debug(...message : Array) : void {
			GLogger.forcedLog(GLevel.DEBUG_LEVEL, message);
		}
	}
}