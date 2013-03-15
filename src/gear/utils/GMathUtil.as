package gear.utils {
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * MathUtil 数学工具类
	 * 
 	 * @author bright
	 * @version 20111207
	 */
	public final class GMathUtil {
		public static const ZERO_POINT : Point = new Point(0, 0);
		private static var _cosLock : Array;
		private static var _sinLock : Array;

		public static function angleToRadian(angle : int) : Number {
			return angle * Math.PI / 180;
		}

		public static function toUAngle(angle : int) : int {
			if (angle > -1 && angle < 360) {
				return angle;
			}
			angle %= 360;
			if (angle < 0) {
				angle += 360;
			}
			return angle;
		}

		public static function cos(angle : int) : Number {
			if (GMathUtil._cosLock == null) {
				GMathUtil._cosLock = new Array(360);
				for (var i : int = 0;i < 360;i++) {
					GMathUtil._cosLock[i] = Math.cos(i * Math.PI / 180);
				}
			}
			return GMathUtil._cosLock[GMathUtil.toUAngle(angle)];
		}

		public static function sin(angle : int) : Number {
			if (GMathUtil._sinLock == null) {
				GMathUtil._sinLock = new Array(360);
				for (var i : int = 0;i < 360;i++) {
					GMathUtil._sinLock[i] = Math.sin(i * Math.PI / 180);
				}
			}
			return GMathUtil._sinLock[GMathUtil.toUAngle(angle)];
		}

		public static function toIntRect(rect : Rectangle) : Rectangle {
			rect.x = rect.x + 0.5 | 0;
			rect.y = rect.y + 0.5 | 0;
			rect.width = rect.width + 0.5 | 0;
			rect.height = rect.height + 0.5 | 0;
			return rect;
		}

		public static function min(source : int, target : int) : int {
			if (source > 0) {
				return (source < target ? source : target);
			}
			return (source > -target ? source : -target);
		}

		public static function round(value : Number) : int {
			return value + (value < 0 ? -0.5 : 0.5) | 0;
		}

		public static function ceil(value : Number) : int {
			return value > 0 ? Math.ceil(value) : -Math.ceil(-value);
		}

		public static function clamp(n : Number, min : Number, max : Number) : Number {
			if (n < min) {
				return min;
			}
			if (n > max) {
				return max;
			}
			return n;
		}

		public static function getAngle(startX : int, startY : int, endX : int, endY : int) : int {
			var dx : Number = endX - startX;
			var dy : Number = endY - startY;
			return Math.atan2(dy, dx) / Math.PI * 180 + 0.5 | 0;
		}

		public static function getTwoPointAngle(start : Point, end : Point) : int {
			var dx : Number = end.x - start.x;
			var dy : Number = end.y - start.y;
			return Math.atan2(dy, dx) / Math.PI * 180 + 0.5 | 0;
		}

		public static function getDir(startX : int, startY : int, endX : int, endY : int) : int {
			var dx : Number = endX - startX;
			var dy : Number = endY - startY;
			var angle : int = toUAngle(Math.atan2(dy, dx) / Math.PI * 180 + 0.5 | 0);
			if (angle > 337 || angle < 23) {
				return 0;
			} else if (angle > 292) {
				return 7;
			} else if (angle > 247) {
				return 6;
			} else if (angle > 202) {
				return 5;
			} else if (angle > 157) {
				return 4;
			} else if (angle > 112) {
				return 3;
			} else if (angle > 67) {
				return 2;
			} else {
				return 1;
			}
		}

		public static function getOffsetDir(dx : int, dy : int) : int {
			if (dx > 0) {
				if (dy > 0) {
					return 1;
				} else if (dy < 0) {
					return 7;
				} else {
					return 0;
				}
			} else if (dx < 0) {
				if (dy > 0) {
					return 3;
				} else if (dy < 0) {
					return 5;
				} else {
					return 4;
				}
			} else {
				if (dy > 0) {
					return 2;
				} else if (dy < 0) {
					return 6;
				}
			}
			return -1;
		}

		public static function getTurnDir(start : int, end : int) : int {
			var dir : int = start + (start < end ? ((end - start) > 4 ? -1 : 1) : ((start - end) > 4 ? 1 : -1));
			dir = dir % 8;
			if (dir < 0) {
				dir = dir + 8;
			}
			return dir;
		}

		public static function random(min : int, max : int) : int {
			if (min == max) {
				return min;
			}
			return Math.random() * (max - min) + min;
		}

		public static function randomAtArray(value : Array) : * {
			var index : int = Math.random() * (value.length - 1) + 0.5 | 0;
			return value[index];
		}

		public static function randomBoolean() : Boolean {
			var i : int = GMathUtil.random(0, 1);
			return i == 0;
		}

		public static function getDistance(startX : Number, startY : Number, endX : Number, endY : Number) : Number {
			var dx : Number = endX - startX;
			var dy : Number = endY - startY;
			return Math.sqrt(dx * dx + dy * dy);
		}

		public static function getTwoPointDistance(start : Point, end : Point) : Number {
			if (start == null || end == null)
				return 0;
			var dx : Number = end.x - start.x;
			var dy : Number = end.y - start.y;
			return Math.sqrt(dx * dx + dy * dy);
		}

		public static function rotate(x : int, y : int, angle : int, tx : int = 0, ty : int = 0) : Point {
			var xr : int = x * GMathUtil.cos(angle) - y * GMathUtil.sin(angle) + 0.5 | 0 + tx;
			var yr : int = x * GMathUtil.sin(angle) + y * GMathUtil.cos(angle) + 0.5 | 0 + ty;
			return new Point(xr, yr);
		}

		public static function getRotateMatrix(target : DisplayObject, angle : int) : void {
			var matrix : Matrix = new Matrix();
			matrix.rotate(angle * Math.PI / 180);
			var a : Point = matrix.transformPoint(new Point(0, 0));
			var b : Point = matrix.transformPoint(new Point(target.width, 0));
			var c : Point = matrix.transformPoint(new Point(target.width, target.height));
			var d : Point = matrix.transformPoint(new Point(0, target.height));
			var minX : Number = Math.min(a.x, b.x, c.x, d.x);
			var minY : Number = Math.min(a.y, b.y, c.y, d.y);
			matrix.tx += -minX;
			matrix.ty += -minY;
		}

		public static function transformRect(a : Point, b : Point, c : Point, d : Point, tx : int, ty : int) : void {
			a.x += tx;
			a.y += ty;
			b.x += tx;
			b.y += ty;
			c.x += tx;
			c.y += ty;
			d.x += tx;
			d.y += ty;
		}

		public static function getCrossAngle(source : int, target : int) : int {
			if (source == target) {
				return 0;
			}
			if (source >= 360) {
				source -= 360;
			} else if (source < 0) {
				source += 360;
			}
			if (target >= 360) {
				target -= 360;
			} else if (target < 0) {
				target += 360;
			}
			var angle : int;
			if (source < target) {
				angle = target - source;
				if (angle > 180) {
					angle = 360 - angle;
					return -angle;
				} else
					return angle;
			} else {
				angle = source - target;
				if (angle > 180) {
					angle = 360 - angle;
					return angle;
				} else {
					return -angle;
				}
			}
		}
	}
}