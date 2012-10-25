package gear.net {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	/**
	 * 二进制加载器
	 * 
	 * @author bright
	 * @version 20121025
	 */
	internal class BinLoader extends ALoader {
		protected var _request : URLRequest;
		/**
		 * @private
		 */
		protected var _stream : URLStream;
		/**
		 * @private
		 */
		protected var _byteArray : ByteArray;

		private function addStreamEvents() : void {
			_stream.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_stream.addEventListener(Event.COMPLETE, completeHandler);
			_stream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function removeStream() : void {
			_stream.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_stream.removeEventListener(Event.COMPLETE, completeHandler);
			_stream.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_stream.close();
			_stream = null;
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			removeStream();
			onFailed();
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			removeStream();
			onFailed();
		}

		private function progressHandler(event : ProgressEvent) : void {
			_loadData.calcPercent(event.bytesLoaded, event.bytesTotal);
		}

		private function completeHandler(event : Event) : void {
			_byteArray = new ByteArray();
			_stream.readBytes(_byteArray, 0, _stream.bytesAvailable);
			removeStream();
			decode();
		}

		/**
		 * 字节流加载完成
		 * 
		 * @private
		 */
		protected function decode() : void {
			onComplete();
		}

		/**
		 * @inheritDoc
		 */
		public function BinLoader(url : String, key : String) {
			super(url, key);
			_request = new URLRequest(_url);
			// _request.data = new URLVariables("version=" + _libData.version);
		}

		/**
		 * @inheritDoc
		 */
		override public function load() : void {
			if (GLoadUtil.isLoaded(_key)) {
				return;
			}
			if (_isFailed) {
				return;
			}
			if (_isLoading) {
				return;
			}
			_isLoading = true;
			crossdomain();
			_stream = new URLStream();
			addStreamEvents();
			_loadData.reset();
			_stream.load(_request);
		}

		/**
		 * 获得资源字节数组
		 * 
		 * @return 数组
		 */
		public function getByteArray() : ByteArray {
			return _byteArray;
		}
	}
}