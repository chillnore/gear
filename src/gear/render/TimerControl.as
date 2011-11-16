package gear.render {
	import gear.log4a.LogError;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * 帧渲染控制器
	 * 
	 * @author bright
	 * @version 20110919
	 */
	public class TimerControl {
		private static var _creating : Boolean = false;
		private static var _instance : TimerControl;
		private var _timer : Timer;
		private var _list : Array;
		private var _lastTime : int;
		private var _nowTime : int;
		private var _elapsed : int;

		private function init() : void {
			_list = new Array();
			_timer = new Timer(15);
		}

		private function timerHandler(event : TimerEvent) : void {
			_nowTime = getTimer();
			_elapsed = _nowTime - _lastTime;
			_lastTime = getTimer();
			for each (var render:ITimerRender in _list) {
				render.refresh(_elapsed, event);
			}
		}

		public function TimerControl() {
			if (!_creating) {
				throw (new LogError("Class cannot be instantiated.Use RenderControl.instance instead."));
			}
			init();
		}

		public static function get instance() : TimerControl {
			if (_instance == null) {
				_creating = true;
				_instance = new TimerControl();
				_creating = false;
			}
			return _instance;
		}

		public function add(value : ITimerRender) : Boolean {
			if (_list.indexOf(value) != -1) {
				return false;
			}
			_list.push(value);
			if (!_timer.running) {
				_lastTime = getTimer();
				_timer.addEventListener(TimerEvent.TIMER, timerHandler);
				_timer.reset();
				_timer.start();
			}
			return true;
		}

		public function remove(value : ITimerRender) : Boolean {
			var index : int = _list.indexOf(value);
			if (index == -1) {
				return false;
			}
			_list.splice(index, 1);
			if (_list.length == 0 ) {
				if (_timer.running) {
					_timer.stop();
					_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				}
			}
			return true;
		}
	}
}
