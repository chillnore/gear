package gear.net {
	import gear.log4a.GLogger;
	import gear.codec.csv.GCsvDecoder;

	/**
	 * csv文件加载器-只允许包内访问
	 * 
	 * @author bright
	 * @version 20130116
	 */
	internal final class GCsvLoader extends GBinLoader {
		private var _decode : GCsvDecoder;

		override protected function decode() : void {
			try {
				_decode.parse(_data.readUTFBytes(_data.length));
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
		public function GCsvLoader(url : String, key : String = null, version : String = null) {
			super(url, key, version);
			_decode = new GCsvDecoder();
		}

		public function get data() : Vector.<Vector.<String>> {
			return _decode.data;
		}
	}
}
