package gear.rpc {
	import gear.log4a.LogError;
	import gear.log4a.GLogger;
	import gear.render.RenderCall;
	import gear.render.FrameRender;

	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.utils.Dictionary;

	/**
	 * Flash Remoting Client
	 * 
	 * @author bright
	 * @version 20101025
	 * @example
	 * <listing version="3.0">
	 * var rc:RemoteClient=new RemoteClient("http://localhost/gateway.php");
	 * rc.testMode=true;
	 * rc.addTest("UserService.hello",test_hello);
	 * rc.call("UserService.hello",call_hello,"bright");
	 * private function test_hello(username:String):Array{
	 * 	return ["hello "+username];
	 * }
	 * private function call_hello(info:String):void{
	 * 	trace(info); // "hello bright"
	 * }
	 * </listing>
	 */
	public class Service extends EventDispatcher {
		public static const INVALID_QUEST : String = "invalidQuest";
		private var _gateway : String;
		private var _verify : String;
		private var _prefix : Object;
		private var _timestamp : int;
		private var _test : Dictionary;
		private var _nc : NetConnection;
		private var _timer : RenderCall;
		private var _pollCall : AMF3Call;

		private function netStatusHandler(event : NetStatusEvent) : void {
			for (var s:String in event.info) {
				GLogger.warn(s + ":" + event.info[s]);
			}
			if (event.info.level == "error") {
				if (event.info.code == "NetConnection.Call.Failed") {
					onError(event.info.description);
				} else if (event.info.code == "Client.Data.UnderFlow") {
				}
			}
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			GLogger.error("io error");
		}

		private function asyncErrorHandler(event : AsyncErrorEvent) : void {
			GLogger.error("async error");
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			GLogger.error("security error");
		}

		private function onError(message : String) : void {
			var event : ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
			event.text = message;
			dispatchEvent(event);
		}

		private function timerHandler(event : TimerEvent) : void {
			_pollCall.checkTimeout();
			_nc.call.apply(null, _pollCall.params);
		}

		public function Service(gateway : String) : void {
			if (gateway == null || gateway.length < 1) {
				throw new LogError("gateway valid");
			}
			_gateway = gateway;
			_timer = new RenderCall(timerHandler);
			_test = new Dictionary();
			_nc = new NetConnection();
			_nc.objectEncoding = ObjectEncoding.AMF3;
			_nc.client = this;
			_nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_nc.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_nc.connect(_gateway);
		}

		public function setTest(method : String, callback : Function) : void {
			_test[method] = callback;
		}

		public function set prefix(value : Object) : void {
			_prefix = value;
		}

		public function addCall(value : AMF3Call) : void {
			if (_test[value.method] != null) {
				try {
					value.onResult.apply(null, Function(_test[value.method]).apply(null, value.args));
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			} else {
				value.merge(_prefix);
				value.checkTimeout();
				GLogger.debug(value.method, value.params);
				_nc.call.apply(null, value.params);
			}
		}

		public function set timestamp(value : int) : void {
			_timestamp = value;
		}

		public function startPoll(call : AMF3Call, delay : int) : void {
			if (_verify == "none") return;
			_pollCall = call;
			_pollCall.merge(_prefix);
			_timer.delay = delay;
			FrameRender.instance.add(_timer);
		}

		public function stopPoll() : void {
			FrameRender.instance.remove(_timer);
		}
	}
}
