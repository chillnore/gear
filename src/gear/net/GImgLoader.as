package gear.net {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;

	/**
	 * PNG,JPG,GIF加载器
	 * 
	 * @author bright
	 * @version 20121212
	 */
	internal final class GImgLoader extends GBinLoader {
		private var _bitmap : Bitmap;
		private var _start : int;

		override protected function decode() : void {
			_start = getTimer();
			var loader : Loader = new Loader();
			var context : LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			if (Capabilities.playerType == "Desktop") {
				context.allowLoadBytesCodeExecution = true;
			}
			context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.loadBytes(_data, context);
		}

		private function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_bitmap = Bitmap(loaderInfo.content);
			loaderInfo.loader.unload();
			_data.clear();
			complete();
		}

		public function GImgLoader(url : String) {
			super(url);
		}

		public function get bitmap() : Bitmap {
			return _bitmap;
		}
	}
}