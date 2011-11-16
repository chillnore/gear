package gear.net {
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.events.Event;

	/**
	 * XML加载器
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class XMLLoader extends RESLoader {
		private var _xml : XML;

		/**
		 * @inheritDoc
		 */
		override protected function onComplete() : void {
			try {
				var s : String = _byteArray.readUTFBytes(_byteArray.length);
				_xml = new XML(s);
				_isLoadding = false;
				_isLoaded = true;
				GLogger.info(GStringUtil.format("load {0} complete", _libData.url));
				dispatchEvent(new Event(Event.COMPLETE));
			} catch(e : TypeError) {
				onError(e.getStackTrace());
			}
		}

		/**
		 * @inheritDoc
		 */
		public function XMLLoader(data : LibData) {
			super(data);
		}

		/**
		 * 获得XML
		 * 
		 * @return 
		 */
		public function getXML() : XML {
			return _xml;
		}
	}
}