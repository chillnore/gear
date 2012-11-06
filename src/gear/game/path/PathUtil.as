package gear.game.path {
	import gear.utils.GMathUtil;

	import flash.geom.Point;

	/**
	 * 路径工具
	 * 
	 * @author bright
	 * @version 20111205
	 */
	public class PathUtil {
		public static function lineToPath(startX : int, startY : int, endX : int, endY : int, radius : int) : Array {
			var distance : Number = GMathUtil.getDistance(startX, startY, endX, endY);
			var diameter : int = radius * 2;
			var cutX : int;
			var cutY : int;
			if (distance > diameter) {
				var count : int = Math.ceil((distance + radius) / diameter);
				var angle : int = GMathUtil.getAngle(startX, startY, endX, endY);
				cutX = Math.round(diameter * GMathUtil.cos(angle));
				cutY = Math.round(diameter * GMathUtil.sin(angle));
				var list : Array = new Array();
				for (var i : int = 0;i < count;i++) {
					list[i] = new Point(startX, startY);
					startX += cutX;
					startY += cutY;
				}
				return list;
			} else {
				return [new Point(endX, endY)];
			}
		}

		public static function toNode(halfW : int, halfH : int, startX : int, startY : int, endX : int, endY : int) : Point {
			var dx : int = endX - startX;
			var dy : int = endY - startY;
			var nx : int = dx / halfW;
			var ny : int = dy / halfH;
			return new Point(nx, ny);
		}

		public static function toXY(halfW : int, halfH : int, startX : int, startY : int, nodeX : int, nodeY : int) : Point {
			var x : int = startX + nodeX * halfW;
			var y : int = startY + nodeY * halfH;
			return new Point(x, y);
		}
	}
}
