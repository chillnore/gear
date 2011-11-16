package gear.ui.model {
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;

	/**
	 * @author admin
	 */
	public class SyncPageData extends EventDispatcher {
		protected var _page : int;
		protected var _pageSize : int;
		protected var _isLoaded : Boolean;
		protected var _timestamp : int;
		protected var _list : Array;
		protected var _total : int;

		public function SyncPageData(page : int, pageSize : int) {
			_page = page;
			_pageSize = pageSize;
			_isLoaded = false;
			_timestamp = getTimer();
		}

		public final function get isLoaded() : Boolean {
			return _isLoaded;
		}

		public final function get page() : int {
			return _page;
		}

		public final function get timestamp() : int {
			return _timestamp;
		}

		public final function get list() : Array {
			return _list;
		}

		public final function get total() : int {
			return _total;
		}

		public function syncLoad() : void {
		}
	}
}
