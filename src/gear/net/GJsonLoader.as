package gear.net {
	import gear.log4a.GLogger;
	/**
	 * Json文件加载器-只允许包内访问
	 * 
	 * @author bright
	 * @version 20130305
	 */
	internal final class GJsonLoader extends GBinLoader {
		private var _jsonObj : Object;

		override protected function decode() : void {
			try {
				_jsonObj = JSON.parse(_data.readUTFBytes(_data.length));
				_data.clear();
				complete();
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
				failed();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GJsonLoader(url : String,key:String=null,version:String=null) {
			super(url,key,version);
		}

		/**
		 * 获得Object
		 * 
		 * @return 
		 */
		public function get jsonObj() : Object {
			return _jsonObj;
		}
	}
}
