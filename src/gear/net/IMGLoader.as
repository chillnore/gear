package gear.net {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;

	/**
	 * PNG,JPG加载器
	 * 
	 * @author bright
	 * @version 20121025
	 */
	internal final class ImgLoader extends BinLoader {
		private var _loader : Loader;
		private var _bitmap : Bitmap;

		override protected function decode() : void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.loadBytes(_byteArray);
		}

		private function completeHandler(event : Event) : void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_bitmap = _loader.contentLoaderInfo.content as Bitmap;
			onComplete();
		}

		public function ImgLoader(url : String, key : String) {
			super(url, key);
		}

		public function get bitmap() : Bitmap {
			return _bitmap;
		}
	}
}