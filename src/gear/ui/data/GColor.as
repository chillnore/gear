package gear.ui.data {
	/**
	 * 状态色彩
	 * 
	 * @author bright
	 * @version 20111111
	 */
	public class GColor {
		public var upColor : int;
		public var overColor : int;
		public var downColor : int;
		public var selectedColor : uint;
		public var disabledColor : uint;

		public function clone() : GColor {
			var color : GColor = new GColor();
			color.upColor = upColor;
			color.overColor = overColor;
			color.downColor = downColor;
			color.selectedColor = selectedColor;
			color.disabledColor = disabledColor;
			return color;
		}
	}
}
