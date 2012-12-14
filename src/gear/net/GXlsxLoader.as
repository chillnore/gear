package gear.net {
	import gear.codec.xlsx.GWorkSheet;
	import gear.codec.xlsx.GXlsxDecoder;

	/**
	 * Excel 文件加载器
	 * 
	 * @author bright
	 * @version 20121025
	 */
	internal final class GXlsxLoader extends GBinLoader {
		private var _decoder : GXlsxDecoder;

		override protected function decode() : void {
			_decoder.decode(_data);
			_data.clear();
			complete();
		}

		public function GXlsxLoader(url : String) {
			super(url);
			_decoder = new GXlsxDecoder();
		}

		public function getSheet(name : String) : GWorkSheet {
			return _decoder.getSheet(name);
		}
	}
}
