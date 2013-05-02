package gear.data {
	/**
	 * @author Administrator
	 */
	public interface IGTreeNode {
		function add(value : IGTreeNode) : void;

		function set parent(value : IGTreeNode) : void;
		
		function get childrens():Vector.<IGTreeNode>;

		function set data(value : Object) : void;

		function get data() : Object;

		function expand() : void;

		function getChildAt(index : int) : IGTreeNode;

		function get numChildren() : int;

		function set isOpen(value : Boolean) : void;

		function get isOpen() : Boolean;
	}
}
