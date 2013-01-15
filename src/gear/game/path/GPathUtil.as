package gear.game.path {
	import flash.geom.Point;

	/**
	 * @author bright
	 */
	public class GPathUtil {
		public static const dirs : Vector.<Point>=new <Point>[new Point(1, 0), new Point(1, 1), new Point(0, 1), new Point(-1, 1), new Point(-1, 0), new Point(-1, -1), new Point(0, -1), new Point(1, -1)];

		// 路径圆滑
		public static function smoothingPath(path : Vector.<GNode>) : void {
			if (path.length < 3) {
				return;
			}
			var index : int = 0;
			var source : GNode = path[index];
			var target : GNode = path[++index];
			var dx : int = target.x - source.x;
			var dy : int = target.y - source.y;
			var tx : int;
			var ty : int;
			while (++index < path.length) {
				source = path[index];
				tx = source.x - target.x;
				ty = source.y - target.y;
				if (tx == dx && ty == dy) {
					path.splice(--index, 1);
				} else {
					dx = tx;
					dy = ty;
				}
				target = source;
			}
		}

		// 布雷森汉姆直线演算法
		public static function bresenhamLine(x0 : int, y0 : int, x1 : int, y1 : int) : Vector.<GNode> {
			var steep : Boolean = Math.abs(y1 - y0) > Math.abs(x1 - x0);
			var temp : int;
			var reverse : Boolean = false;
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
				reverse = true;
			}
			var dx : int = x1 - x0;
			var dy : int = Math.abs(y1 - y0);
			var error : int = dx >> 1;
			var y : int = y0;
			var ystep : int = (y0 < y1) ? 1 : -1;
			var result : Vector.<GNode> = new Vector.<GNode>;
			for (var x : int = x0;x <= x1;x++) {
				if (steep) {
					result.push(new GNode(y, x));
				} else {
					result.push(new GNode(x, y));
				}
				error -= dy;
				if (error < 0) {
					y += ystep;
					error += dx;
				}
			}
			if (reverse) {
				result.reverse();
			}
			return result;
		}
	}
}
