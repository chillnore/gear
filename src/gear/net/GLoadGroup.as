package gear.net {
	import gear.log4a.GLogger;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 加载组
	 * 
	 * @author bright
	 * @version 20121025
	 */
	public final class GLoadGroup extends EventDispatcher {
		public static const MAX : int = 5;
		private var _isLoading : Boolean;
		private var _list : Array;
		private var _model : LoadModel;

		private function loadNext() : void {
			if (_list.length < 1) {
				return;
			}
			var loader : ALoader = ALoader(_list.shift());
			_model.add(loader.loadData);
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(ALoader.FAILED, failedHandler);
			loader.load();
		}

		private function completeHandler(event : Event) : void {
			removeLoader(ALoader(event.currentTarget));
		}

		private function failedHandler(event : Event) : void {
			removeLoader(ALoader(event.currentTarget));
		}

		private function removeLoader(loader : ALoader) : void {
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ALoader.FAILED, failedHandler);
			_model.remove(loader.loadData);
			if (_list.length > 0 || _model.total > 0) {
				loadNext();
			} else {
				onComplete();
			}
		}

		private  function onComplete() : void {
			_isLoading = false;
			_model.end();
			GLogger.info("LoadGroup load all done!");
			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function GLoadGroup() {
			_isLoading = false;
			_list = new Array();
			_model = new LoadModel();
		}

		/**
		 * 加入加载器
		 * 
		 * @param value LibData
		 */
		public function add(url : String, key : String = null) : void {
			if (key == null) {
				key = FileType.getKey(url);
			}
			if (GLoadUtil.isLoaded(key)) {
				return;
			}
			var loader : ALoader = GLoadUtil.create(url, key);
			if (_list.indexOf(loader) != -1) {
				return;
			}
			if (loader.isFailed) {
				return;
			}
			_list.push(loader);
		}

		/**
		 * 获得加载模型
		 * 
		 * @return 加载模型
		 * @see ar.net.LoadModel		 
		 */
		public function get model() : LoadModel {
			return _model;
		}

		/**
		 * 开始加载
		 */
		public function load() : void {
			if (_list.length == 0) {
				onComplete();
				return;
			}
			if (_isLoading) {
				return;
			}
			_isLoading = true;
			_model.reset(_list.length);
			var total : int = Math.min(_list.length, MAX);
			var loader : ALoader;
			for (var i : int = 0;i < total;i++) {
				loader = ALoader(_list.shift());
				_model.add(loader.loadData);
				loader.addEventListener(Event.COMPLETE, completeHandler);
				loader.addEventListener(ALoader.FAILED, failedHandler);
				loader.load();
			}
		}
	}
}