package gear.net {
	import gear.codec.plist.GPlistDecoder;

	/**
	 * @author bright
	 * @version 20121025
	 */
	internal final class GPlistLoader extends GBinLoader {
		private var _decoder : GPlistDecoder;

		override protected function decode() : void {
			_decoder.decode(_data);
			_data.clear();
			complete();
		}

		public function GPlistLoader(url : String, key : String = null, version : String = null) {
			super(url, key, version);
			_decoder = new GPlistDecoder();
		}

		public function get plistObj() : Object {
			return _decoder.plistObj;
		}
	}
}
