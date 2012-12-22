package gear.codec.gpk.tag {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.JPEGXREncoderOptions;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;


	/**
	 * @author bright
	 * @version 20121225
	 */
	public final class GpkTagSBD extends AGpkTag {
		public static const TYPE : String = "sbd";
		private var _bd : BitmapData;
		private var _ba : ByteArray;

		private function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_bd = Bitmap(loaderInfo.content).bitmapData;
			loaderInfo.loader.unload();
			complete();
		}

		public function GpkTagSBD(key : String="none", bd : BitmapData=null) : void {
			_key = key;
			_bd = bd;
		}

		override public function encode(output : ByteArray) : void {
			output.writeUTF(TYPE);
			var start : int = output.position;
			output.writeUnsignedInt(0);
			output.writeUTF(_key);
			var jpeg : JPEGXREncoderOptions = new JPEGXREncoderOptions();
			jpeg.quantization = 30;
			_ba = new ByteArray();
			_bd.encode(_bd.rect, jpeg, _ba);
			output.writeUnsignedInt(_ba.length);
			output.writeBytes(_ba);
			var end : int = output.position;
			output.position = start;
			output.writeUnsignedInt(end - start - 4);
			output.position = end;
		}

		override public function decode(input : ByteArray, onComplete : Function) : void {
			_onComplete = onComplete;
			_key = input.readUTF();
			var size : int = input.readUnsignedInt();
			var ba : ByteArray = new ByteArray();
			input.readBytes(ba, 0, size);
			var loader : Loader = new Loader();
			var context : LoaderContext = new LoaderContext();
			context.allowCodeImport = true;
			if (Capabilities.playerType == "Desktop") {
				context.allowLoadBytesCodeExecution = true;
			}
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.loadBytes(ba, context);
		}

		override public function addTo(content : Dictionary) : void {
			content[key] = _bd;
		}
	}
}
