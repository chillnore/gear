package gear.codec.core {
	import flash.events.IOErrorEvent;

	import gear.log4a.GLogger;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 * 字节加载器
	 * 
	 * @author bright
	 * @version 20130510
	 */
	public final class GBytesLoader {
		private var _data : ByteArray;
		private var _onFinish : Function;
		private var _args : Array;
		private var _loader : Loader;
		private var _context : LoaderContext;
		private var _isLoaded : Boolean;

		private function addEvents(value : LoaderInfo) : void {
			value.addEventListener(Event.COMPLETE, completeHandler);
			value.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

		private function removeEvents(value : LoaderInfo) : void {
			value.removeEventListener(Event.COMPLETE, completeHandler);
			value.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			value.loader.unload();
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			_args.push(null);
			finish();
		}

		private function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			if (loaderInfo.contentType.indexOf("image") != -1) {
				_args.push(Bitmap(loaderInfo.content).bitmapData);
			}
			removeEvents(loaderInfo);
			finish();
		}

		private function finish() : void {
			if (_onFinish != null) {
				try {
					_onFinish.apply(null, _args);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GBytesLoader(data : ByteArray, onFinish : Function, ...args : Array) : void {
			_data = data;
			_onFinish = onFinish;
			_args = args;
			_loader = new Loader();
			_context = new LoaderContext();
			_context.allowCodeImport = true;
			if (Capabilities.playerType == "Desktop") {
				_context.allowLoadBytesCodeExecution = true;
			}
			_context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			_isLoaded = false;
		}

		public function load() : void {
			if (!_isLoaded) {
				_isLoaded = true;
				addEvents(_loader.contentLoaderInfo);
				_loader.loadBytes(_data, _context);
				_data.clear();
			}
		}
	}
}
