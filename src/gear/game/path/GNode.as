package gear.game.path {

	/**
	 * 地图节点
	 * 
	 * @author bright
	 * @version 20130107
	 */
	public class GNode {
		public var x : int;
		public var y : int;
		public var g : int;
		public var h : int;
		public var f : int;
		public var parent : GNode;
		public var opened : Boolean;
		public var closed : Boolean;

		public function GNode(newX:int=0,newY:int=0) {
			setTo(newX,newY);
		}

		public function setTo(newX : int, newY : int) : void {
			x = newX;
			y = newY;
			f = h = g = 0;
			parent = null;
			opened = closed = false;
		}

		public function equal(target : GNode) : Boolean {
			if (x != target.x) {
				return false;
			}
			if (y != target.y) {
				return false;
			}
			return true;
		}

		public function toString() : String {
			return "x=" + x + ",y=" + y;
		}
	}
}
