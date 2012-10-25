package gear.net {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 加载模型
	 * 
	 * @author bright
	 * @version 20120503
	 */
	public final class LoadModel extends EventDispatcher {
		private var _list : Array;
		private var _done : int;
		private var _total : int;
		private var _speed : int;
		private var _progress : int;

		private function changeHandler(event : Event) : void {
			var count : int = 0;
			var speed : int = 0;
			for each (var data:LoadData in _list) {
				count += data.percent;
				speed += data.speedInfo;
			}
			var progress : int = count + _done * 100;
			if (_progress == progress) {
				return;
			}
			_progress = progress;
			_speed = speed / _list.length;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function LoadModel() {
			_list = new Array();
		}

		public function get total() : int {
			return _list.length;
		}

		/**
		 * 加入加载数据
		 * 
		 * @param data 加载数据
		 */
		public function add(data : LoadData) : void {
			_list.push(data);
			data.addEventListener(Event.CHANGE, changeHandler);
		}

		/**
		 * 移除加载数据
		 * 
		 * @param data 加载数据 
		 */
		public function remove(data : LoadData) : void {
			data.removeEventListener(Event.CHANGE, changeHandler);
			var index : uint = _list.indexOf(data);
			_list.splice(index, 1);
			_done++;
		}

		/**
		 * 重置
		 * 
		 * @param total 加载总数
		 */
		public function reset(total : int) : void {
			_total = total;
			_progress = 0;
			_done = 0;
			_list.length = 0;
			dispatchEvent(new Event(Event.INIT));
		}

		/**
		 * 结束
		 */
		public function end() : void {
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * 获得加载进度
		 * 
		 * @return 加载
		 */
		public function get progress() : int {
			return _progress;
		}

		/**
		 * 获得加载速度
		 * 
		 * @return 速度
		 */
		public function get speed() : int {
			return _speed;
		}

		/**
		 * 获得加载总进度
		 * 
		 * @return 加载总进度	 */
		public function get totalProgress() : int {
			return _total * 100;
		}
	}
}