package gear.utils {
	import flash.geom.Rectangle;

	/**
	 * @author Administrator
	 */
	public class RectUtil {
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
	}
}
