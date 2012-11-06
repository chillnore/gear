package gear.net {
	import gear.log4a.GLogger;
	import gear.ui.manager.GUIUtil;
	import gear.utils.GStringUtil;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Security;

	/**
	 * 抽象加载器
	 * 
	 * @author bright
	 * @version 20120501
	 */
	public class ALoader extends EventDispatcher {
		public static const FAILED : String = "FAILED";
		/**
		 * @private
		 */
		protected var _url : String;
		protected var _key : String;
		/**
		 * @private
		 */
		protected var _loadData : LoadData;
		protected var _isFailed : Boolean;
		protected var _isLoading : Boolean;
		protected var _source : *;

		protected function crossdomain() : void {
			if (GUIUtil.url != null && GUIUtil.url.indexOf("http://") != -1) {
				var crossDomain : String = GStringUtil.getCrossDomainUrl(_url);
				if (crossDomain != null) {
					Security.loadPolicyFile(crossDomain);
				}
			}
		}

		protected function onFailed() : void {
			_isFailed = true;
			GLogger.info(GStringUtil.format("load {0} failed", _url));
			dispatchEvent(new Event(ALoader.FAILED));
		}

		protected function onComplete() : void {
			_isLoading = false;
			GLoadUtil.setLoaded(this);
			GLogger.info(GStringUtil.format("load {0} complete", _url));
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * 构造函数
		 * 
		 * @param data 库数据
		 */
		public function ALoader(url : String, key : String) {
			_url = url;
			_key = key;
			_loadData = new LoadData(key);
			reset();
		}

		public function reset() : void {
			_isFailed = false;
			_isLoading = false;
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

		/**
		 * 获得加载数据
		 * 
		 * @return 加载
		 */
		public function get loadData() : LoadData {
			return _loadData;
		}

		public function get isFailed() : Boolean {
			return _isFailed;
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
