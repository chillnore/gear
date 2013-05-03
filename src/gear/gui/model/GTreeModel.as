package gear.gui.model {
	import gear.data.IGTreeNode;
	import gear.gui.model.events.GTreeModelEvent;

	import flash.events.EventDispatcher;

	/**
	 * @author bright
	 * @version 20130424
	 */
	public class GTreeModel extends EventDispatcher {
		protected var _rootNode : IGTreeNode;

		public function GTreeModel() {
		}

		public function set rootNode(value : IGTreeNode) : void {
			_rootNode = value;
			_rootNode.async();
			dispatchEvent(new GTreeModelEvent(GTreeModelEvent.RESET));
		}

		public function get rootNode() : IGTreeNode {
			return _rootNode;
		}
		
		public function insert(node:IGTreeNode,parent:IGTreeNode,index:int):void{
			parent.insert(node,index);
			dispatchEvent(new GTreeModelEvent(GTreeModelEvent.INSERT, node,index));
		}

		public function remove(node : IGTreeNode) : void {
			if (node == null || node.parent == null) {
				return;
			}
			node.parent.remove(node);
			dispatchEvent(new GTreeModelEvent(GTreeModelEvent.REMOVE, node));
		}
	}
}