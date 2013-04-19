package gear.utils {
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;

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
			mtx.createGradientBox(w, h, GMathUtil.angleToRadian(90), x, y);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRect(x, y, w, 1);
			g.drawRect(x, y + 1, 1, h - 2);
			g.drawRect(x + w - 1, y + 1, 1, h - 2);
			g.drawRect(x, y + h - 1, w, 1);
			g.endFill();
		}

		public static function drawGradientFillRect(g : Graphics, type : String, colors : Array, alphas : Array, ratios : Array, x : int, y : int, w : int, h : int) : void {
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(w, h, GMathUtil.angleToRadian(90), x, y);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRect(x, y, w, h);
			g.endFill();
		}

		public static function drawGradientFillRoundRect(g : Graphics, type : String, colors : Array, alphas : Array, ratios : Array, x : int, y : int, w : int, h : int, tl : int, tr : int, bl : int, br : int) : void {
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(w, h, GMathUtil.angleToRadian(90), 1, 1);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRoundRectComplex(x, y, w, h, tl, tr, bl, br);
			g.endFill();
		}

		public static function drawSector(g : Graphics, x : int, y : int, r : int, s : int, e : int) : void {
			if (s == e) {
				g.drawCircle(x, y, r);
				return;
			}
			var d : int = e - s;
			if (d > 359) {
				return;
			}
			g.moveTo(x, y);
			var t : Point = Point.polar(r, GMathUtil.angleToRadian(s));
			t.offset(x, y);
			g.lineTo(t.x, t.y);
			var da : Number = GMathUtil.toUAngle(d) / 8;
			var cd : Number = r / GMathUtil.cos(da >> 1);
			var sa : Number = s;
			var c : Point;
			for (var i : int = 0; i < 8; i++) {
				sa += da;
				c = Point.polar(cd, GMathUtil.angleToRadian(sa - (da >> 1)));
				c.offset(x, y);
				t = Point.polar(r, GMathUtil.angleToRadian(sa));
				t.offset(x, y);
				g.curveTo(c.x, c.y, t.x, t.y);
			}
			g.lineTo(x, y);
		}
	}
}
