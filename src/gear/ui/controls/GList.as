package gear.ui.controls {
	import gear.ui.cell.GCell;
	import gear.ui.cell.GCellData;
	import gear.ui.containers.GScrollView;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GListData;
	import gear.ui.model.GListEvent;
	import gear.ui.model.ListModel;
	import gear.ui.model.ListState;
	import gear.ui.model.SelectionModel;

	import flash.events.Event;

	/**
	 * 列表控件
	 * 
	 * @author bright
	 * @version 20101012
	 * 
	 * @example 示例
	 * <listing version="3.0">
	 * var data : GListData = new GListData();
	 * data.cellData.width = 100;
	 * data.cellData.height = 22;
	 * _list = new GList(data);
	 * addChild(_list);
	 * _list.model.source = [new LabelSource("item0"), new LabelSource("item1")];
	 * </listing>
	 */
	public class GList extends GScrollView {
		/**
		 * @private
		 */
		protected var _listData : GListData;
		/**
		 * @private
		 */
		protected var _cell : Class;
		/**
		 * @private
		 */
		protected var _selectedCells : Array;
		/**
		 * @private
		 */
		protected var _selectionModel : SelectionModel;
		/**
		 * @private
		 */
		protected var _model : ListModel;
		/**
		 * @private
		 */
		protected var _cells : Array;
		/**
		 * @private
		 */
		protected var _cellWidth : int;
		/**
		 * @private
		 */
		protected var _cellHeight : int;

		/**
		 * @private
		 */
		override protected function init() : void {
			_cell = _listData.cell;
			_cells = new Array();
			_selectedCells = new Array();
			super.init();
		}

		/**
		 * @private
		 */
		override protected function create() : void {
			super.create();
			var templet : GCell = new _cell(_listData.cellData);
			_cellWidth = templet.width;
			_cellHeight = templet.height;
			resetSize(_listData.rows);
			if (_listData.rows > 0) {
				initCells();
			}
		}

		/**
		 * @private
		 */
		private function resetSize(rows : int) : void {
			if (_base.scaleMode == ScaleMode.AUTO_SIZE) {
				_width = _cellWidth + _listData.padding * 2;
				if (rows > 0) {
					_height = _cellHeight * rows + (rows - 1) * _listData.hGap + _listData.padding * 2;
				} else {
					_height = Math.max(_base.minHeight, _listData.padding * 2);
				}
			} else if (_base.scaleMode == ScaleMode.AUTO_HEIGHT) {
				_width = Math.max(_width, _cellWidth + _listData.padding * 2);
				if (rows > 0) {
					_height = _cellHeight * rows + (rows - 1) * _listData.hGap + _listData.padding * 2;
				} else {
					_height = Math.max(_base.minHeight, _listData.padding * 2);
				}
			}
		}

		/**
		 * @private
		 */
		override protected function resizeContent() : void {
			for each (var cell:GCell in _cells) {
				cell.width = _viewRect.width;
			}
		}

		/**
		 * @private
		 */
		protected function removeCells() : void {
			for each (var cell:GCell in _cells) {
				removeCellEvents(cell);
				cell.hide();
			}
			_cells = new Array();
		}

		/**
		 * @private
		 */
		protected function addCells() : void {
			for (var i : int = 0;i < _model.size;i++) {
				var data : GCellData = _listData.cellData.clone();
				data.y = i * (_cellHeight + _listData.hGap);
				data.width = _viewRect.width;
				var cell : GCell = new _cell(data);
				cell.index = i;
				cell.source = _model.getAt(i);
				add(cell);
				_cells.push(cell);
				addCellEvents(cell);
			}
		}

		/**
		 * @private
		 */
		protected function initCells() : void {
			_cells = new Array();
			for (var i : int = 0;i < _listData.rows;i++) {
				var data : GCellData = _listData.cellData.clone();
				data.y = i * (_cellHeight + _listData.hGap);
				data.enabled = false;
				var cell : GCell = new _cell(data);
				cell.index = i;
				add(cell);
				_cells.push(cell);
				addCellEvents(cell);
			}
		}

		/**
		 * @private
		 */
		protected function updateCells(start : int = 0) : void {
			var end : int = _model.size;
			var len : int = _cells.length;
			var cell : GCell;
			for (var i : int = start;i < len;i++) {
				cell = _cells[i] as GCell;
				if (i < end) {
					if (cell)
						cell.source = _model.getAt(i);
				} else {
					if (cell)
						cell.source = null;
				}
			}
		}

		/**
		 * @private
		 */
		protected function addCellEvents(cell : GCell) : void {
			if (_listData.cellData.allowDoubleClick) {
				cell.addEventListener(GCell.DOUBLE_CLICK, cell_doubleClickHandler);
			}
			cell.addEventListener(GCell.SINGLE_CLICK, cell_singleClickHandler);
		}

		/**
		 * @private
		 */
		protected function removeCellEvents(cell : GCell) : void {
			if (_listData.cellData.allowDoubleClick) {
				cell.removeEventListener(GCell.DOUBLE_CLICK, cell_doubleClickHandler);
			}
			cell.removeEventListener(GCell.SINGLE_CLICK, cell_singleClickHandler);
		}

		/**
		 * @private
		 */
		protected function selection_changeHandler(event : Event) : void {
			var cell : GCell;
			for each (cell in _selectedCells) {
				cell.selected = false;
			}
			_selectedCells.splice(0);
			cell = _cells[_selectionModel.index] as GCell;
			if (cell != null) {
				cell.selected = true;
				_selectedCells.push(cell);
			}
		}

		/**
		 * @private
		 */
		protected function cell_doubleClickHandler(event : Event) : void {
			dispatchEvent(event);
		}

		/**
		 * @private
		 */
		protected function cell_singleClickHandler(event : Event) : void {
			var cell : GCell = GCell(event.target);
			var index : int = _cells.indexOf(cell);
			if (index != -1 && _selectionModel.index != index) {
				_selectionModel.index = index;
			}
			dispatchEvent(event);
		}

		/**
		 * @private
		 */
		protected function model_changeHandler(event : GListEvent) : void {
			var cell : GCell;
			var data : GCellData;
			var i : int;
			var index : int = event.index;
			var item : Object = event.item;
			switch(event.state) {
				case ListState.RESET:
					var size : int = (_data.scaleMode == ScaleMode.AUTO_HEIGHT ? _model.size : (_model.max > 0 ? _model.max : _model.size));
					if (_cells.length != size) {
						removeCells();
						addCells();
						resetSize(_model.size);
						layout();
						_selectionModel.index = -1;
						dispatchEvent(new Event(Event.RESIZE));
					}
					updateCells();
					if (_selectionModel.index > _model.size) {
						_selectionModel.index = -1;
					}
					break;
				case ListState.ADDED:
					if (_model.max > 0) {
						GCell(_cells[index]).source = item;
						return;
					}
					data = _listData.cellData.clone();
					data.y = event.index * (_cellHeight + _listData.hGap);
					data.width = _viewRect.width;
					data.height = _cellHeight;
					cell = new _cell(data);
					cell.source = item;
					_cells.push(cell);
					addChild(cell);
					addCellEvents(cell);
					if (_data.scaleMode == ScaleMode.AUTO_HEIGHT) {
						height = _cellHeight * _model.size + (_model.size - 1) * _listData.hGap + _listData.padding * 2;
					} else {
						super.reset();
					}
					break;
				case ListState.REMOVED:
					if (_model.max > 0) {
						updateCells(event.index);
						if (event.index < _selectionModel.index || event.index == _selectionModel.index) {
							_selectionModel.index -= 1;
						}
						return;
					}
					cell = _cells[index];
					removeCellEvents(cell);
					cell.hide();
					_cells.splice(index, 1);
					for (i = index;i < _cells.length;i++) {
						GCell(_cells[i]).y -= _cellHeight + _listData.hGap;
					}
					if (index < _selectionModel.index || index == _selectionModel.index) {
						_selectionModel.index -= 1;
					}
					if (_data.scaleMode == ScaleMode.AUTO_HEIGHT) {
						height = _cellHeight * _model.size + (_model.size - 1) * _listData.hGap + _listData.padding * 2;
					} else {
						super.reset();
					}
					break;
				case ListState.UPDATE:
					cell = GCell(_cells[index]);
					cell.source = item;
					if (!item && _selectionModel.index == index) {
						_selectionModel.index = -1;
					}
					break;
				case ListState.INSERT:
					if (_model.max > 0) {
						updateCells(index);
						if (index <= _selectionModel.index) {
							_selectionModel.index += 1;
						}
						return;
					}
					data = _listData.cellData.clone();
					data.y = index * (_cellHeight + _listData.hGap);
					data.width = _viewRect.width;
					data.height = _cellHeight;
					cell = new _cell(data);
					cell.source = item;
					_cells.splice(index, 0, cell);
					addChild(cell);
					addCellEvents(cell);
					for (i = event.index + 1;i < _cells.length;i++) {
						GCell(_cells[i]).y += _cellHeight + _listData.hGap;
					}
					if (event.index <= _selectionModel.index) {
						_selectionModel.index += 1;
					}
					if (_data.scaleMode == ScaleMode.AUTO_HEIGHT) {
						height = _cellHeight * _model.size + (_model.size - 1) * _listData.hGap + _listData.padding * 2;
					} else {
						super.reset();
					}
					break;
				default:
					break;
			}
		}

		/**
		 * @private
		 */
		protected function addModelEvents() : void {
			_model.addEventListener(GListEvent.CHANGE, model_changeHandler);
			if (_listData.cellData.allowSelect) {
				_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
			}
		}

		/**
		 * @private
		 */
		protected function removeModelEvents() : void {
			_model.removeEventListener(GListEvent.CHANGE, model_changeHandler);
			if (_listData.cellData.allowSelect) {
				_selectionModel.removeEventListener(Event.CHANGE, selection_changeHandler);
			}
		}

		public function GList(data : GListData) {
			_listData = data;
			super(data);
			_model = new ListModel(false, _listData.rows);
			_selectionModel = new SelectionModel();
			addModelEvents();
		}

		/**
		 * @return 选择模型
		 */
		public function get selectionModel() : SelectionModel {
			return _selectionModel;
		}
		
		public function get cells () : Array {
			return _cells;
		}
		
		/**
		 * 设置列表模型
		 * 
		 * @param value 列表模型
		 */
		public function set model(value : ListModel) : void {
			if (_model != null) {
				removeModelEvents();
			}
			_model = value;
			if (_model != null) {
				addModelEvents();
				_model.update();
			}
		}

		/**
		 * @return 列表模型
		 */
		public function get model() : ListModel {
			return _model;
		}

		/**
		 * @return 被选中的单元格控件
		 */
		public function get selectionCell() : GCell {
			return _cells[_selectionModel.index];
		}

		/**
		 * 被选中的数据
		 * 
		 * @return 被选中的数据
		 */
		public function get selection() : Object {
			return _model.getAt(_selectionModel.index);
		}
	}
}