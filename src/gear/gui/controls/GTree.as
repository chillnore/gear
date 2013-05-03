package gear.gui.controls {
	import gear.data.IGTreeNode;
	import gear.gui.cell.GTreeCell;
	import gear.gui.core.GBase;
	import gear.gui.model.GChangeList;
	import gear.gui.model.GTreeModel;
	import gear.gui.model.IGTreeCell;
	import gear.gui.model.events.GTreeModelEvent;
	import gear.gui.skins.GPanelSkin;
	import gear.gui.skins.GTreeIcon;
	import gear.gui.skins.IGSkin;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * 树控件
	 * 
	 * @author bright
	 * @version 20130502
	 */
	public class GTree extends GBase {
		protected var _bgSkin : IGSkin;
		protected var _openIcon : BitmapData;
		protected var _closeIcon : BitmapData;
		protected var _leafIcon : BitmapData;
		protected var _content : Sprite;
		protected var _vScrollBar : GVScrollBar;
		protected var _hScrollBar : GHScrollBar;
		protected var _scrollRect : Rectangle;
		protected var _selectedIndex : int;
		protected var _multipleSelection : Boolean;
		protected var _changes : GChangeList;
		protected var _model : GTreeModel;
		protected var _cells : Vector.<IGTreeCell>;
		protected var _cell : Class;
		protected var _template : IGTreeCell;
		protected var _indentation:int;

		override protected function preinit() : void {
			_bgSkin = GPanelSkin.skin;
			_openIcon = GTreeIcon.openIcon;
			_closeIcon = GTreeIcon.closeIcon;
			_leafIcon = GTreeIcon.leafIcon;
			_scrollRect = new Rectangle();
			_selectedIndex = -1;
			_multipleSelection = false;
			_changes = new GChangeList;
			_model = new GTreeModel();
			_model.addEventListener(GTreeModelEvent.RESET, onModelHandler);
			_model.addEventListener(GTreeModelEvent.REMOVE, onModelHandler);
			_model.addEventListener(GTreeModelEvent.INSERT, onModelHandler);
			_cells = new Vector.<IGTreeCell>();
			_cell = GTreeCell;
			_padding.dist = 1;
			_template = new _cell();
			_indentation=10;
			setSize(100, 100);
		}

		override protected function create() : void {
			_bgSkin.addTo(this, 0);
			_content = new Sprite();
			_content.name = "content";
			_content.x = _padding.left;
			_content.y = _padding.right;
			addChild(_content);
			_vScrollBar = new GVScrollBar();
			_vScrollBar.visible = false;
			addChild(_vScrollBar);
		}

		override protected function resize() : void {
			_bgSkin.setSize(_width, _height);
			_scrollRect.width = _width - (_vScrollBar.visible ? _vScrollBar.width : 0) - _padding.left - _padding.right;
			_scrollRect.height = _height - _padding.top - _padding.bottom;
			_content.scrollRect = _scrollRect;
			_vScrollBar.x = _width - _vScrollBar.width;
			_vScrollBar.height = _height;
			callLater(updateScroll);
		}

		override protected function onShow() : void {
			addEvent(this, MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		protected function mouseWheelHandler(event : MouseEvent) : void {
			_vScrollBar.value -= event.delta;
		}

		protected function updateScroll() : void {
			var pageSize : int = _height / _template.height;
			var max : int = _content.numChildren - pageSize;
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
			_scrollRect.y = _vScrollBar.value * _template.height;
			_content.scrollRect = _scrollRect;
		}

		protected function updateCells() : void {
			while (_cells.length > 0) {
				removeCell(_cells.shift());
			}
			if (_model.rootNode == null) {
				return;
			}
			var node : IGTreeNode;
			for (var i : int = 0; i < _model.rootNode.numChildren; i++) {
				node = _model.rootNode.getChildAt(i);
				node.async();
				addCell(i, node);
			}
		}

		protected function addCell(index : int, node : IGTreeNode) : void {
			var cell : IGTreeCell = new _cell();
			cell.x = node.depth * _indentation;
			cell.y = index * _template.height;
			cell.width = _scrollRect.width;
			_content.addChild(DisplayObject(cell));
			cell.source = node;
			if (node.numChildren < 1) {
				cell.icon = _leafIcon;
			} else {
				cell.icon = node.expanded ? _openIcon : _closeIcon;
			}
			_cells.splice(index, 0, cell);
			addEvent(cell, MouseEvent.MOUSE_DOWN, cell_mouseDownHandler);
			addEvent(cell, MouseEvent.CLICK, cell_clickHandler);
		}

		protected function removeCell(index : int) : void {
			if (index < 0 || index >= _cells.length) {
				return;
			}
			var cell : IGTreeCell = _cells[index];
			cell.hide();
			_cells.splice(index, 1);
		}

		protected function expandCell(cell : IGTreeCell) : void {
			var node : IGTreeNode = cell.source;
			if (node.numChildren < 1) {
				return;
			}
			node.expanded = true;
			var childrens : Vector.<IGTreeNode>=node.childrens.slice();
			var index : int = _cells.indexOf(cell) + 1;
			_cells[index - 1].icon = _openIcon;
			var total : int = 0;
			while (childrens.length > 0) {
				node = childrens.shift();
				node.async();
				addCell(index + total, node);
				if (node.expanded) {
					for each (node in node.childrens) {
						childrens.unshift(node);
					}
				}
				total++;
			}
			moveCells(index + total, total * _template.height);
			callLater(updateScroll);
		}

		protected function closeCell(cell : IGTreeCell) : void {
			var node : IGTreeNode = cell.source;
			if (node.numChildren < 1) {
				return;
			}
			node.expanded = false;
			var childrens : Vector.<IGTreeNode>=node.childrens.slice();
			var index : int = _cells.indexOf(cell) + 1;
			_cells[index - 1].icon = _closeIcon;
			var total : int = 0;
			while (childrens.length > 0) {
				node = childrens.shift();
				removeCell(index);
				if (node.expanded) {
					for each (node in node.childrens) {
						childrens.unshift(node);
					}
				}
				total++;
			}
			moveCells(index, -total * _template.height);
			callLater(updateScroll);
		}

		protected function moveCells(index : int, dy : int) : void {
			while (index < _cells.length) {
				_cells[index].y += dy;
				index++;
			}
		}

		protected function cell_mouseDownHandler(event : MouseEvent) : void {
			var cell : IGTreeCell = IGTreeCell(event.currentTarget);
			selectedIndex = _cells.indexOf(cell);
			var node:IGTreeNode=cell.source;
			node.async();
			if (node.numChildren < 1) {
				return;
			}
			if (!node.expanded) {
				expandCell(cell);
			} else {
				closeCell(cell);
			}
		}

		protected function cell_clickHandler(event : MouseEvent) : void {
		}

		protected function onModelHandler(event : GTreeModelEvent) : void {
			var cell : IGTreeCell;
			var index : int = 0;
			if (event.type == GTreeModelEvent.RESET) {
				callLater(updateCells);
			} else if (event.type == GTreeModelEvent.REMOVE) {
				for each (cell in _cells) {
					if (cell.source == event.node) {
						if (event.node.expanded) {
							closeCell(cell);
						}
						if (_selectedIndex == index) {
							selectedIndex = -1;
						}
						removeCell(index);
						moveCells(index, - _template.height);
						if (event.node.parent.expanded && event.node.parent.numChildren < 1) {
							for each (cell in _cells) {
								if (cell.source == event.node.parent) {
									cell.icon = _leafIcon;
								}
							}
						}
						break;
					}
					index++;
				}
			} else if (event.type == GTreeModelEvent.INSERT) {
				index = 0;
				for each (cell in _cells) {
					if (cell.source == event.node.parent) {
						if (cell.source.isOpen) {
							addCell(index + event.index+1, event.node);
							moveCells(index + event.index + 2, _template.height);
							break;
						}
					}
					index++;
				}
			}
		}

		public function GTree() {
		}

		public function get model() : GTreeModel {
			return _model;
		}

		public function set selectedIndex(value : int) : void {
			if (_selectedIndex == value) {
				return;
			}
			if (!_multipleSelection && _selectedIndex > -1 && _selectedIndex < _cells.length) {
				_cells[_selectedIndex].selected = false;
			}
			_selectedIndex = value;
			if (!_multipleSelection && _selectedIndex > -1 && _selectedIndex < _cells.length) {
				_cells[_selectedIndex].selected = true;
			}
		}

		public function get selectedIndex() : int {
			return _selectedIndex;
		}

		public function get selection() : IGTreeNode {
			if (_selectedIndex < 0 || _selectedIndex >= _cells.length) {
				return null;
			}
			return _cells[_selectedIndex].source;
		}

		public function get selectedItems() : Vector.<IGTreeNode> {
			var result : Vector.<IGTreeNode>=new Vector.<IGTreeNode>();
			for each (var cell : IGTreeCell in _cells) {
				if (cell.selected) {
					result.push(cell.source);
				}
			}
			return result;
		}
	}
}
