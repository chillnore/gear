package gear.gui.core {
	import flash.events.IEventDispatcher;

	/**
	 * @author bright
	 * @version 20130314
	 */
	public interface IGBase extends IEventDispatcher {
		function set x(value : Number) : void;

		function set y(value : Number) : void;

		function get y() : Number;

		function set width(value : Number) : void;

		function get width() : Number;

		function set height(value : Number) : void;

		function get height() : Number;

		function hide() : void;

		function set source(value : *) : void;

		function get source() : *;
	}
}
