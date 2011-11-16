package gear.ui.layout {
	import gear.ui.core.GBase;

	import flash.display.DisplayObject;
	import flash.geom.Point;


	/**
	 * 格子布局管理器
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GGridLayout {
		protected var _list : Array;
		protected var _start : Point;
		protected var _columns : int;
		protected var _rows : int;
		protected var _gap : int = 3;
		protected var _cellW : int;
		protected var _cellH : int;

		public function GGridLayout(start : Point, columns : int, rows : int, cellW : int, cellH : int, gap : int) {
			_list = new Array;
			_start = start;
			_columns = columns;
			_rows = rows;
			_cellW = cellW;
			_cellH = cellH;
			_gap = gap;
		}

		public function add(value : GBase) : void {
			_list.push(value);
		}

		public function remove(value : GBase) : void {
		}

		public function update() : void {
			var index : int = 0;
			for (var row : int = 0;row < _rows;row++) {
				for (var column : int = 0;column < _columns;column++) {
					if (index >= _list.length)
						break;
					var cell : DisplayObject = DisplayObject(_list[index]);
					cell.x = _start.x + column * (_cellW + _gap);
					cell.y = _start.y + row * (_cellH + _gap);
					index++;
				}
			}
		}
	}
}
