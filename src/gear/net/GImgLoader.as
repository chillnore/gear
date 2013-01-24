package gear.net {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;

	/**
	 * PNG,JPG,GIF加载器
	 * 
	 * @author bright
	 * @version 20121212
	 */
	internal final class GImgLoader extends GBinLoader {
		private var _loader : Loader;
		private var _context : LoaderContext;
		private var _bitmapData : BitmapData;

		override protected function decode() : void {
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.loadBytes(_data, _context);
		}

		private function completeHandler(event : Event) : void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_bitmapData = Bitmap(_loader.contentLoaderInfo.content).bitmapData;
			_loader.unloadAndStop();
			_data.clear();
			complete();
		}

		public function GImgLoader(url : String, key : String = null, version : String = null) {
			super(url, key, version);
			_loader = new Loader();
			_context = new LoaderContext();
			_context.allowCodeImport = true;
			if (Capabilities.playerType == "Desktop") {
				_context.allowLoadBytesCodeExecution = true;
			}
			_context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
		}

		public function get bitmapData() : BitmapData {
			return _bitmapData;
		}
	}
}