package gear.key {
	import gear.utils.GDictUtil;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * 热键控制
	 * 
	 * @author  bright
	 * @version 20121029
	 */
	public class HotKey {
		public static const NONE : uint = 0;
		private var _owner : Stage;
		private var _active : Boolean;
		private var _filter : IKeyControl;
		private var _dict : Dictionary;
		private var _lastKey : KeyData;

		/**
		 * @private
		 */
		private function keyDownHandler(event : KeyboardEvent) : void {
			var keyCode : uint = _filter.convertKeyCode(event.keyCode);
			if (_filter.keyDownFliter(keyCode)) {
				return;
			}
			var keyData : HotKeyData = _dict[keyCode];
			if (keyData == null) {
				return;
			}
			if (keyData.onKeyDown()) {
				_lastKey.keyCode = keyCode;
				_lastKey.time = getTimer();
			}
		}

		/*
		 * @private
		 */
		private function keyUpHandler(event : KeyboardEvent) : void {
			var keyCode : uint = _filter.convertKeyCode(event.keyCode);
			var keyData : HotKeyData = _dict[keyCode];
			if (keyData == null) {
				return;
			}
			keyData.onKeyUp();
		}

		private function deactivateHandler(event : Event) : void {
			resetKeys();
		}

		private function resetKeys() : void {
			for each (var keyData:HotKeyData in _dict) {
				keyData.onKeyUp();
			}
			_lastKey.reset();
		}

		/**
		 * 构造函数
		 * 
		 * @param stage 舞台
		 * @param filter 键过滤接口
		 */
		public function HotKey(stage : Stage, filter : IKeyControl) {
			_owner = stage;
			_filter = filter;
			_active = false;
			_dict = new Dictionary(false);
			_lastKey = new KeyData();
		}

		public function clear() : void {
			resetKeys();
			GDictUtil.clear(_dict);
		}

		/**
		 * 设置激活状态
		 * 
		 * @param value 激活状态
		 */
		public function set active(value : Boolean) : void {
			if (_active == value) {
				return;
			}
			_active = value;
			if (_active) {
				_owner.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				_owner.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
				_owner.addEventListener(Event.DEACTIVATE, deactivateHandler);
			} else {
				_owner.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				_owner.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
				_owner.removeEventListener(Event.DEACTIVATE, deactivateHandler);
				resetKeys();
			}
		}

		public function get active() : Boolean {
			return _active;
		}

		/**
		 * 设置热键回调
		 * 
		 * @param keyCode 键码
		 * @param callback 回调函数
		 * @param mode 模式
		 */
		public function setHotKey(keyCode : uint, callback : Function) : void {
			if (callback == null) {
				delete _dict[keyCode];
			} else {
				_dict[keyCode] = new HotKeyData(keyCode, callback);
			}
		}

		/**
		 * 热键是否按下
		 * 
		 * @param keyCode 键码
		 * @return Boolean
		 */
		public function isKeyDown(keyCode : uint) : Boolean {
			var keyData : HotKeyData = _dict[keyCode];
			if (keyData == null) {
				return false;
			}
			return keyData.isKeyDown;
		}

		/**
		 * 设置指定键码的激活状态
		 * 
		 * @param keyCode 键码
		 * @param active 是否激活
		 */
		public function setActive(keyCode : uint, active : Boolean) : void {
			var keyData : HotKeyData = _dict[keyCode];
			if (keyData == null) {
				return;
			}
			keyData.active = active;
		}

		/**
		 * 获得指定键码的激活状态
		 * 
		 * @return Boolean 指定的激态
		 */
		public function getActive(keyCode : uint) : Boolean {
			var keyData : HotKeyData = _dict[keyCode];
			if (keyData == null) {
				return false;
			}
			return keyData.active;
		}

		/**
		 * 是否有热键按下
		 */
		public function get hasKeyDown() : Boolean {
			for each (var keyData:HotKeyData in _dict) {
				if (keyData.isKeyDown) {
					return true;
				}
			}
			return false;
		}

		/**
		 * 获得最后按键，用于连按相同键
		 * 
		 * @rreturn KeyData 按键数据
		 */
		public function get lastKey() : KeyData {
			return _lastKey;
		}
	}
}