package gear.data {
	import gear.gui.model.IGTreeCell;
	/**
	 * 树节点
	 * 
	 * @author bright
	 * @version 20130503
	 */
	public class GTreeNode implements IGTreeNode {
		protected var _depth : int;
		protected var _parent : IGTreeNode;
		protected var _children : Vector.<IGTreeNode>;
		protected var _data : Object;
		protected var _expanded : Boolean;
		protected var _cell:IGTreeCell;

		public function GTreeNode(value : Object = null) {
			_depth = -1;
			_data = value;
			_children = new Vector.<IGTreeNode>();
			_expanded = false;
		}

		public function get depth() : int {
			return _depth;
		}

		public function set parent(value : IGTreeNode) : void {
			_parent = value;
			_depth = value.depth + 1;
		}

		public function get parent() : IGTreeNode {
			return _parent;
		}

		public function append(value : IGTreeNode) : void {
			value.parent = this;
			_children.push(value);
		}

		public function insert(value : IGTreeNode, index : int) : void {
			value.parent = this;
			_children.splice(index, 0, value);
		}

		public function remove(value : IGTreeNode) : void {
			var index : int = _children.indexOf(value);
			if (index != -1) {
				value.parent = null;
				_children.splice(index, 1);
			}
		}

		public function findAt(key : String, value : Object) : GTreeNode {
			for each (var node : GTreeNode in _children) {
				if (node.data[key] == value) {
					return node;
				}
			}
			return null;
		}

		public function getChildAt(value : int) : IGTreeNode {
			return _children[value];
		}

		public function get childrens() : Vector.<IGTreeNode> {
			return _children;
		}

		public function get numChildren() : int {
			return _children.length;
		}

		public function async() : void {
		}

		public function set data(value : Object) : void {
			_data = value;
		}

		public function get data() : Object {
			return _data;
		}

		public function set expanded(value : Boolean) : void {
			_expanded = value;
		}

		public function get expanded() : Boolean {
			return _expanded;
		}
	}
}
