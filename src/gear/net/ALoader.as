package gear.net {
	import flash.events.EventDispatcher;

	/**
	 * 抽象加载器
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class ALoader extends EventDispatcher {
		public static const ERROR : String = "error";
		/**
		 * @private
		 */
		protected var _libData : LibData;
		/**
		 * @private
		 */
		protected var _loadData : LoadData;
		/**
		 * @private
		 */
		protected var _isLoadding : Boolean;
		/**
		 * @private
		 */
		protected var _isLoaded : Boolean;
		protected var _try : int;
		protected var _source : *;
		public static const TRY_MAX : int = 3;

		/**
		 * 构造函数
		 * 
		 * @param data 库数据
		 */
		public function ALoader(data : LibData) {
			_libData = data;
			_loadData = new LoadData();
			_isLoadding = false;
			_isLoaded = false;
		}

		public function get isLoaded() : Boolean {
			return _isLoaded;
		}

		public function get url() : String {
			return _libData.url;
		}

		/**
		 * 获得键
		 * 
		 * @return 	 */
		public function get key() : String {
			return _libData.key;
		}

		/**
		 * 获得加载数据
		 * 
		 * @return 加载
		 */
		public function get loadData() : LoadData {
			return _loadData;
		}

		/**
		 * 开始加载
		 */
		public function load() : void {
		}

		public function set source(value : *) : void {
			_source = value;
		}

		public function get source() : * {
			return _source;
		}
	}
}
