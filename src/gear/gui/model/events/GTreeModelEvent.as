package gear.gui.model.events {
	import gear.data.IGTreeNode;

	import flash.events.Event;

	/**
	 * @author bright
	 */
	public class GTreeModelEvent extends Event {
		public static const RESET : String = "reset";
		public static const INSERT : String = "insert";
		public static const REMOVE : String = "remove";
		public var node : IGTreeNode;
		public var index : int;

		public function GTreeModelEvent(type : String, node : IGTreeNode = null, index : int = -1) {
			super(type);
			this.node = node;
			this.index = index;
		}
	}
}
