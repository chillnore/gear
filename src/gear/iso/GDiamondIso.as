package gear.iso {
	import flash.geom.Point;

	/**
	 * 菱形地图
	 * 
	 * @author bright
	 * @version 20130709
	 */
	public class GDiamondIso implements IGIsoMap {
		/**
		 * 转换菱形坐标到屏幕坐标
		 */
		public function mapToScreen(ix : int, iy : int, tw : int, th : int) : Point {
			var x : int = (ix - iy) * (tw >> 1);
			var y : int = (ix + iy) * (th >> 1);
			return new Point(x, y);
		}

		/**
		 * 转换屏幕坐标到菱形坐标
		 */
		public function screenToMap(x : int, y : int, tw : int, th : int) : Point {
			var ox : Number = x / tw ;
			var oy : Number = y / th ;
			var ix : int = Math.round(ox + oy);
			var iy : int = Math.round(oy - ox);
			return new Point(ix, iy);
		}
	}
}
