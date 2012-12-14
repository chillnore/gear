package gear.data {
	/**
	 * @author bright
	 */
	public class GTreeNode {
		protected var _parent : GTreeNode;
		protected var _children : Vector.<GTreeNode>;
		protected var _data : Object;

		public function GTreeNode(value : Object = null) {
			_data = value;
			_children = new Vector.<GTreeNode>();
		}

		public function set parent(value : GTreeNode) : void {
			_parent = value;
		}

		public function get parent() : GTreeNode {
			return _parent;
		}

		public function add(value : GTreeNode) : void {
			_children.push(value);
			value.parent = this;
		}

		public function findAt(key : String, value : Object) : GTreeNode {
			for each (var node:GTreeNode in _children) {
				if (node.data[key] == value) {
					return node;
				}
			}
			return null;
		}

		public function getChildAt(value : int) : GTreeNode {
			return _children[value];
		}

		public function get numChildren() : int {
			return _children.length;
		}

		public function set data(value : Object) : void {
			_data = value;
		}

		public function get data() : Object {
			return _data;
		}
	}
}
