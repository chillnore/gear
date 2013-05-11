package gear.net {
	import gear.codec.atf.GAtfDecoder;

	import flash.display.BitmapData;

	/**
	 * @author Administrator
	 */
	public class GAtfLoader extends GBinLoader {
		private var _decoder : GAtfDecoder;

		override protected function decode() : void {
			_decoder.decode(_data,complete,failed);
			_data.clear();
		}

		public function GAtfLoader(url : String, key : String = null, version : String = null) {
			super(url, key, version);
			_decoder = new GAtfDecoder();
		}

		public function get bitmapData() : BitmapData {
			return _decoder.bitmapData;
		}
	}
}
