package gear.gui.controls {
	import gear.gui.cell.GCell;
	import gear.gui.cell.IGCell;
	import gear.gui.core.GAutoSize;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.model.GChangeList;
	import gear.gui.model.GGridModel;
	import gear.gui.model.GListChange;
	import gear.gui.skins.GPanelSkin;
	import gear.gui.skins.IGSkin;
	import gear.log4a.GLogger;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * 网格控件
	 * 
	 * @author bright
	 * @version 20130327
	 */
	public class GGrid extends GBase {
		protected var _bgSkin : IGSkin;
		protected var _content : Sprite;
		protected var _vScrollBar : GVScrollBar;
		protected var _scrollRect : Rectangle;
		protected var _selectedIndex : int;
		protected var _cols : int;
		protected var _rows : int;
		protected var _hgap : int;
		protected var _vgap : int;
		protected var _cell : Class;
		protected var _template : IGCell;
		protected var _cells : Vector.<IGCell>;
		protected var _hotKeys : Vector.<String>;
		protected var _model : GGridModel;
		protected var _changes : GChangeList;
		protected var _onCellClick : Function;

		override protected function preinit() : void {
			_bgSkin = GPanelSkin.skin;
			_autoSize = GAutoSize.AUTO_SIZE;
			_scrollRect = new Rectangle();
			_selectedIndex = -1;
			_cols = 3;
			_rows = 2;
			_padding.dist = 2;
			_hgap = _vgap = 2;
			_changes = new GChangeList;
			_model = new GGridModel();
			_model.onChange = onModelChange;
			_cells = new Vector.<IGCell>();
		}

		override protected function create() : void {
			_bgSkin.addTo(this, 0);
			_content = new Sprite();
			_content.x = _padding.left;
			_content.y = _padding.right;
			addChild(_content);
			_vScrollBar = new GVScrollBar();
			_vScrollBar.visible = false;
			addChild(_vScrollBar);
			cell = GCell;
			callLater(initCells);
		}

		override protected function resize() : void {
			_bgSkin.setSize(_width, _height);
			_scrollRect.width = _width - _padding.left - _padding.right - _vScrollBar.width;
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

		protected function initCells() : void {
			for (var r : int = 0; r < _rows; r++) {
				for (var c : int = 0; c < _cols; c++) {
					var cell : IGCell = new _cell();
					cell.moveTo(c * (_template.width + _hgap), r * (_template.height + _vgap));
					cell.addEventListener(MouseEvent.MOUSE_DOWN, cell_mouseDownHandler);
					cell.addEventListener(MouseEvent.CLICK, cell_clickHandler);
					cell.source = null;
					_content.addChild(DisplayObject(cell));
					_cells.push(cell);
				}
			}
		}

		protected function cell_mouseDownHandler(event : MouseEvent) : void {
			selectedIndex = _cells.indexOf(IGCell(event.currentTarget));
		}

		protected function cell_clickHandler(event : MouseEvent) : void {
			if (_onCellClick != null) {
				try {
					_onCellClick.apply(null, _onCellClick.length < 1 ? null : [event.currentTarget]);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		protected function updateScroll() : void {
			var pageSize : int = _rows;
			var max : int = Math.max(_rows, Math.ceil(_model.length / _cols)) - pageSize;
			if (max > 0) {
				_vScrollBar.setTo(pageSize, max, _scrollRect.y);
				if (!_vScrollBar.visible) {
					_vScrollBar.visible = true;
					_vScrollBar.onValueChange = onValueChange;
				}
			} else if (_vScrollBar.visible) {
				_vScrollBar.value = 0;
				_vScrollBar.visible = false;
				_vScrollBar.onValueChange = null;
			}
		}

		protected function onValueChange() : void {
			_scrollRect.y = _vScrollBar.value * (_template.height + _vgap);
			_content.scrollRect = _scrollRect;
		}

		protected function onModelChange(change : GListChange) : void {
			_changes.add(change);
			callLater(updateChanges);
		}

		protected function updateChanges() : void {
			var change : GListChange;
			while (_changes.hasNext) {
				change = _changes.shift();
				if (change.state == GListChange.RESET) {
					updateCells();
				} else if (change.state == GListChange.UPDATE) {
					_cells[change.index].source = _model.getAt(change.index);
				}
			}
		}

		protected function updateCells() : void {
			var cr : int = Math.ceil(_cells.length / _cols);
			var mr : int = Math.max(_rows, Math.ceil(_model.length / _cols));
			if (cr != mr) {
				var r : int;
				var c : int;
				var cell : IGCell;
				if (cr < mr) {
					for (r = cr; r < mr; r++) {
						for (c = 0; c < _cols; c++) {
							cell = new _cell();
							cell.moveTo(c * (_template.width + _hgap), r * (_template.height + _vgap));
							cell.addEventListener(MouseEvent.MOUSE_DOWN, cell_mouseDownHandler);
							cell.addEventListener(MouseEvent.CLICK, cell_clickHandler);
							_content.addChild(DisplayObject(cell));
							_cells.push(cell);
						}
					}
				} else {
					for (r = mr; r < cr; r++) {
						for (c = 0; c < _cols; c++) {
							cell = _cells[r * _cols + c];
							cell.removeEventListener(MouseEvent.MOUSE_DOWN, cell_mouseDownHandler);
							cell.removeEventListener(MouseEvent.CLICK, cell_clickHandler);
							cell.hide();
						}
					}
					_cells.length = mr * _cols;
				}
			}
			for (var i : int = 0; i < _cells.length; i++) {
				_cells[i].source = _model.getAt(i);
			}
			callLater(updateScroll);
		}

		public function GGrid() {
		}

		public function set model(value : GGridModel) : void {
			if (value == null || _model == value) {
				return;
			}
			if (_model != null) {
				_model.removeOnChange(onModelChange);
			}
			_model = value;
			_model.onChange = onModelChange;
			callLater(updateCells);
		}

		public function get model() : GGridModel {
			return _model;
		}

		public function setGap(hgap : int, vgap : int) : void {
			_hgap = hgap;
			_vgap = vgap;
		}

		public function set bgSkin(value : IGSkin) : void {
			if (_bgSkin == null || _bgSkin == value) {
				return;
			}
			_bgSkin.remove();
			_bgSkin = value;
			_bgSkin.phase = (_enabled ? GPhase.UP : GPhase.DISABLED);
			_bgSkin.addTo(this, 0);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_bgSkin.width, _bgSkin.height);
			}
		}

		public function get vScrollBar() : GVScrollBar {
			return _vScrollBar;
		}

		public function set cell(value : Class) : void {
			if (value == null || !value is IGCell || _cell == value) {
				return;
			}
			_cell = value;
			_template = new _cell();
			if (_autoSize == GAutoSize.AUTO_SIZE) {
				var newW : int = _padding.left + _cols * _template.width + _hgap * (_cols - 1) + _padding.right + _vScrollBar.width;
				var newH : int = _padding.top + _rows * _template.height + _vgap * (_rows - 1) + _padding.bottom;
				forceSize(newW, newH);
				callLater(resize);
			}
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

		public function set onCellClick(value : Function) : void {
			_onCellClick = value;
		}
	}
}
