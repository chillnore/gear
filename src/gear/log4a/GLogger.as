package gear.log4a {
	import flash.utils.getQualifiedClassName;

	/**
	 * 日志
	 * 
	 * @author bright
	 * @version 20130325
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
		private static var _appenders : Vector.<IGAppender>;
		private static var _level : GLevel = GLevel.ALL_LEVEL;
		private static var _creating : Boolean = false;

		/**
		 * @private
		 * @param level 日志层级
		 * @param message 消息数组
		 */
		private static function forcedLog(level : GLevel, message : Array) : void {
			if (level.compareTo(_level)) {
				return;
			}
			var caller:String=new Error().getStackTrace().split("at ")[3].split("(")[0].split("/")[0];
			callAppenders(new GLogData(level, message,caller));
		}

		private static function callAppenders(event : GLogData) : void {
			for each (var appender : IGAppender in _appenders) {
				appender.append(event);
			}
		}

		/**
		 * Logger 日志
		 * 
		 * @throws Error 不能实例化
		 */
		public function GLogger() {
			if (!_creating) {
				throw(new Error(this, "GLogger不能实例化"));
			}
		}

		/**
		 * 设置输出层级
		 * 
		 * @param level 层级
		 */
		public static function setLevel(level : GLevel) : void {
			_level = level;
		}

		/**
		 * 加入日志输出源
		 * 
		 * @param appender 日志输出源接口
		 */
		public static function addAppender(appender : IGAppender) : void {
			if (_appenders == null) {
				_appenders = new Vector.<IGAppender>();
			}
			var name : String = getQualifiedClassName(appender);
			var found : Boolean = false;
			for each (var target : IGAppender in _appenders) {
				if (getQualifiedClassName(target) == name) {
					found = true;
					break;
				}
			}
			if (!found) {
				_appenders.push(appender);
			}
		}

		/**
		 * 输出致命消息
		 * 
		 * @param message 消息数组
		 */
		public static function fatal(...message : Array) : void {
			forcedLog(GLevel.FATAL_LEVEL, message);
		}

		/**
		 * 输出错误消息
		 * 
		 * @param message 消息数组
		 */
		public static function error(...message : Array) : void {
			forcedLog(GLevel.ERROR_LEVEL, message);
		}

		/**
		 * 输出警告消息
		 * 
		 * @param message 消息数组
		 */
		public static function warn(...message : Array) : void {
			forcedLog(GLevel.WARN_LEVEL, message);
		}

		/**
		 * 输出信息消息
		 * 
		 * @param message 消息数组
		 */
		public static function info(...message : Array) : void {
			forcedLog(GLevel.INFO_LEVEL, message);
		}

		/**
		 * 输出调试消息
		 * 
		 * @param message 消息数组
		 */
		public static function debug(...message : Array) : void {
			forcedLog(GLevel.DEBUG_LEVEL, message);
		}
	}
}