package gear.utils {
	import flash.display.GradientType;
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

		public static function drawFillRect(g : Graphics, color : uint, alpha : Number, x : int, y : int, w : int, h : int) : void {
			g.beginFill(color, alpha);
			g.drawRect(x, y, w, h);
			g.endFill();
		}

		public static function drawGradientFillBorder(g : Graphics, colors : Array, x : int, y : int, w : int, h : int, alphas : Array = null, ratios : Array = null, type : String = GradientType.LINEAR) : void {
			if (alphas == null) {
				alphas = [1, 1];
			}
			if (ratios == null) {
				ratios = [0, 255];
			}
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(w, h, GMathUtil.angleToRadian(90), x, y);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRect(x, y, w, 1);
			g.drawRect(x, y + 1, 1, h - 2);
			g.drawRect(x + w - 1, y + 1, 1, h - 2);
			g.drawRect(x, y + h - 1, w, 1);
			g.endFill();
		}

		public static function drawGradientFillRect(g : Graphics, colors : Array, x : int, y : int, w : int, h : int, alphas : Array = null, ratios : Array = null, angle : int = 90, type : String = GradientType.LINEAR) : void {
			if (alphas == null) {
				alphas = [1, 1];
			}
			if (ratios == null) {
				ratios = [0, 255];
			}
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(w, h, GMathUtil.angleToRadian(angle), x, y);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRect(x, y, w, h);
			g.endFill();
		}

		public static function drawGradientFillRoundRect(g : Graphics, colors : Array, x : int, y : int, w : int, h : int, tl : int, tr : int, bl : int, br : int, alphas : Array = null, ratios : Array = null, angle : int = 90, type : String = GradientType.LINEAR) : void {
			if (alphas == null) {
				alphas = [1, 1];
			}
			if (ratios == null) {
				ratios = [0, 255];
			}
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(w, h, GMathUtil.angleToRadian(angle), x, y);
			g.beginGradientFill(type, colors, alphas, ratios, mtx);
			g.drawRoundRectComplex(x, y, w, h, tl, tr, bl, br);
			g.endFill();
		}

		public static function drawUpArrow(g : Graphics, color : uint, x : int, y : int, w : int, h : int) : void {
			var commands : Vector.<int>=new <int>[1, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[x + w * 0.5, y, x + w, y + h, x, y + h, x + w * 0.5, y];
			g.beginFill(color, 1);
			g.drawPath(commands, data);
			g.endFill();
			return;
		}

		public static function drawDownArrow(g : Graphics, color : uint, x : int, y : int, w : int, h : int) : void {
			var commands : Vector.<int>=new <int>[1, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[x, y, x + w * 0.5, y + h, x + w, y, x, y];
			g.beginFill(color, 1);
			g.drawPath(commands, data);
			g.endFill();
			return;
		}

		public static function drawLeftArrow(g : Graphics, color : uint, x : int, y : int, w : int, h : int) : void {
			var commands : Vector.<int>=new <int>[1, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[x + w, y, x + w, y + h, x, y + h * 0.5, x + w, y];
			g.beginFill(color, 1);
			g.drawPath(commands, data);
			g.endFill();
			return;
		}

		public static function drawRightArrow(g : Graphics, color : uint, x : int, y : int, w : int, h : int) : void {
			var commands : Vector.<int>=new <int>[1, 2, 2, 2];
			var data : Vector.<Number>=new <Number>[x, y, x + w, y + h * 0.5, x, y + h, x, y];
			g.beginFill(color, 1);
			g.drawPath(commands, data);
			g.endFill();
			return;
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

		/**
		 * 绘制菱形
		 */
		public static function drawDiamond(x : int, y : int, tw : int, th : int, g : Graphics) : void {
			var halfW : int = tw / 2;
			var halfH : int = th / 2;
			g.lineStyle(1, 0, 1);
			g.drawPath(new <int>[1, 2, 2, 2, 2], new <Number>[x, y - halfH, x + halfW, y, x, y + halfH, x - halfW, y, x, y - halfH]);
		}
	}
}
