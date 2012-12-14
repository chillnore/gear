package gear.net {
	/**
	 * Json文件加载器-只允许包内访问
	 * 
	 * @author bright
	 * @version 20121212
	 */
	internal final class GJsonLoader extends GBinLoader {
		private var _jsonObj : Object;

		override protected function decode() : void {
			try {
				_jsonObj = JSON.parse(_data.readUTFBytes(_data.length));
				_data.clear();
				complete();
			} catch(e : TypeError) {
				failed();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GJsonLoader(url : String) {
			super(url);
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
