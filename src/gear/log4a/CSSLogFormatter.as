package gear.log4a {
	/**
	 * 样式表日志格式化
	 * 
	 * @author bright
	 * @version 20101009
	 */
	public class CSSLogFormatter implements ILogFormatter {
		/**
		 * 日志层级样式表
		 */
		public static const cssText : String = ".debug{color:#33FF00}.info{color:#EFEFEF}.warn{color:#00CCFF}.error{color:#FF9900}.fatal{color:#FF66FF}";

		public function CSSLogFormatter() {
		}

		/**
		 * @inheritDoc
		 */
		public function format(data : GLoggingData, separator : String = "\n") : String {
			var result : String = "<p class='" + data.level.name.toLowerCase() + "'>[" + data.level.name + "]";
			result += data.toString() + "</p>";
			return result;
		}
	}
}
