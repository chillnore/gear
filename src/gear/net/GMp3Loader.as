package gear.net {
	import gear.log4a.GLogger;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	/**
	 * Mp3文件加载器-只允许包内访问
	 * 
	 * @author bright
	 * @version 20121212
	 */
	internal final class GMp3Loader extends AGLoader {
		private var _sound : Sound;

		private function addListeners() : void {
			_sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_sound.addEventListener(Event.COMPLETE, completeHandler);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function removeListeners() : void {
			_sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			_sound.removeEventListener(Event.COMPLETE, completeHandler);
			_sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			removeListeners();
			_sound.close();
			failed();
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			removeListeners();
			_sound.close();
			failed();
		}

		private function progressHandler(event : ProgressEvent) : void {
		}

		private function completeHandler(event : Event) : void {
			removeListeners();
			complete();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function startLoad() : void {
			_sound = new Sound();
			addListeners();
			var request : URLRequest = new URLRequest(_url);
			request.method = URLRequestMethod.GET;
			try {
				_sound.load(request);
			} catch(e : Error) {
				_sound.close();
				GLogger.error(e.getStackTrace());
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GMp3Loader(url : String) {
			super(url);
		}

		/**
		 * 获得Sound
		 * 
		 * @return d
		 */
		public function getSound() : Sound {
			return _sound;
		}
	}
}
