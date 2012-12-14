package gear.data {
	import gear.core.IDispose;

	/**
	 * 二叉树结点
	 * 
	 * @author BrightLi
	 * @version 20121112
	 */
	public class GBinaryNode implements IDispose {
		protected var _parent : GBinaryNode;
		protected var _left : GBinaryNode;
		protected var _right : GBinaryNode;
		protected var _data : Object;

		public function GBinaryNode(value : Object) {
			_data = value;
		}

		public function set parent(value : GBinaryNode) : void {
			_parent = value;
		}

		public function get parent() : GBinaryNode {
			return _parent;
		}

		public function set left(value : GBinaryNode) : void {
			if (!_left) {
				_left = value;
				_left.parent = this;
			} else {
				_left.data = data;
			}
		}

		public function get left() : GBinaryNode {
			return _left;
		}

		public function set right(value : GBinaryNode) : void {
			if (!_right) {
				_right = value;
				_right.parent = this;
			} else {
				_right.data = data;
			}
		}

		public function get right() : GBinaryNode {
			return _right;
		}

		public function set data(value : Object) : void {
			_data = value;
		}

		public function get data() : Object {
			return _data;
		}

		public function isLeft() : Boolean {
			return this == parent.left;
		}

		public function isRight() : Boolean {
			return this == parent.right;
		}

		public function getDepth(node : GBinaryNode = null) : int {
			var left : int = -1, right : int = -1;
			if (node == null)
				node = this;
			if (node.left) {
				left = getDepth(node.left);
			}
			if (node.right) {
				right = getDepth(node.right);
			}
			return ((left > right ? left : right) + 1);
		}

		public function count() : int {
			var c : int = 1;
			if (left != null) {
				c += left.count();
			}
			if (right != null) {
				c += right.count();
			}
			return c;
		}

		public function dispose() : void {
			if (left != null) {
				left.dispose();
				left = null;
			}
			if (right != null) {
				right.dispose();
				right = null;
			}
		}
	}
}
