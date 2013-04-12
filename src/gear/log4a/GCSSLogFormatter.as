package gear.log4a {
	import gear.utils.GStringUtil;

	import flash.text.StyleSheet;

	/**
	 * 样式表日志格式化
	 * 
	 * @author bright
	 * @version 20130116
	 */
	public class GCSSLogFormatter implements IGLogFormatter {
		protected var _styleSheet : StyleSheet;

		public function GCSSLogFormatter() {
			_styleSheet = new StyleSheet();
			_styleSheet.parseCSS(".debug{color:#007F33}.info{color:#333333}.warn{color:#00667F}.error{color:#996600}.fatal{color:#7F007F}");
		}

		public function get styleSheet() : StyleSheet {
			return _styleSheet;
		}

		/**
		 * @inheritDoc
		 */
		public function format(data : GLogData, separator : String = "\n") : String {
			var result : String = "<p class='" + data.level.name.toLowerCase() + "'>[" + GStringUtil.formatTime(data.timestamp) + "][" + data.level.name + "]";
			if (data.caller != null) {
				result += "{" + data.caller + "} ";
			}
			result += data.toString().replace(/\n/g, "<br>") + "</p>";
			return result;
		}
	}
}
