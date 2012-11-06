package gear.ui.drag {
	import gear.ui.controls.GIcon;

	/**
	 * @version 20091101
	 * @author bright
	 */
	public interface IDragSource {
		function get dragImage() : GIcon;

		function canDrag() : Boolean;

		function get source() : *
	}
}
