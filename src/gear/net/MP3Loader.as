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
	 * MP3加载器
	 * 
	 * @author bright
	 * @version 20120502
	 */
	internal final class MP3Loader extends ALoader {
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
			onFailed();
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			removeListeners();
			_sound.close();
			onFailed();
		}

		private function progressHandler(event : ProgressEvent) : void {
			_loadData.calcPercent(event.bytesLoaded, event.bytesTotal);
		}

		private function completeHandler(event : Event) : void {
			removeListeners();
			onComplete();
		}

		/**
		 * @inheritDoc
		 */
		public function MP3Loader(url : String, key : String) {
			super(url, key);
		}

		/**
		 * @inheritDoc
		 */
		override public function load() : void {
			_sound = new Sound();
			addListeners();
			_loadData.reset();
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
		 * 获得Sound
		 * 
		 * @return d
		 */
		public function getSound() : Sound {
			return _sound;
		}
	}
}
