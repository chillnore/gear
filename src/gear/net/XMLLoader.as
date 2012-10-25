package gear.net {
	/**
	 * XML加载器
	 * 
	 * @author bright
	 * @version 20120502
	 */
	internal final class XMLLoader extends BinLoader {
		private var _xml : XML;

		/**
		 * @inheritDoc
		 */
		override protected function decode() : void {
			try {
				var value : String = _byteArray.readUTFBytes(_byteArray.length);
				trace(value);
				_xml = new XML(value);
				onComplete();
			} catch(e : TypeError) {
				onFailed();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function XMLLoader(url : String, key : String) {
			super(url, key);
		}

		/**
		 * 获得XML
		 * 
		 * @return 
		 */
		public function get xml() : XML {
			return _xml;
		}
	}
}