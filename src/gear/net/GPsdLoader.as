package gear.net {
	import gear.codec.psd.GPsdDecoder;
	/**
	 * Psd文件加载器
	 * 
	 * @author bright
	 * @version 20121109
	 */
	internal final class GPsdLoader extends GBinLoader {
		private var _decoder : GPsdDecoder;

		override protected function decode() : void {
			_decoder.decode(_data);
			_data.clear();
			complete();
		}

		public function GPsdLoader(url : String) {
			super(url);
			_decoder = new GPsdDecoder();
		}
	}
}
