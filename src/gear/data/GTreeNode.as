package gear.data {
	/**
	 * @author bright
	 */
	public class GTreeNode implements IGTreeNode {
		protected var _parent : GTreeNode;
		protected var _childrens : Vector.<GTreeNode>;
		protected var _data : Object;

		public function GTreeNode(value : Object = null) {
			_data = value;
			_childrens = new Vector.<GTreeNode>();
		}

		public function set parent(value : GTreeNode) : void {
			_parent = value;
		}

		public function get parent() : GTreeNode {
			return _parent;
		}

		public function add(value : GTreeNode) : void {
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
	}
}
