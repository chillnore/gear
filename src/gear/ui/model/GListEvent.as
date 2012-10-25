package gear.ui.model {
	import flash.events.Event;

	/**
	 * List Event
	 * 
	 * @author bright
	 * @version 20100630
	 */
	public class GListEvent extends Event {
		public static const CHANGE : String = "listChange";
		private var _state : int;
		private var _index : int;
		private var _length : int;
		private var _item : Object;
		private var _oldItem : Object;

		public function GListEvent(type : String, state : int, index : int =0, length : int = -1, item : Object = null, oldItem : Object = null) {
			super(type, bubbles, cancelable);
			_state = state;
			_index = index;
			_length = length;
			_item = item;
			_oldItem = oldItem;
		}

		public function get state() : int {
			return _state;
		}

		public function get index() : int {
			return _index;
		}

		public function get length() : int {
			return _length;
		}

		public function get item() : Object {
			return _item;
		}

		public function get oldItem() : Object {
			return _oldItem;
		}

		override public function clone() : Event {
			return new GListEvent(CHANGE, _state, _index, _length, _item, _oldItem);
		}
	}
}
