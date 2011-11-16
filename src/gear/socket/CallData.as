package gear.socket {
	import gear.log4a.GLogger;

	/**
	 * 反射数据类
	 * 
	 * @author bright
	 * @version 20111111
	 */
	public class CallData {
		private var _method : String;
		private var _args : Array;

		/**
		 * CallData 
		 * 
		 * @param method String 方法名
		 * @param args Array 参数数组
		 */
		public function CallData(method : String, args : Array) {
			_method = method;
			_args = args;
		}

		public function get method() : String {
			return _method;
		}

		public function get args() : Array {
			return _args;
		}

		public function toString() : String {
			return "method=" + _method;
		}

		/**
		 * 获得从Object中解析成的CallData
		 * 
		 * @param value Object
		 * @return ect中解析成的CallData
		 * 
		 */
		public static function parse(value : Object) : CallData {
			if (value == null) {
				GLogger.warn("CallData.parse:value=null");
				return null;
			}
			if (value.hasOwnProperty("method")) {
				if (value.method == null) {
					GLogger.warn("CallData.parse:method=null");
					return null;
				}
				var data : CallData = new CallData(value.method, value.args);
				return data;
			} else {
				GLogger.warn("CallData.parse:nosuch method");
				return null;
			}
		}
	}
}
