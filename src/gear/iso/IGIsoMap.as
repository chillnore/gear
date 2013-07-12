package gear.iso {
	import flash.geom.Point;

	/**
	 * @author bright
	 */
	public interface IGIsoMap {
		function mapToScreen(ix : int, iy : int, tw : int, th : int) : Point;

		function screenToMap(x : int, y : int, tw : int, th : int) : Point;
	}
}
