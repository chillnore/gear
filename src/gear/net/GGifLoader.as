package gear.net {
	import gear.codec.gif.GGifDecoder;
	import gear.gui.bd.GBDList;

	/**
	 * GIF加载器
	 * 
	 * @author bright
	 * @version 20130514
	 */
	public class GGifLoader extends GBinLoader {
		private var _decoder : GGifDecoder;

		override protected function decode() : void {
			 _decoder.decode(_data, complete, failed);
			 _data.clear();
		}

		public function GGifLoader(url : String, key : String = null, version : String = null) {
			super(url, key, version);
			_decoder = new GGifDecoder();
		}

		public function get bdList() : GBDList {
			return _decoder.bdList;
		}
	}
}
