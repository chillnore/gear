package gear.utils {
	import flash.external.ExternalInterface;

	/**
	 * @author admin
	 */
	public class JSUtil {
		private static var _firstTime : Boolean = true;

		public static function get hasJS() : Boolean {
			if (!ExternalInterface.available) return false;
			if (_firstTime) {
				_firstTime = false;
				ExternalInterface.marshallExceptions = true;
			}
			return true;
		}

		public static function getBrowserType() : String {
			var result : String = "none";
			if (!hasJS) return result;
			try {
				result = ExternalInterface.call("eval", "navigator.appName");
				return result;
			} catch(e : Error) {
				return "error";
			}
			return "none";
		}

		public static function getBrowserAgent() : String {
			var result : String = "none";
			if (!hasJS) return result;
			try {
				result = ExternalInterface.call("eval", "navigator.userAgent");
				return result;
			} catch(e : Error) {
				return "error";
			}
			return "none";
		}

		public static function getPageUrl() : String {
			var result : String = "none";
			if (!hasJS) return result;
			try {
				result = ExternalInterface.call("eval", "window.location.href");
				return result;
			} catch(e : Error) {
				return "error";
			}
			return "none";
		}

		public static function reload() : void {
			if (!hasJS) return;
			try {
				ExternalInterface.call("eval", "location.reload();");
			} catch(e : Error) {
			}
		}
	}
}
