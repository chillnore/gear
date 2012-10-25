package gear.key {
	import gear.log4a.GLogger;

	/**
	 * 热键定义
	 * 
	 * @author bright
	 * @version 20111201
	 */
	public final class HotKeyData {
		/**
		 * 热键按下状态
		 */
		public static const KEY_DOWN : int = 0;
		/**
		 * 热键抬起状态
		 */
		public static const KEY_UP : int = 1;
		private var _active : Boolean;
		private var _state : int;
		private var _keyCode : uint;
		private var _callback : Function;

		/**
		 * 热键定义
		 * 
		 * @param keyCode uint 键码
		 * @param callback Function 回调函数
		 * @param mode int 模式
		 */
		public function HotKeyData(keyCode : uint, callback : Function) {
			_keyCode = keyCode;
			_callback = callback;
			_active = false;
			_state = KEY_UP;
		}

		public function reset() : void {
			_state = KEY_UP;
		}

		/**
		 * 设置激活状态
		 * 
		 * @param value 设置激活状态
		 */
		public function set active(value : Boolean) : void {
			if (_active == value) {
				return;
			}
			_active = value;
			reset();
		}

		/**
		 * 获得激活状态
		 * 
		 * @return value 
		 */
		public function get active() : Boolean {
			return _active;
		}

		/**
		 * 当前状态是否为按下状态
		 * 
		 * @return 当前是否下状态
		 */
		public function get isKeyDown() : Boolean {
			return _state == KEY_DOWN;
		}

		/**
		 * 获得键码
		 * 
		 * @return 键码
		 */
		public function get keyCode() : uint {
			return _keyCode;
		}

		/**
		 * 当热键按下时
		 */
		public function onKeyDown() : Boolean {
			if (_state == KEY_DOWN) {
				return false;
			}
			_state = KEY_DOWN;
			if (!_active) {
				return false;
			}
			try {
				_callback.apply(null, [this]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
			return true;
		}

		/**
		 * 当热键抬起时
		 */
		public function onKeyUp() : void {
			if (_state != KEY_DOWN) {
				return;
			}
			_state = KEY_UP;
			if (!_active) {
				return;
			}
			try {
				_callback.apply(null, [this]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}
	}
}
