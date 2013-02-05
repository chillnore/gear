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
	 * @version 20121212
	 */
	internal class GBinLoader extends AGLoader {
		protected var _request : URLRequest;
		/**
		 * @private
		 */
		protected var _stream : URLStream;
		/**
		 * @private
		 */
		protected var _data : ByteArray;

		override protected function startLoad() : void {
			_stream = new URLStream();
			addStreamEvents();
			_stream.load(_request);
		}

		/**
		 * 添加字节流事件
		 * 
		 * @private
		 */
		protected function addStreamEvents() : void {
			_stream.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_stream.addEventListener(Event.COMPLETE, completeHandler);
			_stream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		/**
		 * 移动字节流事件
		 * 
		 * @private
		 */
		protected function removeStreamEvents() : void {
			_stream.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_stream.removeEventListener(Event.COMPLETE, completeHandler);
			_stream.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_stream.close();
			_stream = null;
		}

		protected function ioErrorHandler(event : IOErrorEvent) : void {
			removeStreamEvents();
			failed();
		}

		protected function securityErrorHandler(event : SecurityErrorEvent) : void {
			removeStreamEvents();
			failed();
		}

		private function progressHandler(event : ProgressEvent) : void {
			_model.setTo(event.bytesLoaded, 0, event.bytesTotal);
		}

		private function completeHandler(event : Event) : void {
			_data = new ByteArray();
			_stream.readBytes(_data, 0, _stream.bytesAvailable);
			removeStreamEvents();
			if (_data.length > 0) {
				decode();
			} else {
				failed();
			}
		}

		/**
		 * 字节流加载完成
		 * 
		 * @private
		 */
		protected function decode() : void {
			complete();
		}

		/**
		 * @inheritDoc
		 */
		public function GBinLoader(url : String, key : String = null, version : String = null) {
			super(url, key, version);
			_request = new URLRequest(_url);
		}

		/**
		 * 获得资源字节数组
		 * 
		 * @return 数组
		 */
		public function get byteArray() : ByteArray {
			return _data;
		}
	}
}