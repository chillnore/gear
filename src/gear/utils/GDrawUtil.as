package gear.utils {
	import flash.display.Graphics;
	import flash.geom.Matrix;

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

		public static function drawFillLine(g : Graphics, color : uint, alpha : Number, x : int, y : int, w : int) : void {
			g.beginFill(color, alpha);
			g.drawRect(x, y, w, 1);
			g.endFill();
		}

		public static function drawFillRect(g : Graphics, color : uint, alpha : Number, x : int, y : int, w : int, h : int) : void {
			g.beginFill(color, alpha);
			g.drawRect(x, y, w, h);
			g.endFill();
		}

		public static function drawGradientFillBorder(g : Graphics, type : String, colors : Array, alphas : Array, ratios : Array, x : int, y : int, w : int, h : int) : void {
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(14, 14, GMathUtil.angleToRadian(90), w, h);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRect(x, y, w, 1);
			g.drawRect(x, y + 1, 1, h - 2);
			g.drawRect(x + w - 1, y + 1, 1, h - 2);
			g.drawRect(x, y + h - 1, w, 1);
			g.endFill();
		}
	}
}
