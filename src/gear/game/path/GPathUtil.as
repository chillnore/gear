package gear.game.path {

	/**
	 * @author bright
	 */
	public class GPathUtil {
		// 路径圆滑
		public static function smoothingPath(path : Vector.<GNode>) : void {
		}

		// 布雷森汉姆直线演算法
		public static function bresenhamLine(x0 : int, y0 : int, x1 : int, y1 : int) : Vector.<GNode> {
			var steep : Boolean = Math.abs(y1 - y0) > Math.abs(x1 - x0);
			var temp : int;
			if (steep) {
				temp = x0;
				x0 = y0;
				y0 = temp;
				temp = x1;
				x1 = y1;
				y1 = temp;
			}
			if (x0 > x1) {
				temp = x0;
				x0 = x1;
				x1 = temp;
				temp = y0;
				y0 = y1;
				y1 = temp;
			}
			var dx : int = x1 - x0;
			var dy : int = Math.abs(y1 - y0);
			var error : int = dx >> 1;
			var y : int = y0;
			var ystep : int = (y0 < y1) ? 1 : -1;
			var result : Vector.<GNode> = new Vector.<GNode>;
			for (var x : int = x0;x < x1;x++) {
				if (steep) {
					result.push(GNode.pool.borrowObj(y, x));
				} else {
					result.push(GNode.pool.borrowObj(x, y));
				}
				error -= dy;
				if (error < 0) {
					y += ystep;
					error += dx;
				}
			}
			return result;
		}
	}
}
