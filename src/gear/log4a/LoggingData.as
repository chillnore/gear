package gear.log4a {
	import flash.utils.describeType;

	/**
	 * 日志数据
	 * 
	 * @author bright
	 * @version 20101009
	 */
	public final class LoggingData {
		private var _level : Level;
		private var _message : Array;
		private var _timeStamp : String;
		private var _code : String;

		private static function escapeString(target : String):String {
			return "\"" + target + "\"";
		}

		private static function arrayToString(target : Array):String {
			var code : String = "";
			var len : int = target.length;
			for(var i : int = 0;i < len;i++) {
				if(code.length > 0)
					code += ",";
				code += LoggingData.encode(target[i]);
			}
			return "[" + code + "]";
		}

		private static function objectToString(target : Object):String {
			var code : String = "";
			var classInfo : XML = describeType(target);
			var name : String = classInfo.@name.toString().replace(/::/, ".");
			if(name == "Object") {
				var value : Object;
				for(var key:String in target) {
					value = target[key];
					if(value is Function)
						continue;
					if(code.length > 0)
						code += ",";
					code += key + ":" + LoggingData.encode(value);
				}
			} else {
				return "[" + name + "]";
			}
			return "{" + code + "}";
		}

		private static function encode(target : *):String {
			if(target is String) {
				return LoggingData.escapeString(target as String);
			} else if(target is Number) {
				return isFinite(target as Number) ? target : "null";
			} else if(target is Boolean) {
				return target ? "true" : "false";
			} else if(target is Array) {
				return LoggingData.arrayToString(target as Array);
			} else if(target is Object && target != null) {
				return LoggingData.objectToString(target);
			}
			return "null";
		}

		/**
		 * @param level Level 日志层级
		 * @param message Array 消息数组
		 */
		public function LoggingData(level : Level, message : Array) {
			_level = level;
			_message = message;
			_timeStamp = null;
		}

		public function get level() : Level {
			return _level;
		}

		public function get message() : Array {
			return _message;
		}

		public static function toCode(target : Array):String {
			var result : String = "null";
			if(target != null) {
				result = "";
				for each(var item:* in target) {
					if(result.length > 0) {
						result += " ";
					}
					result += LoggingData.encode(item);
				}
			}
			return result;
		}

		public function toString():String {
			if(_code == null) {
				_code = LoggingData.toCode(_message);
			}
			return _code;
		}
	}
}