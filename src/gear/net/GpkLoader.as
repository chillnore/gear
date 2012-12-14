package gear.net {
	import gear.codec.gpk.Gpk;
	/**
	 * @author bright
	 */
	internal final class GpkLoader extends GBinLoader{
		private var _gpk : Gpk;

		override protected function decode() : void {
			_gpk.decode(_data,complete);
		}

		public function GpkLoader(url : String) {
			super(url);
			_gpk = new Gpk();
		}

		public function get gpk() : Gpk {
			return _gpk;
		}
	}
}
