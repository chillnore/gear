package gear.socket {
	import gear.core.IDispose;
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * CallPool 反射池
	 * 
	 * @author bright
	 * @version 20101008
	 */
	public class CallPool implements IDispose {
		private var _callbacks : Dictionary;
		private var _list : Array;
		private var _timer : Timer;
		// 是否为排队，间隔处理消息
		private var _queue : Boolean = true;

		private function timerHandler(event : TimerEvent) : void {
			if (_list.length == 0) {
				_timer.stop();
				return;
			} else {
				execute(_list.shift());
			}
		}

		private function findAt(method : String, callback : Function) : int {
			var calls : Array = _callbacks[method];
			if (calls == null)
				return -1;
			var index : int = 0;
			for each (var call:Function in calls) {
				if (call == callback)
					return index;
				index++;
			}
			return -1;
		}

		private function execute(request : CallData) : void {
			var calls : Array = _callbacks[request.method];
			if (calls == null || calls.length == 0) {
				GLogger.warn(GStringUtil.format("{0} not found callbacks", request.method));
				return;
			}
			for each (var callback:Function in calls) {
				try {
					callback.apply(null, request.args);
				} catch(e : Error) {
					GLogger.warn(request.toString(), request.args, e.getStackTrace());
				}
			}
		}

		public function CallPool() {
			_callbacks = new Dictionary(true);
			_list = new Array();
			_timer = new Timer(30);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		public function getCallback(method : String) : Array {
			return _callbacks[method];
		}

		/**
		 * addCallback 加入反射
		 * 
		 * @param method String 方法名
		 * @param callback Function 回调函数 
		 */
		public function addCallback(method : String, callback : Function) : void {
			if (_callbacks[method] == null) {
				_callbacks[method] = [];
			}
			var index : int = findAt(method, callback);
			if (index == -1) {
				_callbacks[method].push(callback);
			}
		}

		/**
		 * removeCallback 移除反射
		 * 
		 * @param method String 方法名
		 * @param callback Function 回调函数 
		 */
		public function removeCallback(method : String, callback : Function) : void {
			var index : int = findAt(method, callback);
			if (index != -1) {
				_callbacks[method].splice(index, 1);
			}
		}

		/**
		 * addRequest 加入请求包
		 * 
		 * @param request CallData 反射数据
		 */
		public function addRequest(request : CallData) : void {
			if (!_queue) {
				execute(request);
				return;
			}
			if (request == null) {
				return;
			}
			_list.push(request);
			if (!_timer.running) {
				_timer.start();
			}
		}

		/**
		 *  dispose 释放资源
		 */
		public function dispose() : void {
			while (_list.length > 0) {
				execute(_list.shift());
			}
			if (_timer.running) {
				_timer.stop();
			}
		}

		/**
		 * size
		 * 
		 * @return int 寸
		 */
		public function get size() : int {
			return _list.length;
		}

		public function set queue(queue : Boolean) : void {
			_queue = queue;
			if (!queue) {
				while (_list.length > 0) {
					execute(_list.shift());
				}
				if (_timer.running) {
					_timer.stop();
				}
			}
		}
	}
}