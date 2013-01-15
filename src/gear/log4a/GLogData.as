package gear.log4a {
	import gear.utils.GStringUtil;

	/**
	 * 日志数据
	 * 
	 * @author bright
	 * @version 20130106
	 */
	public final class GLogData {
		private var _level : GLevel;
		private var _message : Array;
		private var _code : String;

		protected function format(target : Array) : String {
			if (target == null || target.length < 1) {
				return "null";
			}
			if (target[0] is String && GStringUtil.hasFormat(target[0])) {
				return GStringUtil.format.apply(null,target);
			}
			var result : String = "";
			for each (var item:* in target) {
				if (result.length > 0) {
					result += " ";
				}
				result += GStringUtil.toString(item);
			}

			return result;
		}

		/**
		 */
		public function GLogData(level : GLevel, message : Array) {
			_level = level;
			_message = message;
			_code = format(_message);
		}

		public function get level() : GLevel {
			return _level;
		}

		public function get message() : Array {
			return _message;
		}

		public function toString() : String {
			return _code;
		}
	}
}