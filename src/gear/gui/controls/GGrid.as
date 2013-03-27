package gear.gui.controls {
	import gear.gui.cell.GCell;
	import gear.gui.core.GAutoSize;
	import gear.gui.core.GBase;
	import gear.gui.model.GChange;
	import gear.gui.model.GChangeList;
	import gear.gui.model.GGridModel;
	import gear.log4a.GLogger;

	/**
	 * 网格控件
	 * 
	 * @author bright
	 * @version 20130327
	 */
	public class GGrid extends GBase {
		protected var _cols : int;
		protected var _rows : int;
		protected var _hgap : int;
		protected var _vgap : int;
		protected var _cell : Class;
		protected var _cellW : int;
		protected var _cellH : int;
		protected var _cells : Vector.<GCell>;
		protected var _hotKeys : Vector.<String>;
		protected var _model : GGridModel;
		protected var _changes : GChangeList;
		protected var _onCellClick : Function;

		override protected function preinit() : void {
			_autoSize = GAutoSize.AUTO_SIZE;
			_cols = 3;
			_rows = 2;
			_hgap = _vgap = 2;
			_cell = GCell;
			_cellW = _cellH = 40;
			_changes = new GChangeList;
			_model = new GGridModel();
			_model.onChange = onModelChange;
			_cells = new Vector.<GCell>();
			callLater(initCells);
		}

		protected function initCells() : void {
			for (var r : int = 0;r < _rows;r++) {
				for (var c : int = 0;c < _cols;c++) {
					var cell : GCell = new _cell();
					cell.setSize(_cellW, _cellH);
					cell.moveTo(c * (_cellW + _hgap), r * (_cellH + _vgap));
					cell.onClick = cellClick;
					addChild(cell);
					_cells.push(cell);
				}
			}
		}

		protected function cellClick(value : GCell) : void {
			if (_onCellClick == null) {
				return;
			}
			try {
				_onCellClick.apply(null, _onCellClick.length < 1 ? null : [value]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		protected function updateHotKeys() : void {
			var index : int = 0;
			for each (var cell:GCell in _cells) {
				cell.hotKey = _hotKeys[index++];
			}
		}

		protected function onModelChange(change : GChange) : void {
			_changes.add(change);
			callLater(updateChanges);
		}

		protected function updateChanges() : void {
			var change : GChange;
			while (_changes.hasNext) {
				change = _changes.shift();
				if (change.state == GChange.RESET) {
					var index : int = 0;
					for each (var cell:GCell in _cells) {
						cell.source = _model.getAt(index++);
					}
				} else if (change.state == GChange.UPDATE) {
					_cells[change.index].source = _model.getAt(change.index);
				}
			}
		}

		public function GGrid() {
		}

		public function get model() : GGridModel {
			return _model;
		}

		public function setGap(hgap : int, vgap : int) : void {
			_hgap = hgap;
			_vgap = vgap;
		}

		public function set cell(value : Class) : void {
			_cell = value;
		}

		public function set hotKeys(value : Vector.<String>) : void {
			_hotKeys = value;
			callLater(updateHotKeys);
		}

		public function set cols(value : int) : void {
			if (_cols == value) {
				return;
			}
			_cols = value;
			callLater(initCells);
		}

		public function set rows(value : int) : void {
			if (_rows == value) {
				return;
			}
			_rows = value;
			callLater(initCells);
		}

		public function set onCellClick(value : Function) : void {
			_onCellClick = value;
		}
	}
}
