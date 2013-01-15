package gear.game.path {
	import gear.game.hit.GBlock;

	/**
	 * B*寻路算法
	 * 
	 * @author bright
	 * @version  20130108
	 */
	public final class GBStar {
		// 地图模型接口
		protected var _map : IGMap;
		// 碰撞
		protected var _block : GBlock;
		// 起点
		protected var _start : GNode;
		// 终点
		protected var _goal : GNode;

		public function GBStar() {
			_start = new GNode();
			_goal = new GNode();
		}

		public function set map(value : IGMap) : void {
			_map = value;
		}
		
		public function get map():IGMap{
			return _map;
		}

		public function set block(value : GBlock) : void {
			_block = value;
		}
		
		public function set start(value:GNode):void{
			_start.setTo(value.x,value.y);
		}

		public function set goal(value : GNode) : void {
			_goal.setTo(value.x, value.y);
		}

		public function replan() : void{
		}
	}
}