package gear.socket {
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 唯一同步模型
	 * 
	 * @author bright
	 * @version 20101020
	 */
	public class OnlySyncModel {
		/**
		 * @private
		 */
		protected var _list : Array;
		/**
		 * @private
		 */
		protected var _timer : Timer;
		/**
		 * @private
		 */
		protected var _socket : SocketClient;

		private function timerHandler(event : TimerEvent) : void {
			for each (var args:Array in _list) {
				_socket.call.apply(null, args);
			}
			_list.splice(0);
			if (_timer.running) {
				_timer.stop();
			}
		}

		private function findAt(value : Array) : int {
			if (_list.length == 0) return -1;
			var index : int = 0;
			for each (var args:Array in _list) {
				if (args[0] == value[0]) {
					return index;
				}
				index++;
			}
			return -1;
		}

		public function OnlySyncModel(socket : SocketClient, delay : int = 500) {
			_socket = socket;
			_list = new Array();
			_timer = new Timer(delay);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		public function clear(method : String) : void {
			var index : int = 0;
			for each (var sync:Array in _list) {
				if (sync[0] == method) {
					_list.splice(index, 1);
				} else {
					index++;
				}
			}
			if (_list.length == 0 && _timer.running) {
				_timer.stop();
			}
		}

		public function add(args : Array, update : Boolean = true) : void {
			if (update) {
				var index : int = findAt(args);
				if (index != -1) {
					_list[index] = args;
				} else {
					_list.push(args);
				}
			} else {
				_list.push(args);
			}
			if (!_timer.running) {
				_timer.reset();
				_timer.start();
			}
		}

		public function stop() : void {
			if (_timer.running) {
				_timer.stop();
				_list.splice(0);
			}
		}
	}
}