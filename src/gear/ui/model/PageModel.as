package gear.ui.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * PageModel 分页模型
	 * 
	 * @author bright
	 * @version 20101206
	 */
	public class PageModel extends EventDispatcher {
		public static const PAGE_CHANGE : String = "pageChange";
		public static const TOTAL_CHANGE : String = "totalChange";
		protected var _currentPage : uint;
		protected var _totalPage : uint;
		protected var _pageSize : uint;
		protected var _base : int;
		protected var _listModel : ListModel;
		protected var _isLoaded : Boolean;

		private function list_resizeHandler(event : Event) : void {
			resetSize();
		}

		private function resetSize() : void {
			if (_listModel.size > 0) {
				if (_currentPage == 0) {
					_currentPage = 1;
				}
			} else {
				_currentPage = 1;
			}
			totalPage = Math.ceil(_listModel.size / _pageSize);
		}

		protected function loadPage(page : int, update : Boolean = false) : void {
			page;
			update;
		}

		public function PageModel(pageSize : int = 10, model : ListModel = null) {
			_pageSize = pageSize;
			listModel = model;
			_isLoaded = false;
		}

		public function set listModel(value : ListModel) : void {
			if (_listModel != null) {
				_listModel.removeEventListener(Event.RESIZE, list_resizeHandler);
			}
			_listModel = value;
			if (_listModel != null) {
				resetSize();
				_listModel.addEventListener(Event.RESIZE, list_resizeHandler);
				dispatchEvent(new Event(PageModel.PAGE_CHANGE));
			}
		}

		public function get listModel() : ListModel {
			return _listModel;
		}

		public function set pageSize(value : int) : void {
			if (_pageSize == value) {
				return;
			}
			_pageSize = value;
		}

		public function get pageSize() : int {
			return _pageSize;
		}

		public function set currentPage(value : int) : void {
			value = Math.max(1, Math.min(_totalPage, value));
			if (_currentPage == value) {
				return;
			}
			_currentPage = value;
			_base = (_currentPage - 1) * _pageSize;
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function get currentPage() : int {
			return _currentPage;
		}

		public function get base() : int {
			return _base;
		}

		public function get currentSize() : int {
			if (_listModel == null) {
				return 0;
			}
			var len : int = (_listModel.limit < 1 ? _listModel.size : _listModel.limit);
			return  getPageIndex(len);
		}

		public function set totalPage(value : int) : void {
			value = Math.max(1, value);
			if (_totalPage == value) {
				return;
			}
			_totalPage = value;
			dispatchEvent(new Event(PageModel.TOTAL_CHANGE));
			if (_currentPage > _totalPage) {
				_currentPage = totalPage;
				_base = (_currentPage - 1) * _pageSize;
				dispatchEvent(new Event(PageModel.PAGE_CHANGE));
			}
		}

		public function get totalPage() : int {
			return _totalPage;
		}

		public function get hasPrevPage() : Boolean {
			return _currentPage > 1;
		}

		public function prevPage() : void {
			if (_currentPage < 2 || _isLoaded) {
				return;
			}
			_currentPage--;
			_base = (_currentPage - 1) * _pageSize;
			loadPage(_currentPage);
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function get hasNextPage() : Boolean {
			return _currentPage < _totalPage;
		}

		public function nextPage() : void {
			if (_currentPage >= _totalPage || _isLoaded) {
				return;
			}
			_currentPage++;
			_base = (_currentPage - 1) * _pageSize;
			loadPage(_currentPage);
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function canPrevMove(step : int = 1) : Boolean {
			if (step < 1 || _listModel == null || _base < 1) {
				return false;
			}
			return true;
		}

		public function prevMove(step : int = 1) : void {
			if (step < 1 || _listModel == null || _base < 1 || _isLoaded) {
				return;
			}
			var oldBase : int = _base;
			_base = Math.max(0, _base - step);
			var page : int = int(_base / pageSize) + 1;
			if (_currentPage != page) {
				_currentPage = page;
			}
			var base : int = _currentPage * _pageSize;
			trace("prevMove", _currentPage, base);
			if (base <= oldBase && base >= _base) {
				trace("loadPrevPage", _currentPage);
				loadPage(_currentPage);
			}
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function canNextMove(step : int = 1) : Boolean {
			if (step < 1 || _listModel == null || _base >= _listModel.size - _pageSize) {
				return false;
			}
			return true;
		}

		public function nextMove(step : int = 1) : void {
			if (step < 1 || _listModel == null || _base >= _listModel.size - _pageSize || _isLoaded) {
				return;
			}
			var oldBase : int = _base;
			_base = Math.min(_listModel.size - _pageSize, _base + step);
			var page : int = int(_base / _pageSize) + 1;
			if (_currentPage != page) {
				_currentPage = page;
			}
			var base : int = (_currentPage - 1) * _pageSize;
			trace("nextMove", _currentPage, base);
			if (base >= oldBase && base <= _base) {
				trace("loadNextPage", _currentPage + 1);
				loadPage(_currentPage + 1);
			}
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function first() : void {
			firstPage();
		}

		public function last() : void {
			if (_totalPage < 2 || _base >= _listModel.size - _pageSize || _isLoaded) {
				return;
			}
			_base = _listModel.size - _pageSize;
			var page : int = int(_base / pageSize) + 1;
			if (_currentPage != page) {
				_currentPage = page;
			}
			if (page < _totalPage) {
				loadPage(page);
			}
			loadPage(_totalPage);
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function firstPage() : void {
			_currentPage = 1;
			_base = (_currentPage - 1) * _pageSize;
			if (loadPage(_currentPage)) {
				return;
			}
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function lastPage() : void {
			if (_currentPage == _totalPage || _isLoaded) {
				return;
			}
			_currentPage = _totalPage;
			_base = (_currentPage - 1) * _pageSize;
			if (loadPage(_currentPage)) {
				return;
			}
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}

		public function atCurrentPage(index : int) : Boolean {
			if (index < _base || index > _base + _pageSize) {
				return false;
			} else {
				return true;
			}
		}

		public function getPageIndex(index : int) : int {
			if (index < _base) {
				return 0;
			}
			if (index > _base + _pageSize) {
				return _pageSize;
			}
			return index - _base;
		}

		public function getList(page : int) : Array {
			var start : int = (page - 1) * _pageSize;
			var end : int = Math.min(_listModel.size, start + _pageSize);
			var list : Array = new Array();
			for (var i : int = start;i < end;i++) {
				list.push(_listModel.getAt(i));
			}
			return list;
		}

		public function update() : void {
			loadPage(_currentPage, true);
			dispatchEvent(new Event(PageModel.PAGE_CHANGE));
		}
	}
}