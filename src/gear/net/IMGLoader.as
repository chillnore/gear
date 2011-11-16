package gear.net {
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;

	/**
	 * PNG加载器
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class IMGLoader extends RESLoader {
		private var _loader : Loader;

		override protected function onComplete() : void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.loadBytes(_byteArray);
		}

		private function completeHandler(event : Event) : void {
			GLogger.info(GStringUtil.format("{0} load complete.", _libData.url));
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_isLoadding = false;
			_isLoaded = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * @inheritDoc
		 */
		public function IMGLoader(data : LibData) {
			super(data);
		}

		public function getBitmap() : Bitmap {
			var bitmap : Bitmap = _loader.contentLoaderInfo.content as Bitmap;
			return (bitmap == null) ? null : bitmap;
		}

		/**
		 * 获得位图
		 * 
		 * @return 		 */
		public function getBitmapData() : BitmapData {
			var bitmap : Bitmap = _loader.contentLoaderInfo.content as Bitmap;
			return (bitmap == null) ? null : bitmap.bitmapData;
		}
	}
}