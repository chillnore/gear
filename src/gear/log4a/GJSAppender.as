package gear.log4a {
	import gear.utils.GJSUtil;

	import flash.external.ExternalInterface;

	/**
	 * JS日志输入源-单例
	 * 
	 * @author bright
	 * @version 20130415
	 */
	public class GJSAppender implements IGAppender {
		private static var _creating : Boolean = false;
		private static var _instance : GJSAppender;
		protected var _formatter : IGLogFormatter;
		protected var _brower : String;

		public function GJSAppender() {
			if (!_creating) {
				throw (new GLogError("只能使用GJSAppender.instance获得实例!"));
			}
			_formatter = new GSimpleLogFormatter();
			_brower = GJSUtil.browserAgent;
		}

		public static function get instance() : GJSAppender {
			if (_instance == null) {
				_creating = true;
				_instance = new GJSAppender();
				_creating = false;
			}
			return _instance;
		}

		/**
		 * @inheritDoc
		 */
		public function append(data : GLogData) : void {
			if (ExternalInterface.available) {
				var message : String = _formatter.format(data, "");
				if (data.level == GLevel.INFO) {
					ExternalInterface.call("console.info", message);
				} else if (data.level == GLevel.DEBUG) {
					if (_brower == "IE 10") {
						ExternalInterface.call("console.info", message);
					} else {
						ExternalInterface.call("console.debug", message);
					}
				} else if (data.level == GLevel.WARN) {
					ExternalInterface.call("console.warn", message);
				} else if (data.level == GLevel.ERROR || data.level == GLevel.FATAL) {
					ExternalInterface.call("console.error", message);
				}
			}
		}
	}
}