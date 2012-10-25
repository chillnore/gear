package gear.net {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;

	/**
	 * 加载数据
	 * 
	 * @author bright
	 * @version 20120502
	 */
	public final class LoadData extends EventDispatcher {
		private var _key : String;
		private var _bytesLoaded : uint;
		private var _bytesTotal : uint;
		private var _startTime : int;
		private var _percent : int;

		public function LoadData(key:String) {
			_key=key;
		}

		/**
		 * 重置
		 */
		public function reset() : void {
			_percent = 0;
			_startTime = getTimer();
		}

		public function get key() : String {
			return _key;
		}

		/**
		 * 获得加载字节信息
		 * 
		 * @return 信息
		 */
		public function get bytesInfo() : String {
			return int(_bytesLoaded / 1024) + "KB/" + int(_bytesTotal / 1024) + "KB";
		}

		/**
		 * 获得加载速度信息
		 * 
		 * @return 加载信息		 
		 */
		public function get speedInfo() : int {
			return _bytesLoaded / 1024 / (getTimer() - _startTime) * 1000;
		}

		/**
		 * 计算加载百分比
		 * 
		 * @param bytesLoaded 已加载的字节数
		 * @param bytesTotal 全部字节数
		 */
		public function calcPercent(bytesLoaded : uint, bytesTotal : uint) : void {
			if (isNaN(bytesTotal) || bytesTotal == 0) {
				return;
			}
			_bytesLoaded = bytesLoaded;
			_bytesTotal = bytesTotal;
			var percent : int = 100 * (_bytesLoaded / _bytesTotal);
			if (_percent == percent) {
				return;
			}
			_percent = percent;
			dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		 * 获得加载百分比 
		 * 
		 * @return 加载百分比
		 */
		public function get percent() : int {
			return _percent;
		}
	}
}
