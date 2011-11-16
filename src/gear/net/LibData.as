package gear.net {
	/**
	 * 资源库定义
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class LibData {
		private var _url : String;
		private var _key : String;
		private var _version : String;

		/**
		 * LibData 构造函数
		 * 
		 * @param url String 库URL地址
		 * @param key String 库关键字 @default null 为空时将URL中的文件名做为键
		 * @param version String 库版本 @default null 防缓冲
		 * <listing version="3.0"> LibData使用示例
		 * var loader:SWFLoader=new SWFLoader(new LibData("assets/ui.swf","ui"));
		 * loader.addEventListener(Event.COMPLETE,load_completeHandler);
		 * loader.load
		 * </listing> 
		 */
		public function LibData(url : String, key : String = null, version : String = null) {
			_url = url;
			if (key == null) {
				var separator : String = (url.indexOf("/") > -1) ? "/" : "\\";
				_key = _url.split(separator).pop().split(".").shift();
			} else {
				_key = key;
			}
			_version = version;
		}

		/**
		 * 获得URL地址
		 * 
		 * @return URL地址
		 */
		public function get url() : String {
			return _url;
		}

		/**
		 * 获得键
		 * 
		 * @return 键
		 */
		public function get key() : String {
			return _key;
		}

		/**
		 * 获得版本
		 * 
		 * @return 版本
		 */
		public function get version() : String {
			return _version;
		}
	}
}