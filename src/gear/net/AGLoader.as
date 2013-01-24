package gear.net {
	import gear.gui.model.GRangeModel;
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	/**
	 * 抽象加载器
	 * 
	 * @author bright
	 * @version 20121108
	 */
	internal class AGLoader implements IGLoader {
		protected var _url : String;
		protected var _key : String;
		protected var _version : String;
		protected var _state : int;
		protected var _onLoaded : Function;
		protected var _onFailed : Function;
		protected var _model : GRangeModel;

		protected function startLoad() : void {
		}

		protected function complete() : void {
			_state = GLoadState.COMPLETE;
			GLogger.info(GStringUtil.format("加载 %s 完成", _url));
			GLoadUtil.loadNext(this);
			if (_onLoaded == null) {
				return;
			}
			try {
				_onLoaded(_key);
			} catch(e : Error) {
				GLogger.debug(e.getStackTrace());
			}
		}

		protected function failed() : void {
			_state = GLoadState.FAILED;
			GLogger.warn(GStringUtil.format("加载 %s 失败!", _url));
			GLoadUtil.loadNext(this);
			if (_onFailed == null) {
				return;
			}
			try {
				_onFailed(_key);
			} catch(e : Error) {
				GLogger.debug(e.getStackTrace());
			}
		}

		/**
		 * 构造函数
		 */
		public function AGLoader(url : String, key : String = null, version : String = null) {
			_url = url;
			_key = (key == null ? GFileType.getKey(url) : key);
			_version = version;
			_state = GLoadState.NONE;
			_model = new GRangeModel();
		}

		public function get model() : GRangeModel {
			return _model;
		}

		public function get url() : String {
			return _url;
		}

		/**
		 * 获得键
		 * 
		 * @return 	 */
		public function get key() : String {
			return _key;
		}

		public function get state() : int {
			return _state;
		}

		public function set onLoaded(value : Function) : void {
			_onLoaded = value;
		}

		public function set onFailed(value : Function) : void {
			_onFailed = value;
		}

		/**
		 * 开始加载
		 */
		public function load() : void {
			if (_state != GLoadState.NONE && _state != GLoadState.WAITING) {
				return;
			}
			_state = GLoadState.LOADING;
			_model.setTo(0, 0, 100);
			startLoad();
		}

		public function reload() : void {
			if (_state == GLoadState.COMPLETE || _state == GLoadState.FAILED) {
				_state = GLoadState.NONE;
			}
		}

		public function wait() : void {
			_state = GLoadState.WAITING;
		}
	}
}
