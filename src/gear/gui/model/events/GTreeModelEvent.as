package gear.gui.model.events {
	import flash.events.Event;

	/**
	 * @author bright
	 */
	public class GTreeModelEvent extends Event {
		public static const RESET : String = "reset";

		public function GTreeModelEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
