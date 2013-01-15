package gear.game.path {
	import gear.game.hit.GBlock;
	import gear.data.GBinaryHeap;
	import gear.utils.GMathUtil;

	import flash.utils.Dictionary;

	/**
	 * A*寻路算法
	 * 
	 * @author bright
	 * @version  20130108
	 */
	public final class GAStar {
		// 估价函数
		protected var _heuristic : Function;
		// 地图模型接口
		protected var _map : IGMap;
		// 碰撞
		protected var _block : GBlock;
		// 起点
		protected var _start : GNode;
		// 终点
		protected var _goal : GNode;
		// 格子
		protected var _grid : Dictionary;
		// 开放表-二叉堆
		protected var _openList : GBinaryHeap;

		protected function clear() : void {
			_openList.clear();
			for each (var node:GNode in _grid) {
				delete _grid[node.x+"_"+node.y];
			}
		}

		protected function compareNode(source : GNode, target : GNode) : int {
			return source.f - target.f;
		}

		protected function checkAdjacent(source : GNode) : void {
			var target : GNode;
			var cost : int;
			for (var i : int = 0;i < 8;i++) {
				target = getNode(source.x + GPathUtil.dirs[i].x, source.y + GPathUtil.dirs[i].y);
				if (target == null || target.closed || !_map.walkable(_block, source, target)) {
					continue;
				}
				cost = source.g + (source.x == target.x || source.y == target.y ? 10 : 14);
				if (!target.opened) {
					target.opened = true;
					target.parent = source;
					target.g = cost;
					target.h = _heuristic(target);
					target.f = target.g + target.h;
					_openList.push(target);
				} else if (cost < target.g) {
					target.parent = source;
					target.g = cost;
					target.f = target.g + target.h;
					_openList.reset(target);
				}
			}
		}

		// 曼哈顿
		protected function manhattan(source : GNode) : int {
			var dx : int = _goal.x - source.x;
			if (dx < 0) {
				dx = -dx;
			}
			var dy : int = _goal.y - source.y;
			if (dy < 0) {
				dy = -dy;
			}
			return (dx + dy) * 10;
		}

		// 欧氏
		protected function euclidian(source : GNode) : int {
			return GMathUtil.getDistance(source.x, source.y, _goal.x, _goal.y) * 10;
		}

		// 对角线估价
		protected function diagonal(source : GNode) : int {
			var dx : int = Math.abs(_goal.x - source.x);
			var dy : int = Math.abs(_goal.y - source.y);
			var diag : int = Math.min(dx, dy);
			var straight : int = dx + dy;
			return diag * 14 + (straight - (diag << 1)) * 10;
		}

		// 获得节点
		protected function getNode(x : int, y : int) : GNode {
			if (_map.isOut(_block, x, y)) {
				return null;
			}
			var key:String=x+"_"+y;
			if (_grid[key] == null) {
				var node : GNode = new GNode();
				node.setTo(x, y);
				_grid[key] = node ;
			}
			return _grid[key];
		}

		// 获得路径
		protected function getPath(node : GNode) : Vector.<GNode> {
			var path : Vector.<GNode>=new Vector.<GNode>();
			while (node != null) {
				path.push(node);
				node = node.parent;
			}
			return path.reverse();
		}

		public function GAStar() {
			_heuristic = manhattan;
			_grid = new Dictionary();
			_openList = new GBinaryHeap(compareNode);
			_start = new GNode();
			_goal = new GNode();
		}

		public function set map(value : IGMap) : void {
			_map = value;
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

		public function replan() : Vector.<GNode> {
			// 将起点放入开放表中
			_openList.push(_start);
			var current : GNode;
			while (_openList.length > 0) {
				// 取出开放表中第一个节点
				current = _openList.shift();
				current.opened = false;
				// 终点在开放表中,路径已找到
				if (current.equal(_goal)) {
					clear();
					return getPath(current);
				}
				current.closed = true;
				// 检查相邻节点
				checkAdjacent(current);
			}
			clear();
			return null;
		}
	}
}