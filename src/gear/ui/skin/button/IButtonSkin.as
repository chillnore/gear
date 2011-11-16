package gear.ui.skin.button {
	import flash.display.DisplayObjectContainer;

	/**
	 * @author admin
	 */
	public interface IButtonSkin {
		function addTo(parent : DisplayObjectContainer) : void;

		function setSize(width : int, height : int) : void;

		function get width() : int;

		function get height() : int;

		function set phase(value : int) : void;

		function clone() : IButtonSkin;
	}
}
