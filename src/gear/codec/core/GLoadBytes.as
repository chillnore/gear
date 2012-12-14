package gear.codec.core {
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
	 * @author bright
	 */
	public final class GLoadBytes {
		private var _onComplete : Function;
		private var _args : Array;

		private function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			if (loaderInfo.contentType == "image/jpegxr") {
				_args.push(Bitmap(loaderInfo.content).bitmapData);
			}
			loaderInfo.loader.unload();
			if (_onComplete != null) {
				try{
				_onComplete.apply(null, _args);
				}catch(e:Error){
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GLoadBytes(data : ByteArray, onComplete : Function, ...args : Array) : void {
			_onComplete = onComplete;
			_args = args;
			var loader : Loader = new Loader();
			var context : LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			if(Capabilities.playerType=="Desktop"){
				context.allowLoadBytesCodeExecution = true;
			}
			context.imageDecodingPolicy=ImageDecodingPolicy.ON_LOAD;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.loadBytes(data, context);
			data.clear();
		}
	}
}
