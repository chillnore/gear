package gear.utils {
	import flash.utils.ByteArray;

	/**
	 * 字符串工具类
	 * 
	 * @author bright
	 * @version 20110916
	 */
	public class GStringUtil {
		private static function isWhitespace(character : String) : Boolean {
			switch (character) {
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
				default:
					return false;
			}
		}

		public static function trim(value : String) : String {
			if (value == null) return '';
			var startIndex : int = 0;
			while (isWhitespace(value.charAt(startIndex))) {
				++startIndex;
			}
			var endIndex : int = value.length - 1;
			while (isWhitespace(value.charAt(endIndex))) {
				--endIndex;
			}
			if (endIndex >= startIndex) {
				return value.slice(startIndex, endIndex + 1);
			} else {
				return "";
			}
		}

		public static function format(str : String, ...rest : Array) : String {
			if (str == null) return '';
			var len : uint = rest.length;
			var args : Array;
			if (len == 1 && rest[0] is Array) {
				args = rest[0] as Array;
				len = args.length;
			} else {
				args = rest;
			}
			for (var i : int = 0;i < len;i++) {
				str = str.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
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
			var pattern : RegExp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
			return (pattern.test(url));
		}
	}
}