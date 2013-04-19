package gear.utils {
	import flash.external.ExternalInterface;

	/**
	 * @author admin
	 */
	public final class GJSUtil {
		/**
		 * 获得浏览器类型
		 */
		public static function get browserAgent() : String {
			if (ExternalInterface.available) {
				var result : String = ExternalInterface.call("eval", "navigator.userAgent");
				if (/MSIE 10/i.test(result) && !/Opera/.test(result)) {
					return "IE 10";
				}
				if (/Chrome/i.test(result) && /WebKit/i.test(result) && /Mozilla/i.test(result)) {
					return "Chrome";
				}
				if (/Firefox/i.test(result)) {
					return "Firefox";
				}
				if (/Opera/i.test(result)) {
					return "Opera";
				}
				if (/Webkit/i.test(result) && !(/Chrome/i.test(result) && /WebKit/i.test(result) && /Mozilla/i.test(result))) {
					return "Safari";
				}
			}
			return "未知";
		}

		/**
		 * 刷新
		 */
		public static function reload() : void {
			if (ExternalInterface.available) {
				ExternalInterface.call("eval", "location.reload();");
			}
		}

		public static function get pageUrl() : String {
			if (ExternalInterface.available) {
				return ExternalInterface.call("eval", "window.location.href");
			}
			return "null";
		}

		public static function alert(value : String) : void {
			if (ExternalInterface.available) {
				ExternalInterface.call("alert", value);
			}
		}
	}
}
