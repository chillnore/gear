package gear.gui.controls {
	import gear.gui.cell.GCell;
	import gear.gui.core.GBase;
	import gear.gui.model.GChange;
	import gear.gui.model.GChangeList;
	import gear.gui.model.GListModel;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * 列表控件
	 * 
	 * @author bright
	 * @version 20130121
	 */
	public class GList extends GBase {
		protected var _skin : IGSkin;
		protected var _content : Sprite;
		protected var _vScrollBar : GVScrollBar;
		protected var _scrollRect : Rectangle;
		protected var _selectedIndex : int;
		protected var _changes : GChangeList;
		protected var _model : GListModel;
		protected var _cellHeight : int;
		protected var _cell : Class;
		protected var _cells : Vector.<GCell>;

		override protected function preinit() : void {
			_skin = GUIUtil.theme.listSkin;
			_scrollRect = new Rectangle();
			_selectedIndex = -1;
			_changes = new GChangeList;
			_model = new GListModel();
			_model.onChange = onModelChange;
			_cells = new Vector.<GCell>();
			_cellHeight = 20;
			_cell = GCell;
			_padding.dist = 1;
			setSize(102, 102);
		}

		override protected function create() : void {
			_skin.addTo(this, 0);
			_content = new Sprite();
			_content.x = _padding.left;
			_content.y = _padding.right;
			addChild(_content);
			_vScrollBar = new GVScrollBar();
			_vScrollBar.visible = false;
			addChild(_vScrollBar);
		}

		override protected function resize() : void {
			_skin.setSize(_width, _height);
			_scrollRect.width = _width - (_vScrollBar.visible ? _vScrollBar.width : 0) - _padding.left - _padding.right;
			_scrollRect.height = _height - _padding.top - _padding.bottom;
			_content.scrollRect = _scrollRect;
			_vScrollBar.x = _width - _vScrollBar.width;
			_vScrollBar.height = _height;
			addRender(updateScroll);
		}

		override protected function onShow() : void {
			addEvent(this, MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		protected function mouseWheelHandler(event : MouseEvent) : void {
			_vScrollBar.value -= event.delta;
		}

		protected function onModelChange(change : GChange) : void {
			_changes.add(change);
			addRender(updateChanges);
		}

		protected function updateChanges() : void {
			var change : GChange;
			while (_changes.hasNext) {
				change = _changes.shift();
				switch(change.state) {
					case GChange.RESET:
						addRender(updateCells);
						break;
					case GChange.ADDED:
						if (change.index <= _selectedIndex) {
							_selectedIndex++;
						}
						addCell(change.index);
						moveCells(change.index, _cellHeight);
						addRender(updateScroll);
						break;
					case GChange.REMOVED:
						if (change.index < _selectedIndex) {
							_selectedIndex--;
						} else if (change.index == _selectedIndex) {
							selectedIndex = -1;
						}
						removeCell(change.index);
						moveCells(change.index - 1, -_cellHeight);
						addRender(updateScroll);
						break;
					case GChange.UPDATE:
						_cells[change.index].source = _model.getAt(change.index);
						break;
				}
			}
		}

		protected function updateCells() : void {
			if (_cells.length == _model.length) {
				var index : int = 0;
				var cell : GCell;
				for each (cell in _cells) {
					cell.source = _model.getAt(index++);
				}
				return;
			}
			var length : int = Math.max(_cells.length, _model.length);
			for (var i : int = 0;i < length;i++) {
				if (i >= _cells.length) {
					addCell(i);
					continue;
				}
				if (i >= _model.length) {
					removeCell(i);
					continue;
				}
				updateCell(i);
			}
			selectedIndex = -1;
			addRender(updateScroll);
		}

		protected function addCell(index : int) : void {
			var cell : GCell = new _cell();
			cell.y = index * _cellHeight;
			cell.width = _scrollRect.width;
			cell.source = _model.getAt(index);
			_content.addChild(cell);
			_cells.splice(index, 0, cell);
			addEvent(cell, MouseEvent.MOUSE_DOWN, cellMouseDownHandler);
		}

		protected function removeCell(index : int) : void {
			var cell : GCell = _cells[index];
			cell.hide();
			removeEvent(cell, MouseEvent.MOUSE_DOWN);
			_cells.splice(index, 1);
		}

		protected function moveCells(index : int, dy : int) : void {
			while (++index < _cells.length) {
				_cells[index].y += dy;
			}
		}

		protected function updateCell(index : int) : void {
			_cells[index].source = _model.getAt(index);
		}

		protected function cellMouseDownHandler(event : MouseEvent) : void {
			selectedIndex = _cells.indexOf(GCell(event.currentTarget));
		}

		protected function updateScroll() : void {
			var pageSize : int = _height / _cellHeight;
			var max : int = _cells.length - pageSize;
			if (max > 0) {
				_vScrollBar.setTo(pageSize, max, _scrollRect.y);
				if (!_vScrollBar.visible) {
					_scrollRect.width = _width - _vScrollBar.width - _padding.left - _padding.right;
					_content.scrollRect = _scrollRect;
					_vScrollBar.visible = true;
					_vScrollBar.onValueChange = onValueChange;
				}
			} else if (_vScrollBar.visible) {
				_scrollRect.width = _width - _padding.left - _padding.right;
				_content.scrollRect = _scrollRect;
				_vScrollBar.value = 0;
				_vScrollBar.visible = false;
				_vScrollBar.onValueChange = null;
			}
		}

		protected function onValueChange() : void {
			_scrollRect.y = _vScrollBar.value * _cellHeight;
			_content.scrollRect = _scrollRect;
		}

		public function GList() {
		}

		public function set model(value : GListModel) : void {
			if (_model == value) {
				return;
			}
			if (_model != null) {
				_model.removeOnChange(onModelChange);
			}
			_model = value;
			_model.onChange = onModelChange;
			addRender(updateCells);
		}

		public function get model() : GListModel {
			return _model;
		}

		public function set selectedIndex(value : int) : void {
			if (_selectedIndex == value) {
				return;
			}
			if (_selectedIndex > -1 && _selectedIndex < _cells.length) {
				_cells[_selectedIndex].selected = false;
			}
			_selectedIndex = value;
			if (_selectedIndex > -1 && _selectedIndex < _cells.length) {
				_cells[_selectedIndex].selected = true;
			}
		}

		public function get selectedIndex() : int {
			return _selectedIndex;
		}
	}
}
