package gear.ui.model {
	import gear.log4a.LogError;

	import flash.events.Event;
	import flash.utils.getTimer;


	/**
	 * Sync Page Model
	 * 
	 * @author bright
	 * @version 20101229
	 * @see gear.ui.model.PageModel
	 */
	public final class SyncPageModel extends PageModel {
		public static const TIME_LIMIT : int = 300000;
		private var _syncData : Class;
		private var _list : Array;

		private function completeHandler(event : Event) : void {
			var data : SyncPageData = event.currentTarget as SyncPageData;
			if (_listModel != null) {
				if (data.page == 1) {
					_listModel.max = data.total;
				}
				_listModel.setList((data.page - 1) * _pageSize, data.list);
			}
			_isLoaded = false;
		}

		override protected function loadPage(page : int, update : Boolean = false) : void {
			var data : SyncPageData;
			if (_list[page] == null) {
				data = new _syncData(page, _pageSize);
				data.addEventListener(Event.COMPLETE, completeHandler);
				_list[page] = data;
				_listModel.clearList((page - 1) * _pageSize, _pageSize);
				_isLoaded = true;
				data.syncLoad();
				return;
			}
			data = _list[page];
			if (data.isLoaded) {
				return;
			}
			if (update || (getTimer() - data.timestamp > TIME_LIMIT)) {
				_listModel.clearList((page - 1) * _pageSize, _pageSize);
				_isLoaded = true;
				data.syncLoad();
			}
		}

		public function SyncPageModel(syncData : Class, pageSize : int = 10, model : ListModel = null) {
			super(pageSize, model);
			if (syncData == null || !syncData is SyncPageData) {
				throw new LogError("data must is SyncPageData");
			}
			_syncData = syncData;
			_list = new Array();
			_isLoaded = false;
		}
	}
}