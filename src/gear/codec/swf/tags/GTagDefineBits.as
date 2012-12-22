package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

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
	public class GTagDefineBits implements IGSwfTag {
		public static const TYPE : uint = 6;
		public static const JPEG : int = 0;
		public static const PNG : int = 1;
		public static const GIF89A : int = 2;
		protected var _characterId : int;
		protected var _data : ByteArray;
		protected var _bitmapType : int;
		protected var _bitmap : Bitmap;
		protected var _onComplete : Function;

		protected function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_bitmap = Bitmap(loaderInfo.content);
			_onComplete(_bitmap);
		}

		public function GTagDefineBits() {
			_data = new ByteArray();
			_bitmapType = JPEG;
		}

		public function decode(data : GSwfStream, length : uint) : void {
			_characterId = data.readUI16();
			if (length > 2) {
				data.readBytes(_data, length - 2);
			}
		}

		public function getBitmap(onComplete : Function) : void {
			_onComplete = onComplete;
			if (_bitmap != null) {
				_onComplete(_bitmap);
			} else {
				var loader : Loader = new Loader();
				var context : LoaderContext = new LoaderContext();
				context.allowCodeImport = true;
				context.allowLoadBytesCodeExecution = true;
				if (Capabilities.playerType == "Desktop") {
					context.allowLoadBytesCodeExecution = true;
				}
				context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				loader.loadBytes(_data, context);
			}
		}
	}
}
