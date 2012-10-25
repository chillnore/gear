package gear.ui.drag {
	/**
	 * Inteface Drag Item
	 * 
	 * @author bright
	 * @version 20100630
	 */
	public interface IDragItem {
		function get key() : String;

		function get name() : String;

		function set count(value : int) : void;

		function get count() : int;

		function get max() : int;

		function set place(value : int) : void;

		function get place() : int;

		function set grid(value : int) : void;

		function get grid() : int;

		function merge(value : IDragItem) : Boolean;

		function canDragEnter(value : IDragItem, place : int) : Boolean;

		function split(count : int) : IDragItem;

		function syncMove(s_place : int, s_grid : int, t_place : int, t_grid : int, splitKey : String = "", splitCount : int = 0) : void;

		function syncRemove(count : int = 0, isUse : Boolean = false) : void;
	}
}