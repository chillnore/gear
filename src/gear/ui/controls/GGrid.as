package gear.ui.controls {
	import gear.ui.cell.GCell;
	import gear.ui.cell.GCellData;
	import gear.ui.containers.GPanel;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GAlertData;
	import gear.ui.data.GGridData;
	import gear.ui.data.GTextInputData;
	import gear.ui.drag.DragData;
	import gear.ui.drag.DragModel;
	import gear.ui.drag.DragState;
	import gear.ui.drag.IDragItem;
	import gear.ui.drag.IDragSource;
	import gear.ui.drag.IDragTarget;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.GUIUtil;
	import gear.ui.model.GListEvent;
	import gear.ui.model.ListModel;
	import gear.ui.model.ListState;
	import gear.ui.model.PageModel;
	import gear.ui.model.SelectionModel;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	/**
	 * 格子控件
	 * 
	 * @author bright
	 * @version 20101214
	 */
	public class GGrid extends GPanel implements IDragTarget {
		public static const CELL_MOVE : String = "CELL_MOVE";
		/**
		 * @private
		 */
		protected var _gridData : GGridData;
		/**
		 * @private
		 */
		protected var _dragModel : DragModel;
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
		protected var _pageModel : PageModel;
		/**
		 * @private
		 */
		protected var _cell : Class;
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
		protected var _cells : Array;
		/**
		 * @private
		 */
		protected var _selectedCells : Array;
		/**
		 * @private
		 */
		protected var _dragData : DragData;
		/**
		 * @private
		 */
		protected var _dragCell : GCell;
		/**
		 * @private
		 */
		protected var _dragImage : GIcon;
		/**
		 * @private
		 */
		protected var _split_alert : GAlert;
		/**
		 * @private
		 */
		protected var _remove_alert : GAlert;
		/**
		 * @private
		 */
		protected var _refs : Array;
		// 当拖动的时候是否已经把拖动的ui添加到场景中了
		protected var _isAddMouseIcon : Boolean = false;
		// 是否允许增加格子
		protected var _isCanAddCell : Boolean = false;
		
		protected var _isCanRemove : Boolean = true;

		/**
		 * @private
		 */
		override protected function init() : void {
			_cell = _gridData.cell;
			_cells = new Array();
			_selectedCells = new Array();
			_refs = new Array();
			super.init();
		}

		/**
		 * @private
		 */
		override protected function create() : void {
			super.create();
			var templet : GCell = new _cell(_gridData.cellData);
			_cellWidth = templet.width;
			_cellHeight = templet.height;
			if (_data.scaleMode == GScaleMode.AUTO_SIZE) {
				_width = _cellWidth * _gridData.columns + (_gridData.columns - 1) * _gridData.hgap + _gridData.padding * 2;
				_height = _cellHeight * _gridData.rows + (_gridData.rows - 1) * _gridData.vgap + _gridData.padding * 2;
			}
			initCells();
			if (_gridData.allowDrag) {
				addGAlerts();
			}
		}

		/**
		 * @private
		 */
		protected function addGAlerts() : void {
			_remove_alert = new GAlert(_gridData.alertData);
			_remove_alert.addEventListener(Event.CLOSE, remove_closeHandler);
			var data : GAlertData = _gridData.alertData.clone();
			data.labelData.text = "请输入拆分数量:";
			data.textInputData = new GTextInputData();
			data.textInputData.width = 150;
			data.textInputData.restrict = "0-9";
			data.textInputData.maxChars = 2;
			data.flag = GAlert.OK | GAlert.CANCEL;
			_split_alert = new GAlert(data);
			_split_alert.addEventListener(Event.CLOSE, split_closeHandler);
		}

		/**
		 * @private
		 */
		protected function initCells() : void {
			_cells = new Array();
			var index : int = 0;
			for (var row : int = 0;row < _gridData.rows;row++) {
				for (var column : int = 0;column < _gridData.columns;column++) {
					var data : GCellData = _gridData.cellData.clone();
					data.x = column * (_cellWidth + _gridData.hgap);
					data.y = row * (_cellHeight + _gridData.vgap);
					data.width = _cellWidth;
					data.height = _cellHeight;
					data.enabled = false;
					if (_gridData.hotKeys != null && index < _gridData.hotKeys.length) {
						data.hotKey = _gridData.hotKeys[index];
					}
					if (_model != null && _model.limit > 0 && _cells.length >= _model.limit) {
						data.lock = true;
					}
					var cell : GCell = new _cell(data);
					add(cell);
					_cells.push(cell);
					addCellEvents(cell);
					index++;
				}
			}
		}

		/**
		 * @private
		 */
		protected function updateCells(index : int = 0, length : int = -1) : void {
			var start : int = _pageModel.getPageIndex(index);
			var end : int = _pageModel.currentSize;
			if (length != -1) {
				end = Math.min(end, _pageModel.getPageIndex(index + length));
			}
			var len : int = _cells.length;
			var cell : GCell;
			var base : int = _pageModel.base;
			for (var i : int = start;i < len;i++) {
				cell = GCell(_cells[i]);
				if (cell == null) {
					continue;
				}
				// cell.lock = (_model.limit > 0 && (base + i) >= _model.limit);
				if (i < end) {
					cell.source = _model.getAt(base + i);
				} else {
					if (length == -1) {
						cell.source = null;
					} else if (i >= _pageModel.currentSize) {
						cell.source = null;
					}
				}
			}
		}

		/**
		 * @private
		 */
		protected function addCellEvents(cell : GCell) : void {
			if (_gridData.cellData.allowDoubleClick) {
				cell.addEventListener(GCell.DOUBLE_CLICK, cell_doubleClickHandler);
			}
			cell.addEventListener(GCell.SINGLE_CLICK, cell_singleClickHandler);
			cell.addEventListener(CELL_MOVE, cell_dragHandler);
			cell.addEventListener(MouseEvent.MOUSE_UP, cell_Up);
			cell.addEventListener(MouseEvent.MOUSE_DOWN, cell_Down);
		}

		override protected function onHide() : void {
			super.onHide();
			if (_split_alert)
				_split_alert.hide();
			if (_dragImage != null) {
				dragEnd();
			}
		}

		private function cell_Up(event : MouseEvent) : void {
			var index : int = _cells.indexOf(event.currentTarget) ;
			// + _model.offset ;
			if (index != -1) {
				_selectionModel.index = _pageModel.base + index;
			}
			// 判断是否需要快捷键
			if (GCell(event.currentTarget).ctrlKey) {
				dispatchEvent(event);
				return;
			}
			if (_dragCell == null || _dragCell.source == null) return;
			if (_gridData.allowDrag) {
				if (_dragCell.source.canDragEnter(null, _model.place) == false) {
					return;
				}
				// 为cell添加事件
				GUIUtil.root.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				GUIUtil.root.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				_dragCell = GCell(event.currentTarget);
				//if (_dragCell.toolTip != null) _dragCell.toolTip.hide();
				if (_dragCell is IDragSource && _dragCell.source is IDragItem) {
					// 取出cell的数据
					_dragData.reset(this, _dragCell.source);
					dragStart();
				}
			}
			dispatchEvent(event);
		}

		private function cell_dragHandler(event : Event) : void {
			if (_gridData.allowDrag) {
				_dragCell = GCell(event.currentTarget);
				if (!IDragSource(_dragCell).canDrag()) return;
				//if (_dragCell.toolTip != null) _dragCell.toolTip.hide();
				if (_dragCell is IDragSource && _dragCell.source is IDragItem) {
					_dragData.reset(this, _dragCell.source);
					dragStart();
				}
			}
			dispatchEvent(new Event(GCell.SINGLE_CLICK));
		}

		private function cell_Down(event : Event) : void {
			if (_gridData.allowDrag) {
				_dragCell = GCell(event.currentTarget);
				if (_dragCell == null || _dragCell.source == null) return;
				// if (_dragCell.source.canDragEnter(null, _model.place) == false) {
				// return;
				// }
				if (!IDragSource(_dragCell).canDrag() || _dragCell == null || _dragCell.source == null) return;
				//if (_dragCell.toolTip != null) _dragCell.toolTip.hide();
				_dragImage = IDragSource(_dragCell).dragImage;
				// 复制拖动的数据
				_dragData.reset(this, _dragCell.source);
				// dragStart();
				_isAddMouseIcon = false;
				var index : int = _cells.indexOf(_dragCell) ;
				// + _model.offset ;
				if (index != -1) {
					_selectionModel.index = _pageModel.base + index;
				}
				GUIUtil.root.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				GUIUtil.root.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
		}

		/**
		 * @private
		 */
		protected function removeCellEvents(cell : GCell) : void {
			if (_gridData.cellData.allowDoubleClick) {
				cell.removeEventListener(GCell.DOUBLE_CLICK, cell_doubleClickHandler);
			}
			cell.removeEventListener(GCell.SINGLE_CLICK, cell_singleClickHandler);
			cell.removeEventListener(CELL_MOVE, cell_dragHandler);
			cell.removeEventListener(MouseEvent.MOUSE_DOWN, cell_dragHandler);
			cell.removeEventListener(MouseEvent.MOUSE_UP, cell_dragHandler);
		}

		/**
		 * @private
		 */
		protected function cell_doubleClickHandler(event : Event) : void {
			var index : int = _cells.indexOf(event.target);
			if (index != -1) {
				_selectionModel.index = _pageModel.base + index;
			}
			dispatchEvent(event);
		}

		/**
		 * @private
		 */
		protected function cell_singleClickHandler(event : Event) : void {
			var index : int = _cells.indexOf(event.target);
			if (index != -1) {
				_selectionModel.index = _pageModel.base + index;
			}
			if (GCell(event.target).ctrlKey) {
				dispatchEvent(event);
				return;
			}
			if (_gridData.allowDrag) {
				_dragCell = GCell(event.target);
				if (_dragCell is IDragSource && _dragCell.source is IDragItem) {
					_dragData.reset(this, _dragCell.source);
					if (GCell(event.target).shiftKey) {
						if (_dragData.source.count > 1 && _dragData.source.max > 1) {
							_split_alert.inputText = "1";
							_split_alert.show();

							_split_alert.moveTo(stage.mouseX, stage.mouseY);
							return;
						}
					} else {
						// dragStart();
					}
				}
			}
			dispatchEvent(event);
		}

		/**
		 * @private
		 */
		protected function stage_mouseMoveHandler(event : MouseEvent) : void {
			if (_isAddMouseIcon == false) {
				_dragCell.enabled = false;
				GUIUtil.dragModal = true;
				GUIUtil.root.stage.addChild(_dragImage);
				Mouse.hide();
				_isAddMouseIcon = true;
			}
			if (_dragImage != null) {
				_dragImage.x = int(event.stageX - _dragImage.width * 0.5);
				_dragImage.y = int(event.stageY - _dragImage.height * 0.5);
			}
		}

		/**
		 * @private
		 */
		override protected function stage_mouseUpHandler(event : MouseEvent) : void {
			var hitTarget : DisplayObject = GUIUtil.hitTest(stage.mouseX, stage.mouseY);
			if (_dragImage != null) {
				if (GUIUtil.atParent(hitTarget, this)) {
					if (!_model.allowNull) {
						if (_dragData.split != null) {
							_dragData.source.count += _dragData.split.count;
						}
						dragEnd();
						return;
					}
					var c : int = _content.mouseX / (_gridData.cellData.width + _gridData.hgap);
					var r : int = _content.mouseY / (_gridData.cellData.height + _gridData.vgap);
					c = Math.max(0, Math.min(_gridData.columns - 1, c));
					r = Math.max(0, Math.min(_gridData.rows - 1, r));
					var index : int = _pageModel.base + r * _gridData.columns + c;
					_dragData.t_place = _model.place;
					_dragData.t_grid = index;
					if (_model.max > 0 && index >= _model.max) {
						if (_dragData.split != null) {
							_dragData.source.count += _dragData.split.count;
						}
						dragEnd();
						return;
					}
					var target : IDragItem = IDragItem(_model.getAt(index));
					if (target == null) {
						if (_dragData.split == null) {
							_model.setAt(_dragData.s_grid, null);
							_model.setAt(index, _dragData.source);
						} else {
							_model.setAt(index, _dragData.split);
						}
					} else {
						if (target == _dragData.source) {
							dragEnd();
							return;
						}
						if (_dragData.split == null) {
							if (_dragData.source && _dragData.source.canDragEnter(target, _model.place) == false) {
								_dragData.state = DragState.CANCEL;
								return;
							}
							if (target.merge(_dragData.source)) {
								if (_dragData.source.count == 0) {
									_model.setAt(_dragData.source.grid, null);
								} else {
									target.count += _dragData.source.count ;
									_model.update(target.grid);
									_model.setAt(_dragData.source.grid, null);
								}
							} else {
								_model.setAt(_dragData.source.grid, target);
								_model.setAt(index, _dragData.source);
							}
						} else {
							if (target.merge(_dragData.split)) {
								if (_dragData.split.count > 0) {
									_dragData.source.count += _dragData.split.count;
								} else if (_dragData.source.count == 0) {
									_model.setAt(_dragData.source.grid, null);
								}
							} else {
								_dragData.source.count += _dragData.split.count;
								dragEnd();
								return;
							}
						}
					}
				} else {
					_dragData.hitTarget = hitTarget;
					_dragData.stageX = stage.mouseX;
					_dragData.stageY = stage.mouseY;
					_dragModel.check(_dragData);
					// if (!dragActionHandler && hitTarget == null)
					// {
					// var temp : DragUiEvent = new DragUiEvent( DragUiEvent.REMOVE );
					// temp.source = _dragData.source;
					//						//  temp.////sourceIndex = _dragData.s_place;
					// dispatchEvent( temp );
					// _dragData.state = DragState.END;
					// }

					// 当gird组件拖动到别的gird组件的时候，判断下是否允许拖进去的

					if (_dragData.state == DragState.NEXT) {
						return;
					}
					if (_dragData.state == DragState.END) {
						dragEnd();
						return;
					}
					if (_dragData.state == DragState.REMOVE&&_isCanRemove) {
						dragEnd();
						var count : int = (_dragData.split == null ? _dragData.source.count : _dragData.splitCount);
						_remove_alert.label = "你真的要删除 [" + _dragData.source.name + "] " + count + "个?";
						_remove_alert.show();
						GLayout.layout(_remove_alert);
						return;
					}
					if (_dragData.state == DragState.MOVE) {
						if (_dragData.split == null) {
							_model.setAt(_dragData.s_grid, _dragData.target);
						}
					} else if (_dragData.state == DragState.MERGE) {
						if (_dragData.split == null && _dragData.source.count == 0) {
							_model.setAt(_dragData.s_grid, null);
						}
					} else if (_dragData.state == DragState.CANCEL) {
						if (_dragData.split != null) {
							_dragData.source.count += _dragData.split.count;
						}
					}
				}
				dragEnd();
				if (_dragData.state != DragState.CANCEL)
					_dragData.source.syncMove(_dragData.s_place, _dragData.s_grid, _dragData.t_place, _dragData.t_grid, _dragData.split == null ? "" : _dragData.split.key, _dragData.splitCount);
			} else {
				if (!GUIUtil.atParent(hitTarget, this)) {
					var outside : Boolean = true;
					if (GUIUtil.atParent(hitTarget, _menuTrigger)) {
						outside = false;
					}
					if (outside) {
						hide();
					}
				}
			}
		}

		override protected function onEnabled() : void {
			for each (var cell:GCell in _cells) {
				if (cell.source != null) {
					cell.enabled = _enabled;
				}
			}
		}

		private function dragStart() : void {
			GUIUtil.dragModal = true;
			_dragCell.enabled = false;
			_dragImage = IDragSource(_dragCell).dragImage;
			stage.addChild(_dragImage);
			_dragImage.x = int(stage.mouseX - _dragImage.width * 0.5);
			_dragImage.y = int(stage.mouseY - _dragImage.height * 0.5);
			trace("开始x:", _dragImage.x, " y:", _dragImage.y);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			if (!stage.hasEventListener(MouseEvent.MOUSE_UP)) {
				stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
			Mouse.hide();
		}

		private function dragEnd() : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			if (stage.hasEventListener(MouseEvent.MOUSE_UP) && _menuTrigger == null) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
			GUIUtil.dragModal = false;
			if (_dragImage.parent) _dragImage.parent.removeChild(_dragImage);
			_dragImage = null;
			if (_dragCell.source != null && _refs.indexOf(_dragCell.source) == -1) {
				_dragCell.enabled = true;
			}
			Mouse.show();
		}

		private function remove_closeHandler(event : Event) : void {
			var detail : uint = _remove_alert.detail;
			if (detail == GAlert.YES) {
				if (_dragData.split == null) {
					// _model.setAt(_selectionModel.index, null);
					IDragItem(_dragData.source).syncRemove();
				} else {
					IDragItem(_dragData.source).syncRemove(_dragData.split.count);
				}
			} else if (detail == GAlert.NO) {
				if (_dragData.split != null) {
					_dragData.source.count += _dragData.split.count;
				}
			}
		}

		private function split_closeHandler(event : Event) : void {
			var detail : uint = _split_alert.detail;
			if (detail == GAlert.OK) {
				var count : int = int(_split_alert.inputText);
				count = Math.max(0, Math.min(_dragData.source.count, count));
				if (count <= 0) {
					return;
				} else if (count < _dragData.source.count) {
					_dragData.split = _dragData.source.split(count);
					_dragData.splitCount = count;
					dragStart();
				} else {
					dragStart();
				}
			}
		}

		/**
		 * @private
		 */
		protected function model_changeHandler(event : GListEvent) : void {
			var cell : GCell;
			var state : int = event.state;
			var index : int = event.index;
			var length : int = event.length;
			var item : Object = event.item;
			var oldItem : Object = event.oldItem;
			switch(state) {
				case ListState.RESET:
					updateCells(index, length);
					_selectionModel.index = -1;
					break;
				case ListState.ADDED:
					if (!_pageModel.atCurrentPage(index)) {
						return;
					}
					cell = _cells[_pageModel.getPageIndex(index)] as GCell;
					if (cell != null) {
						cell.source = item;
					}
					break;
				case ListState.REMOVED:
					if (!_pageModel.atCurrentPage(index)) {
						return;
					}
					updateCells(index);
					if (index < _selectionModel.index || index == _selectionModel.index) {
						_selectionModel.index -= 1;
					}
					break;
				case ListState.UPDATE:
					if (!_pageModel.atCurrentPage(index)) {
						return;
					}
					cell = _cells[_pageModel.getPageIndex(index)] as GCell;
					if (cell != null) {
						cell.source = item;
						if (cell.source != null && _refs.indexOf(cell.source) != -1) {
							cell.enabled = false;
						}
					}
					var i : int = _refs.indexOf(oldItem);
					if (oldItem != null && i != -1) {
						_refs.splice(i, 1);
					}
					if (item == null && _selectionModel.index == index) {
						_selectionModel.index = -1;
					}
					break;
				case ListState.INSERT:
					if (!_pageModel.atCurrentPage(index)) {
						return;
					}
					updateCells(index);
					if (index <= _selectionModel.index) {
						_selectionModel.index += 1;
					}
					break;
				default:
					break;
			}
		}

		protected function model_resizeChangeHandler(event : Event) : void {
			updateCells(_pageModel.base);
			resetSelected();
			if (_model.max > _cells.length && _isCanAddCell) {
				addCells(_model.max - _cells.length);
			}
			_pageModel.pageSize = _cells.length;
		}

		// 临时项目需要的方法  背包添加格子
		protected function addCells(cellSize : int) : void {
			var index : int = 0;
			var nowRow : int = _cells.length / _gridData.columns;
			var newRow : int = cellSize / _gridData.columns + nowRow;
			_gridData.rows = newRow;
			for (nowRow ;nowRow < newRow ;nowRow++) {
				for (var column : int = 0;column < _gridData.columns;column++) {
					var data : GCellData = _gridData.cellData.clone();
					data.x = column * (_cellWidth + _gridData.hgap);
					data.y = nowRow * (_cellHeight + _gridData.vgap);
					data.width = _cellWidth;
					data.height = _cellHeight;
					data.enabled = false;
					if (_gridData.hotKeys != null && index < _gridData.hotKeys.length) {
						data.hotKey = _gridData.hotKeys[index];
					}
					if (_model != null && _model.max > 0 && _cells.length >= _model.max) {
						data.lock = true;
					}
					var cell : GCell = new _cell(data);
					add(cell);
					_cells.push(cell);
					addCellEvents(cell);
					index++;
				}
			}
		}

		/**
		 * @private
		 */
		protected function page_changeHandler(event : Event) : void {
			updateCells(_pageModel.base);
			resetSelected();
		}

		/**
		 * @private
		 */
		protected function selection_changeHandler(event : Event) : void {
			resetSelected();
		}

		/**
		 * @private
		 */
		protected function resetSelected() : void {
			var cell : GCell;
			for each (cell in _selectedCells) {
				cell.selected = false;
			}
			_selectedCells.splice(0);
			if (!_pageModel.atCurrentPage(_selectionModel.index)) {
				_selectionModel.index = -1;
				return;
			}
			var index : int = _pageModel.getPageIndex(_selectionModel.index);
			cell = _cells[index] as GCell;
			if (cell != null) {
				cell.selected = true;
				_selectedCells.push(cell);
			}
		}

		/**
		 * @private
		 */
		protected function addModelEvents() : void {
			_model.addEventListener(GListEvent.CHANGE, model_changeHandler);
			_model.addEventListener(Event.RESIZE, model_resizeChangeHandler);
			if (_gridData.cellData.allowSelect) {
				_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
			}
		}

		/**
		 * @private
		 */
		protected function removeModelEvents() : void {
			_model.removeEventListener(GListEvent.CHANGE, model_changeHandler);
			_model.removeEventListener(Event.RESIZE, model_resizeChangeHandler);
			if (_gridData.cellData.allowSelect) {
				_selectionModel.removeEventListener(Event.CHANGE, selection_changeHandler);
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GGrid(data : GGridData) {
			_gridData = data;
			super(data);
			_selectionModel = new SelectionModel();
			_dragModel = new DragModel();
			_dragData = new DragData();
			_model = new ListModel(true);
			_pageModel = new PageModel(_gridData.rows * _gridData.columns, _model);
			_pageModel.addEventListener(PageModel.PAGE_CHANGE, page_changeHandler);
			addModelEvents();
		}

		/**
		 * @param value ListModel 设置列表模型
		 */
		public function set model(value : ListModel) : void {
			if (_model != null) {
				removeModelEvents();
			}
			_model = value;
			if (_model && _model.max > _cells.length && _isCanAddCell) {
				addCells(_model.max - _cells.length);
			}
			_pageModel.pageSize = _cells.length;
			_pageModel.listModel = model;
			if (_model != null) {
				addModelEvents();
				_model.update();
			}
		}

		/**
		 * @param ListModel 
		 */
		public function get model() : ListModel {
			return _model;
		}

		/**
		 * @return SelectionModel 选择
		 */
		public function get selectionModel() : SelectionModel {
			return _selectionModel;
		}

		/**
		 * @return DragModel 拖动模型
		 */
		public function get dragModel() : DragModel {
			return _dragModel;
		}

		public function set pageModel(value : PageModel) : void {
			if (_pageModel != null) {
				_pageModel.removeEventListener(PageModel.PAGE_CHANGE, page_changeHandler);
			}
			_pageModel = value;
			_pageModel.pageSize = _gridData.rows * _gridData.columns;
			_pageModel.listModel = _model;
			_pageModel.addEventListener(PageModel.PAGE_CHANGE, page_changeHandler);
		}

		/**
		 * @return PageModel 分页模型
		 */
		public function get pageModel() : PageModel {
			return _pageModel;
		}

		/**
		 * @param index 索引
		 * @return 单元格控件
		 */
		public function getCellBy(index : int) : GCell {
			return _cells[index];
		}

		/**
		 * 获得首次匹配的单元格控件
		 * 
		 * @return 首次匹配的单元格控件
		 */
		public function indeOfCell(cell : GCell) : int {
			return _cells.indexOf(cell);
		}

		/**
		 * 获得单元格总数
		 * 
		 * @return 单元格总数
		 */
		public function getCellSize() : int {
			return _cells.length;
		}

		/**
		 * 获得选中的单元格控件
		 * 
		 * @return 选中的单元格控件
		 */
		public function get selectionCell() : GCell {
			return _cells[_pageModel.getPageIndex(_selectionModel.index)];
		}

		/**
		 * 获得选中对象
		 * @return 选中对象
		 */
		public function get selection() : Object {
			return _model.getAt(_selectionModel.index);
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		public function dragEnter(dragData : DragData) : Boolean {
			if (!GUIUtil.atParent(dragData.hitTarget, this)) {
				return false;
			}

			var c : int = _content.mouseX / (_gridData.cellData.width + _gridData.hgap);
			var r : int = _content.mouseY / (_gridData.cellData.height + _gridData.vgap);
			// var local : Point = globalToLocal(new Point(dragData.stageX, dragData.stageY));
			// var c : int = (local.x - _gridData.padding) / (_gridData.cellData.width + _gridData.hgap);
			// var r : int = (local.y - _gridData.padding) / (_gridData.cellData.height + _gridData.vgap);
			c = Math.max(0, Math.min(_gridData.columns - 1, c));
			r = Math.max(0, Math.min(_gridData.rows - 1, r));
			var index : int = _pageModel.base + r * _gridData.columns + c;

			dragData.t_place = _model.place;
			dragData.t_grid = index;
			if (_model.max != -1 && index >= _model.max) {
				dragData.state = DragState.CANCEL;
				return true;
			}
			var target : IDragItem = _model.getAt(index) as IDragItem;
			// 当gird组件拖动到别的gird组件的时候，判断下是否允许拖进去的，是否需要继续处理
			if (dragData.source && dragData.source.canDragEnter(target, _model.place) == false) {
				dragData.state = DragState.CANCEL;
				return true;
			}
			if (target == null) {
				dragData.state = DragState.MOVE;
				_model.setAt(index, dragData.split == null ? dragData.source : dragData.split);
				return true;
			} else {
				if (dragData.split == null) {
					if (target.merge(dragData.source)) {
						dragData.state = DragState.MERGE;
						return true;
					}
					if (dragData.owner.canSwap(dragData.source, target)) {
						_model.setAt(index, dragData.source);
						dragData.state = DragState.MOVE;
						dragData.target = target;
						return true;
					}
					dragData.state = DragState.CANCEL;
					return true;
				} else {
					if (target.merge(dragData.split)) {
						if (dragData.split.count > 0) {
							dragData.source.count += dragData.split.count;
						}
						dragData.state = DragState.MERGE;
						return true;
					}
					dragData.state = DragState.CANCEL;
					return true;
				}
			}
			return true;
		}

		public function canSwap(source : IDragItem, target : IDragItem) : Boolean {
			return true;
		}

		/**
		 * @private
		 * 加入映射
		 * @param value 映射对象
		 */
		public function addRef(value : Object) : void {
			if (_refs.indexOf(value) != -1) {
				return;
			}
			_refs.push(value);
			var cell : GCell;
			cell = getCellBy(_model.indexOf(value));
			if (cell != null) {
				cell.enabled = false;
			}
		}

		/**
		 * @private
		 * 移除映射
		 * @param value 映射对象
		 */
		public function removeRef(value : Object) : void {
			var index : int = _refs.indexOf(value);
			if (index == -1) {
				return;
			}
			_refs.splice(index, 1);
			var cell : GCell;
			cell = _cells[_model.indexOf(value)];
			if (cell != null) {
				cell.enabled = true;
			}
		}

		/**
		 * @private
		 * 获得映射列表
		 * @return 映射列表
		 */
		public function getRefs() : Array {
			return _refs;
		}

		public function set isCanAddCell(value : Boolean) : void {
			_isCanAddCell = value;
		}

		public function get gridData() : GGridData {
			return _gridData;
		}

		public function set isCanRemove(isCanRemove : Boolean) : void {
			_isCanRemove = isCanRemove;
		}
	}
}
