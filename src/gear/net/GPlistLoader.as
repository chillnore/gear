package gear.net {
	import gear.codec.plist.GPlist;

	/**
	 * @author bright
	 * @version 20121025
	 */
	internal final class GPlistLoader extends GBinLoader {
		private var _decoder : GPlist;

		override protected function decode() : void {
			_decoder.decode(_data);
			_data.clear();
			complete();
		}

		public function GPlistLoader(url : String) {
			super(url);
			_decoder = new GPlist();
		}

		public function get plistObj() : Object {
			return _decoder.plistObj;
		}
	}
}
