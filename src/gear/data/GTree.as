package gear.data {
	/**
	 * @author bright
	 */
	public class GTree {
		private var _root : GTreeNode;

		public function GTree() : void {
			_root = new GTreeNode();
		}

		public function get root() : GTreeNode {
			return _root;
		}

		public function toArray() : Array {
			var list : Array = new Array();
			var current : GTreeNode = root;
			var stack : Vector.<GTreeNode>=new Vector.<GTreeNode>();
			stack.push(current);
			var i : int;
			while (stack.length > 0) {
				current = stack.pop();
				if (current.numChildren > 0) {
					for (i = 0;i < current.numChildren;i++) {
						stack.push(current.getChildAt(i));
					}
				}
				if (current != _root) {
					list.push(current.data);
				}
			}
			list.reverse();
			return list;
		}
	}
}
