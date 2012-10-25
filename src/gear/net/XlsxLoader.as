package gear.net {
	import gear.codec.XlsxDecoder;

	/**
	 * Excel 文件加载器
	 * 
	 * @author bright
	 * @version 20121025
	 */
	internal final class XlsxLoader extends BinLoader {
		private var _decoder : XlsxDecoder;

		override protected function decode() : void {
			_decoder.xlsxFile = _byteArray;
			onComplete();
		}

		public function XlsxLoader(url : String, key : String) {
			super(url, key);
			_decoder = new XlsxDecoder();
		}

		public function getSheet(name : String) : WorkSheet {
			return _decoder.getSheet(name);
		}
	}
}
