package gear.iso {
	import flash.geom.Point;

	/**
	 * @author bright
	 * @version 20130711
	 */
	public class GStaggeredIso implements IGIsoMap {
		public function mapToScreen(ix : int, iy : int, tw : int, th : int) : Point {
			var x : int = ix * tw + (iy & 1) * (tw >> 1);
			var y : int = iy * (th >> 1);
			return new Point(x, y);
		}

		public function screenToMap(x : int, y : int, tw : int, th : int) : Point {
			var iy : int = Math.round(2 * y / th);
			var ix : int = Math.round((x - (iy & 1) * (tw / 2)) / tw);
			return new Point(ix, iy);
		}
	}
}
