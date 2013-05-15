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
	 * 转换字节数组
	 * 
	 * @author bright
	 * @version 20130510
	 */
	public final class GLoadBytes {
		private var _onFinish : Function;
		private var _args : Array;

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
			if (loaderInfo.contentType == "image/jpegxr" || loaderInfo.contentType == "image/gif") {
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

		public function GLoadBytes(data : ByteArray, onFinish : Function, ...args : Array) : void {
			_onFinish = onFinish;
			_args = args;
			var loader : Loader = new Loader();
			var context : LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			if (Capabilities.playerType == "Desktop") {
				context.allowLoadBytesCodeExecution = true;
			}
			context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			addEvents(loader.contentLoaderInfo);
			loader.loadBytes(data, context);
			data.clear();
		}
	}
}
