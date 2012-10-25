package gear.net {
	import gear.codec.PlistDecoder;

	/**
	 * @author bright
	 * @version 20121025
	 */
	internal final class PlistLoader extends BinLoader {
		private var _decoder : PlistDecoder;

		override protected function decode() : void {
			_decoder.parse(_byteArray);
			onComplete();
		}

		public function PlistLoader(url : String, key : String) {
			super(url, key);
			_decoder = new PlistDecoder();
		}

		public function get plistObj() : Object {
			return _decoder.plistObj;
		}
	}
}
