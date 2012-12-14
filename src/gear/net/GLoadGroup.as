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
		private var _waitings : Vector.<String>;
		private var _onDone : Function;
		private var _onLoaded : Function;
		private var _onFailed:Function;

		private function loaded(key : String) : void {
			var index : int = _waitings.indexOf(key);
			if (index != -1) {
				_waitings.splice(index, 1);
				if(_onLoaded!=null){
					try{
						_onLoaded(key);
					}catch(e:Error){
						GLogger.error(e.getStackTrace());
					}
				}
			}
			if (_waitings.length <1) {
				done();
			}
		}
		
		private function failed(key : String) : void {
			var index : int = _waitings.indexOf(key);
			if (index != -1) {
				_waitings.splice(index, 1);
				if(_onFailed!=null){
					try{
						_onFailed(key);
					}catch(e:Error){
						GLogger.error(e.getStackTrace());
					}
				}
			}
			if (_waitings.length <1) {
				done();
			}
		}

		private function done() : void {
			_isLoading = false;
			if (_onDone != null) {
				try {
					_onDone();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GLoadGroup() {
			_isLoading = false;
			_waitings = new Vector.<String>();
		}

		/**
		 * 加入加载器
		 * 
		 * @param value LibData
		 */
		public function add(url : String, automatch : Boolean = true) : void {
			var loader : AGLoader = GLoadUtil.create(url, automatch);
			if (loader.state != GLoadState.NONE) {
				return;
			}
			_waitings.push(loader.key);
		}

		/**
		 * 开始加载
		 */
		public function load(onDone : Function, onLoaded : Function = null,onFailed:Function=null) : void {
			if (_isLoading) {
				return;
			}
			_isLoading = true;
			_onDone = onDone;
			_onLoaded = onLoaded;
			_onFailed=onFailed;
			if (_waitings.length == 0) {
				done();
				return;
			}
			for each (var key:String in _waitings) {
				GLoadUtil.load(key, loaded, failed);
			}
		}
	}
}