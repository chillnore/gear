package gear.rpc {
	import gear.log4a.GLogger;
	import gear.utils.GObjectUtil;

	import flash.net.Responder;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;


	/**
	 * @author admin
	 */
	public class AMF3Call {
		public static var TIME_OUT : int = 30000;
		private var _method : String;
		private var _callback : Function;
		private var _args : Array;
		private var _params : Array;
		private var _responder : Responder;
		private var _startTime : int;
		private var _endTime : int;
		private var _timeout : uint;

		private function reset() : void {
			_params = [_method, _responder];
			_params = _params.concat(_args);
		}

		private function onStatus(status : Object) : void {
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_endTime = getTimer() - _startTime;
			GLogger.debug(_method + " use time=" + _endTime / 1000 + "s");
			GLogger.debug(_method + " error,status=", status);
			try {
				_callback.apply(null, [{code:9}]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		private function timeout() : void {
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_endTime = TIME_OUT;
			GLogger.debug(_method + " timeout,use time=" + TIME_OUT / 1000 + "s");
			try {
				_callback.call(null, [{code:10}]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		public function AMF3Call(method : String, callback : Function, ...args : Array) {
			_method = method;
			_callback = callback;
			_args = args;
			_responder = new Responder(onResult, onStatus);
			reset();
		}

		public function get method() : String {
			return _method;
		}

		public function get args() : Array {
			return _args;
		}

		public function merge(value : Object) : void {
			if (value == null) {
				return;
			}
			if (_args == null || _args.length < 1) {
				_args = [value];
				reset();
			} else if (_args[0] is Object) {
				GObjectUtil.append(_args[0], value);
				reset();
			}
		}

		public function get params() : Array {
			return _params;
		}

		public function onResult(...args : Array) : void {
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_endTime = getTimer() - _startTime;
			GLogger.debug(_method + " use time=" + _endTime / 1000 + "s");
			try {
				_callback.apply(null, args);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		public function checkTimeout() : void {
			_startTime = getTimer();
			if (_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_timeout = setTimeout(timeout, TIME_OUT);
		}

		public function get endTime() : int {
			return _endTime;
		}
	}
}
