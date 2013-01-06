package gear.utils {
	import flash.display.Graphics;

	/**
	 * 绘制工具
	 * 
	 * @author bright
	 * @version 20121212
	 */
	public class GDrawUtil {
		public static function drawFillBorder(g : Graphics, color : uint, alpha : Number, x : int, y : int, w : int, h : int) : void {
			g.beginFill(color, alpha);
			g.drawRect(x, y, w, 1);
			g.drawRect(x, y + 1, 1, h - 2);
			g.drawRect(x + w - 1, y + 1, 1, h - 2);
			g.drawRect(x, y + h - 1, w, 1);
			g.endFill();
		}

		public static function drawFillRect(g : Graphics, color : uint, alpha : Number, x : int, y : int, w : int, h : int) : void {
			g.beginFill(color, alpha);
			g.drawRect(x, y, w, h);
			g.endFill();
		}

		/**
		 * 布雷森汉姆直线演算法
		 */
		public static function bresenhamLine(g : Graphics, x0 : int, y0 : int, x1 : int, y1 : int, color : int = 0, alpha : int = 1) : void {
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
			g.beginFill(color, alpha);
			for (var x : int = x0;x < x1;x++) {
				if (steep) {
					g.drawRect(y, x, 1, 1);
				} else {
					g.drawRect(x, y, 1, 1);
				}
				error -= dy;
				if (error < 0) {
					y += ystep;
					error += dx;
				}
			}
			g.endFill();
		}
	}
}
