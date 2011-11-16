package gear.ui.skin.pb {
	import flash.display.DisplayObjectContainer;

	/**
	 * @author admin
	 */
	public interface IPBSkin {
		function addTo(parent : DisplayObjectContainer, mode : int, scale : int, padding : int) : void;

		function setSize(width : int, height : int) : void;

		function get width() : int;

		function get height() : int;

		function set percent(value : Number) : void;

		function set mode(value : int) : void;

		function clone() : IPBSkin;
	}
}
