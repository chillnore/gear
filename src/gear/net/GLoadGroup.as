package gear.net {
	import gear.log4a.GLogger;

	/**
	 * 加载组
	 * 
	 * @author bright
	 * @version 20121108
	 */
	public final class GLoadGroup {
		private var _isLoading : Boolean;
		private var _loaders : Vector.<AGLoader>;
		private var _onFinish : Function;
		private var _onLoaded : Function;
		private var _model : GLoadModel;

		private function finish() : void {
			_isLoading = false;
			if (_onFinish != null) {
				try {
					_onFinish();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GLoadGroup() {
			_isLoading = false;
			_loaders = new Vector.<AGLoader>();
			_model = new GLoadModel();
		}

		internal function loadNext(loader : AGLoader) : void {
			var index : int = _loaders.indexOf(loader);
			if (index == -1) {
				return;
			}
			_loaders.splice(index, 1);
			if (_onLoaded != null) {
				try {
					_onLoaded(loader.key);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
			if (_loaders.length < 1) {
				finish();
			}
		}

		internal function get isFinish() : Boolean {
			return _loaders.length < 1;
		}

		public function get model() : GLoadModel {
			return _model;
		}

		/**
		 * 加入加载器
		 * 
		 * @param url 加载地址
		 * @param key 别名
		 * @param reload 是否重新加载
		 */
		public function add(url : String, key : String = null, reload : Boolean = false) : void {
			var loader : AGLoader = GLoadUtil.create(url, key);
			if (reload) {
				loader.reload();
			}
			if (loader.state != GLoadState.NONE || _loaders.indexOf(loader) != -1) {
				return;
			}
			_loaders.push(loader);
		}

		public function adds(urls : Vector.<String>) : void {
			var loader : AGLoader;
			for each (var url:String in urls) {
				loader = GLoadUtil.create(url);
				if (loader.state != GLoadState.NONE || _loaders.indexOf(loader) != -1) {
					continue;
				}
				_loaders.push(loader);
			}
		}

		/**
		 * 开始加载
		 */
		public function load(onFinish : Function, onLoaded : Function = null) : void {
			if (_isLoading) {
				return;
			}
			_isLoading = true;
			_onFinish = onFinish;
			_onLoaded = onLoaded;
			if (_loaders.length > 0) {
				if (GLoadUtil.groups.indexOf(this) == -1) {
					GLoadUtil.groups.push(this);
				}
				for each (var loader:AGLoader in _loaders) {
					GLoadUtil.startLoad(loader);
				}
				_model.reset(_loaders);
			} else {
				finish();
			}
		}
	}
}