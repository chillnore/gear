﻿package gear.log4a {
	/**
	 * trace日志输入源-单例
	 * 
	 * @author bright
	 * @version 20130410
	 */
	public class GTraceAppender implements IGAppender {
		private static var _creating : Boolean = false;
		private static var _instance : GTraceAppender;
		protected var _formatter : IGLogFormatter;

		public function GTraceAppender() {
			if (!_creating) {
				throw (new GLogError("只能使用GUIAppender.instance获得实例!"));
			}
			_formatter = new GSimpleLogFormatter();
		}

		public static function get instance() : GTraceAppender {
			if (_instance == null) {
				_creating = true;
				_instance = new GTraceAppender();
				_creating = false;
			}
			return _instance;
		}

		/**
		 * @inheritDoc
		 */
		public function append(data : GLogData) : void {
			var message : String = _formatter.format(data, "");
			trace(message);
		}
	}
}