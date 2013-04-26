package gear.gui.model {
	import gear.gui.model.events.GTreeModelEvent;

	import flash.events.EventDispatcher;

	import gear.data.GTreeNode;

	/**
	 * @author bright
	 * @version 20130424
	 */
	public class GTreeModel extends EventDispatcher {
		protected var _rootNode : GTreeNode;

		public function GTreeModel() {
		}

		public function set rootNode(value : GTreeNode) : void {
			_rootNode = value;
			_rootNode.expand();
			dispatchEvent(new GTreeModelEvent(GTreeModelEvent.RESET));
		}

		public function get rootNode() : GTreeNode {
			return _rootNode;
		}

		public function set onChange(value : Function) : void {
		}
	}
}