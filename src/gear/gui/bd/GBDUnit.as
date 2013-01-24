package gear.gui.bd {
	import gear.utils.GBDUtil;
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
	public final class GBDUnit implements IDispose {
		private var _bd : BitmapData;
		private var _bound : Rectangle;

		/**
		 * 构造函数
		 * 
		 * @param offset Point 偏移坐标
		 * @param bd BitmapData 位图
		 */
		public function GBDUnit(offsetX : int, offsetY : int, bd : BitmapData) {
			_bd = bd;
			_bound = _bd.rect.clone();
			_bound.x = offsetX;
			_bound.y = offsetY;
		}

		public function resetBD(dx : int, dy : int, w : int, h : int) : void {
			var bd : BitmapData = new BitmapData(w, h, true, 0);
			bd.copyPixels(_bd, _bd.rect, new Point(dx, dy));
			_bd = bd;
			_bound.x -= dx;
			_bound.y -= dy;
			_bound.width = w;
			_bound.height = h;
		}

		public function mergeBD(dx : int, dy : int, unit : GBDUnit) : void {
			_bd.copyPixels(unit.bd, unit.bd.rect, new Point(dx, dy), null, null, true);
		}
		
		public function set scale(value:Number):void{
			_bound.x=_bound.x*value;
			_bound.y=_bound.y*value;
			_bound.width=_bound.width*value;
			_bound.height=_bound.height*value;
			if(_bd==null){
				return;
			}
			var newBD:BitmapData=GBDUtil.resizeBD(_bd,_bound.width,_bound.height);
			_bd.dispose();
			_bd=newBD;
		}

		public function get offsetX() : int {
			return _bound.x;
		}

		public function get offsetY() : int {
			return _bound.y;
		}

		/**
		 * 获得位图
		 * 
		 * @return 		 
		 */
		public function get bd() : BitmapData {
			return _bd;
		}

		public function get bound() : Rectangle {
			return _bound;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void {
			_bound = null;
			if (_bd != null) {
				_bd.dispose();
				_bd = null;
			}
		}

		public function clone() : GBDUnit {
			var result : GBDUnit = new GBDUnit(_bound.x, _bound.y, _bd.clone());
			return result;
		}
	}
}