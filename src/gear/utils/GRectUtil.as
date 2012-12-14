package gear.utils {
	import flash.geom.Rectangle;

	/**
	 * 矩形工具
	 * 
	 * @author brightli
	 * @version 20121107
	 */
	public final class GRectUtil {
		public static function getMaxRect(source : Rectangle, target : Rectangle) : void {
			if (source.x > target.x) {
				source.x = target.x;
			}
			if (source.y > target.y) {
				source.y = target.y;
			}
			if (source.width < target.width) {
				source.width = target.width;
			}
			if (source.height < target.height) {
				source.height = target.height;
			}
		}

		public static function overlaps(source : Rectangle, target : Rectangle) : Boolean {
			return (target.x + target.width > source.x) && (target.x < source.x + source.width) && (target.y + target.height > source.y) && (target.y < source.y + source.height);
		}

		public static function stringToRect(value : String) : Rectangle {
			var params : Array = value.split(",");
			if (params.length < 4) {
				return null;
			} else {
				return new Rectangle(params[0], params[1], params[2], params[3]);
			}
		}

		public static function rectToString(value : Rectangle) : String {
			return value.x + "," + value.y + "," + value.width + "," + value.height;
		}

		public static function flipH(source : Rectangle) : Rectangle {
			var target : Rectangle = source.clone();
			target.x = - source.x - source.width;
			return target;
		}
	}
}
