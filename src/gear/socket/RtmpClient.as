package gear.socket {
	import gear.log4a.GLogger;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.Timer;


	/**
	 * Rtmp客户端
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class RtmpClient extends EventDispatcher {
		/**
		 * @private
		 */
		public static const ERROR : String = "error";
		public static const ADD_MY_USER : String = "addMyUser";
		public static const PRIVATE_MSG : String = "privateMsg";
		private var _maxAttempts : int;
		private var _host : String;
		private var _appName : String;
		private var _protos : Array;
		private var _currentAttempt : int;
		private var _protosIndex : int;
		private var _temp_nc : NetConnection;
		private var _timer : Timer;
		private var _main_nc : NetConnection;
		private var _uid : int;
		private var _privateMsg : Object;

		private function init() : void {
			_protos = new Array();
			_protos.push({proto:"rtmp", port:1935});
			_protos.push({proto:"rtmps", port:443});
			_currentAttempt = 0;
			_timer = new Timer(15000, 1);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		private function startProtosConnect() : void {
			_currentAttempt++
			;
			if (_currentAttempt > _maxAttempts) {
				GLogger.info(this, "startProtosConnect calling failed!");
				failed();
				return;
			}
			_protosIndex = 0;
			_temp_nc = setUpTempNC();
			var uri : String = _protos[_protosIndex].proto + "://" + _host + ":" + _protos[_protosIndex].port + "/" + _appName;
			_temp_nc.connect(uri);
			GLogger.info(this, "[" + _currentAttempt + "/" + _maxAttempts + "]" + (_protosIndex + 1) + "/" + _protos.length + ":" + _temp_nc.uri);
			_timer.reset();
			_timer.start();
		}

		private function failed() : void {
			_timer.stop();
			deleteTempNC();
			dispatchEvent(new Event(ERROR));
		}

		private function setUpTempNC() : NetConnection {
			var nc : NetConnection = new NetConnection();
			nc.objectEncoding = ObjectEncoding.AMF3;
			nc.addEventListener(NetStatusEvent.NET_STATUS, tempNetStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, tempSecurityErrorHandler);
			nc.proxyType = "best";
			return nc;
		}

		private function tempNetStatusHandler(event : NetStatusEvent) : void {
			_timer.stop();
			var nc : NetConnection = event.currentTarget as NetConnection;
			var uri : String = nc.uri;
			switch(event.info.code) {
				case "NetConnection.Connect.Success":
					setUpMainNC(_temp_nc);
					break;
				case "NetConnection.Connect.Failed":
					GLogger.info(this, "connect " + uri + " failed!");
					nextConnect();
					break;
				case "NetConnection.Connect.Rejected":
					GLogger.info(this, "connect " + uri + " rejected!");
					failed();
					break;
			}
		}

		private function tempSecurityErrorHandler(event : SecurityError) : void {
			_timer.stop();
			failed();
			GLogger.error(event.toString());
		}

		private function nextConnect() : void {
			_protosIndex++
			;
			if (_protosIndex == _protos.length) {
				startProtosConnect();
				return;
			}
			deleteTempNC();
			_temp_nc = setUpTempNC();
			var uri : String = _protos[_protosIndex].proto + "://" + _host + ":" + _protos[_protosIndex].port + "/" + _appName;
			_temp_nc.connect(uri);
			GLogger.info(this, "[" + _currentAttempt + "/" + _maxAttempts + "]" + (_protosIndex + 1) + "/" + _protos.length + ":" + _temp_nc.uri);
			_timer.reset();
			_timer.start();
		}

		private function timerHandler(event : TimerEvent) : void {
			GLogger.info(this, "FMS3 connect time out!");
			if (_protosIndex < _protos.length)
				nextConnect();
			else
				startProtosConnect();
		}

		private function mainNetStatusHandler(event : NetStatusEvent) : void {
			GLogger.info(this, "main net status:" + event.info.code);
			if (event.info.code == "NetConnection.Connect.Closed") {
				dispatchEvent(new Event(Event.CLOSE));
			}
		}

		private function deleteTempNC() : void {
			if (_temp_nc == null)
				return;
			_temp_nc.removeEventListener(NetStatusEvent.NET_STATUS, tempNetStatusHandler);
			_temp_nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, tempSecurityErrorHandler);
			_temp_nc.close();
			_temp_nc = null;
		}

		private function setUpMainNC(nc : NetConnection) : void {
			nc.removeEventListener(NetStatusEvent.NET_STATUS, tempNetStatusHandler);
			nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, tempSecurityErrorHandler);
			_main_nc = nc;
			_main_nc.addEventListener(NetStatusEvent.NET_STATUS, mainNetStatusHandler);
			_main_nc.client = this;
			GLogger.info("connect " + _main_nc.uri.toLowerCase() + " success!");
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * 构造函数
		 *
		 * @param host RTMP服务器地址 
		 * @param appName RTMP应用名称
		 */
		public function RtmpClient(host : String, appName : String) {
			_host = host;
			_appName = appName;
			_maxAttempts = 3;
			init();
		}

		/**
		 * 获得NC连接
		 * 
		 * @return 
		 */
		public function get nc() : NetConnection {
			return _main_nc;
		}

		/**
		 * 开始连接
		 */
		public function connect() : void {
			startProtosConnect();
		}

		/**
		 * 断开连接
		 */
		public function disconnect() : void {
			if (_main_nc == null) {
				return;
			}
			if (_timer.running) {
				_timer.stop();
			}
			_main_nc.removeEventListener(NetStatusEvent.NET_STATUS, mainNetStatusHandler);
			_main_nc.close();
			_main_nc = null;
			dispatchEvent(new Event(Event.CLOSE));
		}

		/**
		 * @private
		 */
		public function areYouOk() : Boolean {
			return true;
		}

		/**
		 * @private
		 */
		public function privateMsg(s_uid : int, t_uid : int, msg : Object) : void {
			_privateMsg = {s_uid:s_uid, t_uid:t_uid, msg:msg};
			dispatchEvent(new Event(PRIVATE_MSG));
		}

		/**
		 * @private
		 */
		public function getPrivateMsg() : Object {
			return _privateMsg;
		}

		/**
		 * @private
		 */
		public function addMyUser(uid : int) : void {
			_uid = uid;
			dispatchEvent(new Event(RtmpClient.ADD_MY_USER));
		}

		/**
		 * @private
		 */
		public function get uid() : int {
			return _uid;
		}
	}
}