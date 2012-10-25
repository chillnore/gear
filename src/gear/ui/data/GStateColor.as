package gear.ui.data {
	/**
	 * 状态色彩
	 * 
	 * @author bright
	 * @version 20120611
	 */
	public class GStateColor {
		public var upColor : int;
		public var overColor : int;
		public var downColor : int;
		public var selectedColor : uint;
		public var disabledColor : uint;

		public function clone() : GStateColor {
			var color : GStateColor = new GStateColor();
			color.upColor = upColor;
			color.overColor = overColor;
			color.downColor = downColor;
			color.selectedColor = selectedColor;
			color.disabledColor = disabledColor;
			return color;
		}
	}
}
