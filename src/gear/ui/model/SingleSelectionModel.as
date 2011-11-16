package gear.ui.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * Single Selecteion Model 单选模型
	 * 
	 * @author bright
	 * @version 20110628
	 */
	public class SingleSelectionModel extends EventDispatcher {
		protected var _index : int;

		public function SingleSelectionModel() {
			_index = -1;
		}

		public function set index(value : int) : void {
			if (_index == value) {
				return;
			}
			_index = value;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get index() : int {
			return _index;
		}

		public function get isSelected() : Boolean {
			return _index != -1;
		}
	}
}