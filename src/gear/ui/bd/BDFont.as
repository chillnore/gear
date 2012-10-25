package gear.ui.bd {
	import gear.pool.ObjPool;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;

	import gear.core.IDispose;
	import gear.render.BDList;

	/**
	 * 位图字体
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class BDFont extends Sprite implements IDispose {
		public static const pool : ObjPool = new ObjPool(BDFont);
		private var _chars : Array;
		private var _widths : Array;
		private var _height : int;
		private var _gap : int;
		private var _list : BDList;
		private var _bitmap : Bitmap;
		private var _source : Object;

		/**
		 * Bitmap Data Font 位图字体
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
		public function BDFont(list : BDList, chars : Array, widths : Array, height : int, gap : int = 0) {
			_list = list;
			_chars = chars;
			_widths = widths;
			_height = height;
			_gap = gap;
			_bitmap = new Bitmap();
			addChild(_bitmap);
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
			for (var i : int = 0;i < value.length;i++) {
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
			var bd : BitmapData = new BitmapData(width, _height, true, 0);
			var point : Point = new Point();
			for (i = 0;i < bds.length;i++) {
				cut_bd = bds[i];
				bd.copyPixels(cut_bd, cut_bd.rect, point, null, null, true);
				point.x += cut_bd.width + _gap;
			}
			_bitmap.bitmapData = bd;
			_bitmap.smoothing = true;
		}

		/**
		 * @return 	Number
		 * 
		 */
		override public function get width() : Number {
			return _bitmap.width;
		}

		/**
		 * @return 高度
		 */
		override public function get height() : Number {
			return _bitmap.height;
		}

		/**
		 * 设置数据源
		 * 
		 * @param value 数据源
		 */
		public function set source(value : *) : void {
			_source = value;
		}

		/**
		 * 获得数据源
		 * 
		 * @return 数据源	 */
		public function get source() : * {
			return _source;
		}

		public function clone() : BDFont {
			return new BDFont(_list, _chars, _widths, _height, _gap);
		}

		/**
		 * 清除
		 */
		public function dispose() : void {
			if (_bitmap.bitmapData != null) {
				_bitmap.bitmapData.dispose();
				_bitmap.bitmapData = null;
			}
		}
	}
}
