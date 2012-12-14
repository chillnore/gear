package gear.data {

	/**
	 * 二叉树
	 * 
	 * @author BrightLi
	 * @version 20121112
	 */
	public class GBinaryTree {

		public var root : GBinaryNode;

		public function GBinaryTree() {
		}


		public function traverse(node : GBinaryNode) : GBinaryNode {
			if(!node)return null;
			if(node.left) {
				return node.left;
			}else if(node.right) {
				return node.right;
			} else {
				var parent : GBinaryNode = node.parent;
				var next : GBinaryNode = node;
				while(parent != null && (next == parent.right || parent.right == null)) {
					next = parent;
					parent = parent.parent;
				}
				if(!parent) {
					return null;
				}
				return parent.right;
			}
		}

		public function toArray(node : GBinaryNode) : Array {
			if(node == null || root == null){
				return null;
			}
			var path : Array = new Array;
			while(node != root) {
				path.push(node.data);
				node = node.parent;
			}
			path.push(root.data);
			path.reverse();
			return path;
		}

		public function clear() : void {
			if(root != null) {
				root.dispose();
				root = null;
			}
		}
	}
}
