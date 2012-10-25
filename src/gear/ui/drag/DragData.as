package gear.ui.drag {
	import flash.display.DisplayObject;

	/**
	 * @version 20091215
	 * @author bright
	 */
	public class DragData {

		private var _owner : IDragTarget;

		private var _source : IDragItem;

		public var state : int;

		public var s_place : int;

		public var s_grid : int;

		private var _target : IDragItem;

		public var t_place : int;

		public var t_grid : int;

		public var split : IDragItem;

		public var splitCount : int;

		public var hitTarget : DisplayObject;

		public var stageX : int;

		public var stageY : int;

		public function DragData() {
		}

		public function reset(owner : IDragTarget,source : IDragItem) : void {
			_owner = owner;
			_source = source;
			s_place = source.place;
			s_grid = source.grid;
			target = null;
			t_place = -1;
			t_grid = -1;
			split = null;
			splitCount = 0;
			state = DragState.REMOVE;
		}

		public function get owner() : IDragTarget {
			return _owner;
		}

		public function get source() : IDragItem {
			return _source;
		}

		public function get target() : IDragItem {
			return _target;
		}

		public function set target(target : IDragItem) : void {
			_target = target;
		}
	}
}
