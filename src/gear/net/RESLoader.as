package gear.net {
	import gear.log4a.GLogger;
	import gear.ui.manager.UIManager;
	import gear.utils.GStringUtil;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.system.Security;
	import flash.utils.ByteArray;

	/**
	 * 抽象资源流加载器
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class RESLoader extends ALoader {
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

		private function removeStreamEvents() : void {
			_stream.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_stream.removeEventListener(Event.COMPLETE, completeHandler);
			_stream.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			onError(event.text);
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			onError(event.text);
		}

		private function progressHandler(event : ProgressEvent) : void {
			_loadData.calcPercent(event.bytesLoaded, event.bytesTotal);
		}

		private function completeHandler(event : Event) : void {
			removeStreamEvents();
			_byteArray = new ByteArray();
			var length : int = _stream.bytesAvailable;
			_stream.readBytes(_byteArray, 0, length);
			_stream.close();
			onComplete();
		}

		/**
		 * @private
		 */
		protected function onComplete() : void {
			_isLoadding = false;
			_isLoaded = true;
			GLogger.info(GStringUtil.format("load {0} complete", _libData.url));
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * @private
		 */
		protected function onError(message : String) : void {
			GLogger.error("#", GStringUtil.format("RESLoader.error msg={0}", message));
			if (_try < TRY_MAX) {
				_try++;
				_loadData.reset();
				_stream.load(_request);
			} else {
				removeStreamEvents();
				_isLoadding = _isLoaded = false;
				dispatchEvent(new Event(ALoader.ERROR));
			}
		}

		/**
		 * @inheritDoc
		 */
		public function RESLoader(data : LibData) {
			super(data);
			_request = new URLRequest(_libData.url);
			if (_libData.version != null) {
				_request.data = new URLVariables("version=" + _libData.version);
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function load() : void {
			if (_isLoadding || _isLoaded) {
				return;
			}
			if (UIManager.url != null && UIManager.url.indexOf("http://") != -1) {
				var crossDomain : String = GStringUtil.getCrossDomainUrl(_libData.url);
				if (crossDomain != null) {
					try {
						Security.loadPolicyFile(crossDomain);
					} catch(e : Error) {
						onError(e.getStackTrace());
						return;
					}
				}
			}
			_isLoadding = true;
			_try = 1;
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