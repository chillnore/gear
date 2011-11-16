package gear.ui.skin.tb {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 模组按钮皮肤接口
	 * 
	 * @author bright
	 * @version 20110222
	 */
	public interface IToggleButtonSkin {
		function set disabledSkin(value : DisplayObject) : void;

		function set selected(value : Boolean) : void;

		function setSize(width : int, height : int) : void;

		function get width() : int;

		function get height() : int;

		function addTo(parent : DisplayObjectContainer) : void;

		function set phase(value : int) : void;

		function clone() : IToggleButtonSkin;
	}
}
