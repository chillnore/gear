package gear.net {
	/**
	 * Xml文件加载器
	 * 
	 * @author bright
	 * @version 20121108
	 */
	internal final class GXmlLoader extends GBinLoader {
		private var _xml : XML;

		/**
		 * 重写解码方法
		 * 
		 * @inheritDoc
		 */
		override protected function decode() : void {
			try {
				var value : String = _data.readUTFBytes(_data.length);
				_xml = new XML(value);
				_data.clear();
				complete();
			} catch(e : TypeError) {
				failed();
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GXmlLoader(url : String) {
			super(url);
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