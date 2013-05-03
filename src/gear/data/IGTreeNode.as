package gear.data {

	/**
	 * @author Administrator
	 */
	public interface IGTreeNode {
		function get depth() : int;

		function append(value : IGTreeNode) : void;

		function insert(value : IGTreeNode, index : int) : void;

		function remove(value : IGTreeNode) : void;

		function set parent(value : IGTreeNode) : void;

		function get parent() : IGTreeNode;

		function get childrens() : Vector.<IGTreeNode>;

		function set data(value : Object) : void;

		function get data() : Object;

		function async() : void;

		function getChildAt(index : int) : IGTreeNode;

		function get numChildren() : int;

		function set expanded(value : Boolean) : void;

		function get expanded() : Boolean;
	}
}
