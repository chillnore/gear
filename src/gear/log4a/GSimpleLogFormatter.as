package gear.log4a {
	import gear.utils.GStringUtil;
	/**
	 * 简单日志格式化
	 * 
	 * @author bright
	 * @version 20130116
	 */
	public final class GSimpleLogFormatter implements IGLogFormatter {
		public function GSimpleLogFormatter() {
		}

		public function format(data : GLogData, separator : String = "\n") : String {
			var result : String = "["+GStringUtil.formatTime(data.timestamp)+"][" + data.level.name + "]";
			result +=  data.toString() + separator;
			return result;
		}
	}
}