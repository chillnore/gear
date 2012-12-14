package gear.gui.bd {
	import gear.core.IDispose;
	import gear.gui.core.GAutoSizeMode;
	import gear.gui.core.GBase;
	import gear.gui.core.GScaleMode;
	import gear.pool.GObjPool;
	import gear.render.GBDList;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;

	/**
	 * 位图字体
	 * 
	 * @author bright
	 * @version 20121212
	 */
	public final class GBDFont extends GBase implements IDispose {
		// 对象池
		public static const pool : GObjPool = new GObjPool(GBDFont);
		private var _list : GBDList;
		private var _chars : Array;
		private var _gap : int;
		private var _bitmap : Bitmap;
		private var _text : String;

		override protected function preinit() : void {
			_scaleMode = GScaleMode.FIT_SIZE;
			_autoSize = GAutoSizeMode.AUTO_SIZE;
		}

		override protected function create() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}

		protected function update() : void {
			var unit : String;
			var index : int;
			var cut_bd : BitmapData;
			var width : int = 0;
			var bds : Array = new Array();
			var i : int;
			for (i = 0;i < _text.length;i++) {
				unit = _text.charAt(i);
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
			_width=_bitmap.width;
			_height=_bitmap.height;
		}

		public function GBDFont(list : GBDList, chars : Array, gap : int = 0) {
			_list = list;
			_chars = chars;
			_gap = gap;
			_height = list.getAt(0).bd.height;
		}
		
		override public function get width():Number{
			render();
			return _width;
		}

		/**
		 * 设置文本
		 * 
		 * @param String
		 */
		public function set text(value : String) : void {
			if (_text == value) {
				return;
			}
			_text = value;
			addRender(update);
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
