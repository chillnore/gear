package gear.log4a {
	import flash.utils.getQualifiedClassName;

	/**
	 * 日志数据
	 * 
	 * @author bright
	 * @version 20121224
	 */
	public final class GLoggingData {
		private var _level : GLevel;
		private var _message : Array;
		private var _code : String;

		private static function vectorToString(target :Vector.<*>) : String {
			var code : String = "";
			var len : int = target.length;
			for (var i : int = 0;i < len;i++) {
				if (i > 0) {
					code += ",";
				}
				code += encode(target[i]);
			}
			return "[" + code + "]";
		}

		private static function arrayToString(target : Array) : String {
			var code : String = "";
			var len : int = target.length;
			for (var i : int = 0;i < len;i++) {
				if (i > 0) {
					code += ",";
				}
				code += encode(target[i]);
			}
			return "[" + code + "]";
		}

		private static function objectToString(target : Object) : String {
			var code : String = "";
			var name : String = getQualifiedClassName(target);
			var className : String = name.split("::").pop();
			if (className.indexOf("Vector") != -1) {
				return "[" + target.toString() + "]";
			}
			if (className == "Object") {
				var value : Object;
				for (var key:String in target) {
					value = target[key];
					if (value is Function) {
						continue;
					}
					if (code.length > 0) {
						code += ",";
					}
					code += key + ":" + GLoggingData.encode(value);
				}
			} else {
				return "<" + name + ">";
			}
			return "{" + code + "}";
		}

		private static function encode(target : *) : String {
			if (target == null) {
				return "null";
			}
			if (target is String) {
				return "\"" + target + "\"";
			}
			if (target is Number) {
				if (isNaN(target)) {
					return "NaN";
				} else {
					return String(target);
				}
			}
			if (target is Array) {
				return arrayToString(target);
			}
			if (target is Vector.<*>) {
				return vectorToString(target);
			}
			var name : String = getQualifiedClassName(target).split("::").pop();
			if (name != "Object") {
				if (target.toString is Function) {
					return target.toString();
				} else {
					return "[" + name + "]";
				}
			} else {
				return objectToString(target);
			}
		}

		/**
		 * @param level Level 日志层级
		 * @param message Array 消息数组
		 */
		public function GLoggingData(level : GLevel, message : Array) {
			_level = level;
			_message = message;
		}

		public function get level() : GLevel {
			return _level;
		}

		public function get message() : Array {
			return _message;
		}

		public static function toCode(target : Array) : String {
			var result : String = "null";
			if (target != null) {
				result = "";
				for each (var item:* in target) {
					if (result.length > 0) {
						result += " ";
					}
					result += GLoggingData.encode(item);
				}
			}
			return result;
		}

		public function toString() : String {
			if (_code == null) {
				_code = GLoggingData.toCode(_message);
			}
			return _code;
		}
	}
}