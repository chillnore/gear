package gear.net {
	import gear.log4a.GLogger;

	/**
	 * 加载组
	 * 
	 * @author bright
	 * @version 20121108
	 */
	public final class GLoadGroup {
		private var _isLoadding : Boolean;
		private var _loadeds : Vector.<AGLoader>;
		private var _waits : Vector.<AGLoader>;
		private var _onFinish : Function;
		private var _onLoaded : Function;
		private var _model : GLoadModel;

		private function finish() : void {
			_isLoadding = false;
			if (_onFinish != null) {
				try {
					_onFinish();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GLoadGroup() {
			_loadeds = new Vector.<AGLoader>();
			_waits = new Vector.<AGLoader>();
			_model = new GLoadModel();
		}

		internal function loadNext(loader : AGLoader) : void {
			var index : int = _waits.indexOf(loader);
			if (index == -1) {
				return;
			}
			_waits.splice(index, 1);
			if (loader.state == GLoadState.COMPLETE && _onLoaded != null) {
				try {
					_onLoaded.apply(null, [loader.key]);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
			if (_waits.length < 1) {
				finish();
			}
		}

		internal function get isFinish() : Boolean {
			return _waits.length < 1;
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
			if (loader.state == GLoadState.COMPLETE || loader.state == GLoadState.FAILED) {
				if (_loadeds.indexOf(loader) == -1) {
					_isLoadding = false;
					_loadeds.push(loader);
				}
				return;
			}
			if (_waits.indexOf(loader) == -1) {
				_isLoadding = false;
				_waits.push(loader);
			}
		}

		/**
		 * 开始加载
		 */
		public function load(onFinish : Function, onLoaded : Function = null) : void {
			if (_isLoadding) {
				return;
			}
			_isLoadding = true;
			_onFinish = onFinish;
			_onLoaded = onLoaded;
			var loader : AGLoader;
			if (_loadeds.length > 0 && _onLoaded != null) {
				for each (loader in _loadeds) {
					try {
						_onLoaded.apply(null, [loader.key]);
					} catch(e : Error) {
						GLogger.error(e.getStackTrace());
					}
				}
				_loadeds.length = 0;
			}
			if (_waits.length > 0) {
				if (GLoadUtil.groups.indexOf(this) == -1) {
					GLoadUtil.groups.push(this);
				}
				for each (loader in _waits) {
					GLoadUtil.startLoad(loader);
				}
				_model.reset(_waits);
			} else {
				finish();
			}
		}
	}
}