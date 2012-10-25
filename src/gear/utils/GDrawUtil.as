package gear.utils {
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 绘制工具
	 * 
	 * @version 20111206
	 * @author bright
	 */
	public class GDrawUtil {
		public static function drawLine(graphics : Graphics, sx : int, sy : int, ex : int, ey : int, color : uint = 0) : void {
			graphics.lineStyle(1, color);
			graphics.moveTo(sx, sy);
			graphics.lineTo(ex, ey);
		}

		public static function drawRoundRectComplex(graphics : Graphics, x : int, y : int, width : int, height : int, topLeftRadius : int, topRightRadius : int, bottomLeftRadius : int, bottomRightRadius : int) : void {
			var xw : int = x + width;
			var yh : int = y + height;
			var minSize : int = width < height ? width * 2 : height * 2;
			topLeftRadius = topLeftRadius < minSize ? topLeftRadius : minSize;
			topRightRadius = topRightRadius < minSize ? topRightRadius : minSize;
			bottomLeftRadius = bottomLeftRadius < minSize ? bottomLeftRadius : minSize;
			bottomRightRadius = bottomRightRadius < minSize ? bottomRightRadius : minSize;
			var a : Number = bottomRightRadius * 0.292893218813453;
			var s : Number = bottomRightRadius * 0.585786437626905;
			graphics.moveTo(xw, yh - bottomRightRadius);
			graphics.curveTo(xw, yh - s, xw - a, yh - a);
			graphics.curveTo(xw - s, yh, xw - bottomRightRadius, yh);
			a = bottomLeftRadius * 0.292893218813453;
			s = bottomLeftRadius * 0.585786437626905;
			graphics.lineTo(x + bottomLeftRadius, yh);
			graphics.curveTo(x + s, yh, x + a, yh - a);
			graphics.curveTo(x, yh - s, x, yh - bottomLeftRadius);
			a = topLeftRadius * 0.292893218813453;
			s = topLeftRadius * 0.585786437626905;
			graphics.lineTo(x, y + topLeftRadius);
			graphics.curveTo(x, y + s, x + a, y + a);
			graphics.curveTo(x + s, y, x + topLeftRadius, y);
			a = topRightRadius * 0.292893218813453;
			s = topRightRadius * 0.585786437626905;
			graphics.lineTo(xw - topRightRadius, y);
			graphics.curveTo(xw - s, y, xw - a, y + a);
			graphics.curveTo(xw, y + s, xw, y + topRightRadius);
			graphics.lineTo(xw, yh - bottomRightRadius);
		}

		public static function drawRoundRectComplex2(g : Graphics, x : Number, y : Number, width : Number, height : Number, radiusX : Number, radiusY : Number, topLeftRadiusX : Number, topLeftRadiusY : Number, topRightRadiusX : Number, topRightRadiusY : Number, bottomLeftRadiusX : Number, bottomLeftRadiusY : Number, bottomRightRadiusX : Number, bottomRightRadiusY : Number) : void {
			var xw : Number = x + width;
			var yh : Number = y + height;
			var maxXRadius : Number = width / 2;
			var maxYRadius : Number = height / 2;
			if (radiusY == 0)
				radiusY = radiusX;
			if (isNaN(topLeftRadiusX))
				topLeftRadiusX = radiusX;
			if (isNaN(topLeftRadiusY))
				topLeftRadiusY = topLeftRadiusX;
			if (isNaN(topRightRadiusX))
				topRightRadiusX = radiusX;
			if (isNaN(topRightRadiusY))
				topRightRadiusY = topRightRadiusX;
			if (isNaN(bottomLeftRadiusX))
				bottomLeftRadiusX = radiusX;
			if (isNaN(bottomLeftRadiusY))
				bottomLeftRadiusY = bottomLeftRadiusX;
			if (isNaN(bottomRightRadiusX))
				bottomRightRadiusX = radiusX;
			if (isNaN(bottomRightRadiusY))
				bottomRightRadiusY = bottomRightRadiusX;
			if (topLeftRadiusX > maxXRadius)
				topLeftRadiusX = maxXRadius;
			if (topLeftRadiusY > maxYRadius)
				topLeftRadiusY = maxYRadius;
			if (topRightRadiusX > maxXRadius)
				topRightRadiusX = maxXRadius;
			if (topRightRadiusY > maxYRadius)
				topRightRadiusY = maxYRadius;
			if (bottomLeftRadiusX > maxXRadius)
				bottomLeftRadiusX = maxXRadius;
			if (bottomLeftRadiusY > maxYRadius)
				bottomLeftRadiusY = maxYRadius;
			if (bottomRightRadiusX > maxXRadius)
				bottomRightRadiusX = maxXRadius;
			if (bottomRightRadiusY > maxYRadius)
				bottomRightRadiusY = maxYRadius;
			var aX : Number = bottomRightRadiusX * 0.292893218813453;
			var aY : Number = bottomRightRadiusY * 0.292893218813453;
			var sX : Number = bottomRightRadiusX * 0.585786437626905;
			var sY : Number = bottomRightRadiusY * 0.585786437626905;
			g.moveTo(xw, yh - bottomRightRadiusY);
			g.curveTo(xw, yh - sY, xw - aX, yh - aY);
			g.curveTo(xw - sX, yh, xw - bottomRightRadiusX, yh);
			aX = bottomLeftRadiusX * 0.292893218813453;
			aY = bottomLeftRadiusY * 0.292893218813453;
			sX = bottomLeftRadiusX * 0.585786437626905;
			sY = bottomLeftRadiusY * 0.585786437626905;
			g.lineTo(x + bottomLeftRadiusX, yh);
			g.curveTo(x + sX, yh, x + aX, yh - aY);
			g.curveTo(x, yh - sY, x, yh - bottomLeftRadiusY);
			aX = topLeftRadiusX * 0.292893218813453;
			aY = topLeftRadiusY * 0.292893218813453;
			sX = topLeftRadiusX * 0.585786437626905;
			sY = topLeftRadiusY * 0.585786437626905;
			g.lineTo(x, y + topLeftRadiusY);
			g.curveTo(x, y + sY, x + aX, y + aY);
			g.curveTo(x + sX, y, x + topLeftRadiusX, y);
			aX = topRightRadiusX * 0.292893218813453;
			aY = topRightRadiusY * 0.292893218813453;
			sX = topRightRadiusX * 0.585786437626905;
			sY = topRightRadiusY * 0.585786437626905;
			g.lineTo(xw - topRightRadiusX, y);
			g.curveTo(xw - sX, y, xw - aX, y + aY);
			g.curveTo(xw, y + sY, xw, y + topRightRadiusY);
			g.lineTo(xw, yh - bottomRightRadiusY);
		}

		public static function drawSector(g : Graphics, x : int, y : int, r : int, s : int, e : int) : void {
			if (s == e) {
				g.drawCircle(x, y, r);
				return;
			}
			var d : int = e - s;
			g.moveTo(x, y);
			var t : Point = Point.polar(r, MathUtil.angleToRadian(s));
			t.offset(x, y);
			g.lineTo(t.x, t.y);
			var da : Number = MathUtil.toUAngle(d) / 8;
			var cd : Number = r / MathUtil.cos(da * 0.5);
			var sa : Number = s;
			var c : Point;
			for (var i : int = 0;i < 8;i++) {
				sa += da;
				c = Point.polar(cd, MathUtil.angleToRadian(sa - da * 0.5));
				c.offset(x, y);
				t = Point.polar(r, MathUtil.angleToRadian(sa));
				t.offset(x, y);
				g.curveTo(c.x, c.y, t.x, t.y);
			}
			g.lineTo(x, y);
		}

		public static function drawArc(g : Graphics, x : int, y : int, radius : int, startAngle : int, endAngle : int, continueFlag : Boolean = false) : void {
			var arc : int = endAngle - startAngle;
			var segs : int = Math.ceil((arc > 0 ? arc : -arc) / 720);
			var theta : int = -arc / segs;
			var angle : int = -startAngle;
			var ax : int;
			var ay : int;
			var bx : int;
			var by : int;
			var cx : int;
			var cy : int;
			var angleMid : int;
			if (segs > 0) {
				ax = x + Math.round(MathUtil.cos(startAngle) * radius);
				ay = y + Math.round(MathUtil.sin(startAngle) * radius);
				if (continueFlag == true) {
					g.lineTo(ax, ay);
				} else {
					g.moveTo(ax, ay);
				}
				for (var i : int = 0;i < segs;i++) {
					angle += theta;
					angleMid = angle - Math.round(theta / 2);
					bx = x + Math.round(MathUtil.cos(angle) * radius);
					by = y - Math.round(MathUtil.sin(angle) * radius);
					cx = x + Math.round(MathUtil.cos(angleMid) * radius / MathUtil.cos(theta / 2));
					cy = y - Math.round(MathUtil.sin(angleMid) * radius / MathUtil.cos(theta / 2));
					g.curveTo(cx, cy, bx, by);
				}
			}
		}

		public static function drawArcTorus(g : Graphics, x : int, y : int, radius : int, startAngle : int, endAngle : int) : void {
			g.moveTo(x, y);
			drawArc(g, x, y, radius, startAngle, endAngle, true);
			g.lineTo(x, y);
		}

		public static function bresenHamLine(g : Graphics, x0 : int, y0 : int, x1 : int, y1 : int, color : int = 0, alpha : int = 1) : void {
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
			var error : int = dx / 2;
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

		public static function drawArrow(g : Graphics) : void {
			g.clear();
			g.beginFill(0xFF0000, 1);
			g.moveTo(5, 3);
			g.lineTo(27, 0);
			g.lineTo(5, -3);
			g.lineTo(5, 3);
			g.endFill();
		}

		public static function drawPixel(g : Graphics, p : Point, c : uint) : void {
			g.beginFill(c, 1);
			g.drawRect(p.x, p.y, 1, 1);
			g.endFill();
		}

		public static function drawPixelRect(g : Graphics, rect : Rectangle) : void {
			g.drawRect(rect.x, rect.y, rect.width, 1);
			g.drawRect(rect.x, rect.y + 1, 1, rect.height - 2);
			g.drawRect(rect.right - 1, rect.y + 1, 1, rect.height - 2);
			g.drawRect(rect.x, rect.bottom - 1, rect.width, 1);
		}

		public static function drawRect(g : Graphics, c : uint, a : Number, x : int, y : int, w : int, h : int) : void {
			g.beginFill(c, a);
			g.drawRect(x, y, w, h);
			g.endFill();
		}

		public static function drawFillBorder(g : Graphics, c : uint, a : Number, x : int, y : int, w : int, h : int) : void {
			g.beginFill(c, a);
			drawBorder(g, x, y, w, h);
			g.endFill();
		}

		public static function drawBorder(g : Graphics, x : int, y : int, w : int, h : int) : void {
			g.drawRect(x, y, w, 1);
			g.drawRect(x, y + 1, 1, h - 2);
			g.drawRect(x + w - 1, y + 1, 1, h - 2);
			g.drawRect(x, y + h - 1, w, 1);
		}

		public static function drawStar(graphics : Graphics, radius : Number, color : uint) : void {
			graphics.clear();
			var point : Point;
			var rotStep : Number = Math.PI / 5;
			var innerRadius : Number = radius * Math.cos(rotStep * 2);
			var halfPi : Number = Math.PI * 0.5;
			graphics.beginFill(color);
			graphics.moveTo(0, -radius);
			point = Point.polar(innerRadius, rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(radius, 2 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(innerRadius, 3 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(radius, 4 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(innerRadius, 5 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(radius, 6 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(innerRadius, 7 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(radius, 8 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			point = Point.polar(innerRadius, 9 * rotStep - halfPi);
			graphics.lineTo(point.x, point.y);
			graphics.lineTo(0, -radius);
			graphics.endFill();
		}
	}
}