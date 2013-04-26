package gear.data {
	/**
	 * @author Administrator
	 */
	public interface IGTreeNode {
		function get data():Object;
		function expand():void;
		function getChildAt(index:int):IGTreeNode;
		function get numChildren() : int;
	}
}
