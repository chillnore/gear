package gear.render {
	import gear.core.IDispose;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 位图单元
	 * 
	 * @author bright
	 * @version 20111008
	 */
	public final class BDUnit implements IDispose {
		private var _bd : BitmapData;
		private var _rect : Rectangle;

		/**
		 * 构造函数
		 * 
		 * @param offset Point 偏移坐标
		 * @param bd BitmapData 位图
		 */
		public function BDUnit(offsetX : int, offsetY : int, bd : BitmapData) {
			_bd = bd;
			_rect = _bd.rect.clone();
			_rect.x = offsetX;
			_rect.y = offsetY;
		}

		public function resetBD(dx : int, dy : int, w : int, h : int) : void {
			var bd : BitmapData = new BitmapData(w, h, true, 0);
			bd.copyPixels(_bd, _bd.rect, new Point(dx, dy));
			_bd = bd;
			_rect.x -= dx;
			_rect.y -= dy;
			_rect.width = w;
			_rect.height = h;
		}

		public function mergeBD(dx : int, dy : int, unit : BDUnit) : void {
			_bd.copyPixels(unit.bd, unit.bd.rect, new Point(dx, dy), null, null, true);
		}

		public function get offsetX() : int {
			return _rect.x;
		}

		public function get offsetY() : int {
			return _rect.y;
		}

		/**
		 * 获得位图
		 * 
		 * @return 		 
		 */
		public function get bd() : BitmapData {
			return _bd;
		}

		public function get rect() : Rectangle {
			return _rect;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void {
			_rect = null;
			if (_bd != null) {
				_bd.dispose();
				_bd = null;
			}
		}

		public function clone() : BDUnit {
			var result : BDUnit = new BDUnit(_rect.x, _rect.y, _bd.clone());
			return result;
		}
	}
}