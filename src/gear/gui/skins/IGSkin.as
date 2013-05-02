package gear.gui.skins {
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	/**
	 * 皮肤接口
	 * 
	 * @author bright
	 * @version 20130415
	 */
	public interface IGSkin {
		function get scaleMode() : int;
		
		function set scale9Grid(value : Rectangle) : void;

		function addTo(parent : DisplayObjectContainer, index : int = 0) : void;

		function remove() : void;

		function moveTo(x : int, y : int) : void;

		function setSize(width : int, height : int) : void;

		function set x(value : int) : void;

		function get x() : int;

		function set y(value : int) : void;

		function get y() : int;

		function get width() : int;

		function get height() : int;

		function setAt(phase : int, bitmapData : BitmapData) : void;

		function set phase(value : int) : void;

		function set selected(value : Boolean) : void;

		function clone() : IGSkin;
	}
}
