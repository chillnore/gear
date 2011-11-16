package gear.render {
	import flash.display.BitmapData;
	import flash.geom.Point;

	/**
	 * 位图字体
	 * 
	 * @author bright
	 * @version 20111024
	 */
	public class Font2C extends Render2C {
		protected var _chars : Array;
		protected var _widths : Array;
		protected var _height : int;
		protected var _gap : int;
		protected var _list : BDList;
		protected var _bd : BitmapData;

		/**
		 * Font2C 位图字体
		 * 
		 * @param source AssetData
		 * @param chars Array对应的字符数组
		 * @param width int 单位宽
		 * @param height int 单位高
		 * @param gap int 间距
		 * @example 
		 * var bf:BDFont=new BDFont(new AssetData("damage_number"), ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], 11, 15);
		 * bf.x = 10;
		 * bf.y = 10;
		 * addChild(_bf);
		 * bf.text = "1234567890";
		 */
		public function Font2C(list : BDList, chars : Array, widths : Array, height : int, gap : int = 0) {
			_list = list;
			_chars = chars;
			_widths = widths;
			_height = height;
			_gap = gap;
		}

		public function set list(value : BDList) : void {
			_list = value;
		}

		/**
		 * 设置文本
		 * 
		 * @param String
		 */
		public function set text(value : String) : void {
			var unit : String;
			var index : int;
			var cut_bd : BitmapData;
			var width : int = 0;
			var bds : Array = new Array();
			for (var i : int = 0;i < value.length;i += 1) {
				unit = value.charAt(i);
				index = _chars.indexOf(unit);
				if (index != -1) {
					cut_bd = _list.getAt(index).bd;
					width += cut_bd.width;
					if (bds.length > 0) {
						width += _gap;
					}
					bds.push(cut_bd);
				}
			}
			if (_bd != null) {
				_bd.dispose();
			}
			_bd = new BitmapData(width, _height, true, 0);
			var point : Point = new Point();
			for (i = 0;i < bds.length;i += 1) {
				cut_bd = bds[i];
				_bd.copyPixels(cut_bd, cut_bd.rect, point, null, null, true);
				point.x += cut_bd.width + _gap;
			}
		}

		public function get width() : Number {
			return _bd.width;
		}

		public function get height() : Number {
			return _bd.height;
		}

		override public function render(target : BitmapData, cx : int, cy : int) : void {
			_dest.x = (_parent != null ? _parent.x : 0) + _x - cx;
			_dest.y = (_parent != null ? _parent.y : 0) + _y - cy;
			if (_scaleX != 1 || _scaleY != 1 || _alpha != 1) {
				_matrix.identity();
				_matrix.scale(_scaleX, _scaleY);
				_matrix.tx = _dest.x;
				_matrix.ty = _dest.y;
				target.draw(_bd, matrix, _ctf, null, null, true);
			} else {
				target.copyPixels(_bd, _bd.rect, _dest, null, null, true);
			}
		}

		public function clone() : Font2C {
			return new Font2C(_list, _chars, _widths, _height, _gap);
		}

		public function dispose() : void {
			if (_bd != null) {
				_bd.dispose();
				_bd = null;
			}
		}
	}
}
