package gear.data {
	/**
	 * @author bright
	 */
	public class GTreeNode implements IGTreeNode {
		protected var _parent : IGTreeNode;
		protected var _childrens : Vector.<IGTreeNode>;
		protected var _data : Object;
		protected var _isOpen : Boolean;

		public function GTreeNode(value : Object = null) {
			_data = value;
			_childrens = new Vector.<IGTreeNode>();
			_isOpen = false;
		}

		public function set parent(value : IGTreeNode) : void {
			_parent = value;
		}

		public function get parent() : IGTreeNode {
			return _parent;
		}

		public function add(value : IGTreeNode) : void {
			_childrens.push(value);
			value.parent = this;
		}

		public function findAt(key : String, value : Object) : GTreeNode {
			for each (var node : GTreeNode in _childrens) {
				if (node.data[key] == value) {
					return node;
				}
			}
			return null;
		}

		public function getChildAt(value : int) : IGTreeNode {
			return _childrens[value];
		}

		public function get childrens() : Vector.<IGTreeNode> {
			return _childrens;
		}

		public function get numChildren() : int {
			return _childrens.length;
		}

		public function expand() : void {
		}

		public function set data(value : Object) : void {
			_data = value;
		}

		public function get data() : Object {
			return _data;
		}

		public function set isOpen(value : Boolean) : void {
			_isOpen = value;
		}

		public function get isOpen() : Boolean {
			return _isOpen;
		}
	}
}
