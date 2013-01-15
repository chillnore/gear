package gear.utils {
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	/**
	 * 字符串工具类
	 * 
	 * @author bright
	 * @version 20121112
	 */
	public final class GStringUtil {
		private static function formatD(pattern : String, format : String, value : *) : String {
			var output : String = "NaN";
			if (value is int || value is Number) {
				output = String((value < 0 ? -value : value) | 0);
			} else if (value is uint) {
				output = String(value);
			} else if (value is String) {
				var n : Number = parseFloat(value);
				if (!isNaN(n)) {
					output = String((n < 0 ? -n : n) | 0);
				}
			}
			if (output == "NaN") {
				return pattern.replace(format, output);
			}
			var body : String = format.replace(/[%,d]/g, "");
			if (body.length < 1) {
				return pattern.replace(format, output);
			}
			var width : int = body.split(".")[0] - output.length;
			var fills : String = "";
			while (fills.length < width) {
				fills += "0";
			}
			return pattern.replace(format, fills + output);
		}

		private static function formatN(pattern : String, format : String, value : *) : String {
			var output : String = "NaN";
			if (value is int || value is Number || value is uint) {
				output = String(value);
			} else if (value is String) {
				output = String(parseFloat(value));
			}
			if (output == "NaN") {
				return pattern.replace(format, output);
			}
			var body : String = format.replace(/[%,n]/g, "");
			if (body.length < 1) {
				return pattern.replace(format, value);
			}
			var index : int = body.indexOf(".");
			var flags : String = "";
			var result : Array = body.split(".");
			var width : int = 0;
			var perc : int = output.indexOf(".");
			if (index > 0) {
				width = result[result.length - 1] - (perc < 0 ? 0 : output.length - 1 - perc);
			} else if (perc < 0) {
				width = result[0] - output.length;
			}
			if (width > 0) {
				while (flags.length < width) {
					flags += "0";
				}
			}
			if (index != -1) {
				var scale : int = Math.pow(10, result[result.length - 1]);
				output = (GMathUtil.round(value * scale)) / scale + flags;
			} else if (perc < 0) {
				output = flags + output;
			}
			return pattern.replace(format, output);
		}

		private static function formatS(pattern : String, format : String, value : *) : String {
			var body:String = format.replace(/[%,s]/g, "");
			var output : String = toString(value);
			if (body.length < 1) {
				return pattern.replace(format, output);
			}
			var index : int = body.indexOf(".");
			var result : Array = body.split(".");
			var fills : String = "";
			if (index != -1) {
				output = output.substring(0, result[result.length - 1]);
				if (index > 0) {
					var width : int = result[0] - output.length;
					if (width > 0) {
						while (fills.length < width) {
							fills += " ";
						}
						output = fills + output;
					}
				}
			}
			return pattern.replace(format, output);
		}

		private static function vectorToString(target : Vector.<Object>) : String {
			var code : String = "";
			var len : int = target.length;
			for (var i : int = 0;i < len;i++) {
				if (i > 0) {
					code += ",";
				}
				code += toString(target[i]);
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
				code += toString(target[i]);
			}
			return "[" + code + "]";
		}

		private static function objectToString(target : Object) : String {
			var code : String = "";
			var value : Object;
			for (var key:String in target) {
				value = target[key];
				if (value is Function) {
					continue;
				}
				if (code.length > 0) {
					code += ",";
				}
				code += key + ":" + toString(value);
			}
			return code;
		}

		public static function hasFormat(pattern : String) : Boolean {
			return /%\d*\.*\d*[s,d,n]/g.test(pattern);
		}

		/**
		 * %s
		 * %[width].[prec]d
		 * %[width].[prec]n
		 */
		public static function format(pattern : String, ...rest : Array) : String {
			var result : Array = pattern.match(/%\d*\.*\d*[s,d,n]/g);
			var length : int = Math.min(result.length, rest.length);
			var format : String;
			var type : String;
			while (length-- > 0) {
				format = result.shift();
				type = format.charAt(format.length - 1);
				switch(type) {
					case "s":
						pattern = formatS(pattern, format, rest.shift());
						break;
					case "d":
						pattern = formatD(pattern, format, rest.shift());
						break;
					case "n":
						pattern = formatN(pattern, format, rest.shift());
						break;
				}
			}
			return pattern;
		}

		public static function toString(value : *) : String {
			if (value == null) {
				return "null";
			}
			if (value is String) {
				return value;
			}
			if (value is Array) {
				return arrayToString(value);
			}
			var name : String = getQualifiedClassName(value).split("::").pop();
			if (name.indexOf("Vector") != -1) {
				return vectorToString(Vector.<Object>(value));
			}
			if (name != "Object") {
				if (value.toString is Function) {
					return value.toString();
				} else {
					return "[" + name + "]";
				}
			} else {
				return objectToString(value);
			}
		}

		public static function trim(value : String) : String {
			return value.replace(/^\s*|\s*$/g, "");
		}

		public static function formatTime(value : int) : String {
			var result : String = "";
			var hour : int = value / 3600000;
			result += (hour < 10 ? "0" + hour : hour);
			value -= hour * 3600000;
			var minute : int = value / 60000;
			result += ":" + (minute < 10 ? ("0" + minute) : minute);
			value -= minute * 60000;
			var second : int = value / 1000;
			result += ":" + (second < 10 ? "0" + second : second);
			return result;
		}

		public static function formatDate(value : Date) : String {
			var result : String = value.getFullYear() + "-";
			var month : int = value.getMonth() + 1;
			result += (month > 9) ? month : "0" + month;
			result += "-";
			var date : int = value.getDate();
			result += (date > 9) ? date : "0" + date;
			var hours : int = value.getHours();
			result += " ";
			result += (hours > 9) ? hours : "0" + hours;
			result += ":";
			var minutes : int = value.getMinutes();
			result += (minutes > 9) ? minutes : "0" + minutes;
			result += ":";
			var seconds : int = value.getSeconds();
			result += (seconds > 9) ? seconds : "0" + seconds;
			return result;
		}

		public static function formatNumber(value : int) : String {
			var count : Number;
			var str : String = value.toString();
			var split : Array = new Array();
			var len : Number = str.length;
			while (len > 0) {
				count = Math.max((len - 3), 0);
				split.unshift(str.slice(count, len));
				len = count;
			}
			return split.join(",");
		}

		public static function formatByteArray(value : ByteArray) : String {
			if (value == null) {
				return "null";
			}
			value.position = 0;
			var str : String = "";
			for (var i : int = 0;i < value.length;i++) {
				if (i > 0) {
					str += ",";
				}
				str += value[i].toString(16);
			}
			return str;
		}

		public static function byteArrayToString(value : ByteArray) : String {
			var result : String = "";
			var unit : String = "";
			for (var i : int = 0;i < value.length;i++) {
				unit = Number(value[i]).toString(16);
				if (unit.length < 2) {
					unit = "0" + unit;
				}
				result += unit + " ";
			}
			return result;
		}

		public static function filterXML(value : String) : String {
			var result : String = value.replace(/^\s+|\s+$|(\r|\n)/g, "");
			result = result.replace(/\s+/g, " ");
			result = result.replace("&", "&amp;");
			result = result.replace("<", "&lt;");
			result = result.replace(">", "&gt;");
			result = result.replace("\"", "&quot;");
			result = result.replace("\'", "&apos;");
			return result;
		}

		public static function getDwordLength(value : String) : int {
			return value.replace(/[^\x00-\xff]/g, "**").length;
		}

		public static function isEmail(value : String) : Boolean {
			var re : RegExp = /w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
			return re.exec(value) != null;
		}

		public static function truncateToFit(value : String, length : int) : String {
			if (length > 0) {
				var a : Array = value.match(/[^\x00-\xff]|\w{1,2}/g);
				return a.length <= length ? value : a.slice(0, length).join("") + "..";
			} else {
				return value;
			}
		}

		public static function getCrossDomainUrl(url : String) : String {
			var domain : String = getDomainUrl(url);
			if (domain == null) {
				return null;
			} else {
				return domain + "/crossdomain.xml";
			}
		}

		public static function getDomainUrl(url : String) : String {
			if (url == null) {
				return null;
			} else {
				var params : Array = url.split("http://");
				if (params.length != 2) {
					return null;
				} else {
					return "http://" + params[1].split("/")[0];
				}
			}
		}

		public static function getBaseUrl(url : String) : String {
			if (url == null) {
				return "";
			} else {
				if (url.indexOf("http://") == -1) {
					return "";
				}
				if (url.indexOf("/[[DYNAMIC]]/") != -1) {
					url = url.split("/[[DYNAMIC]]/")[0];
				}
				var end : int = url.lastIndexOf("/");
				return url.slice(0, end + 1);
			}
		}

		public static function isURL(url : String) : Boolean {
			var pattern : RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:\d+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
			return (pattern.test(url));
		}
	}
}