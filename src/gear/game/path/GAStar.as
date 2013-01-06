package gear.game.path {
	import gear.data.GBinaryHeap;
	import gear.utils.GMathUtil;

	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * A*寻路算法
	 * 
	 * @author bright
	 * @version  20130105
	 */
	public final class GAStar {
		protected const _dirs : Vector.<Point>=new <Point>[new Point(1, 0), new Point(1, 1), new Point(0, 1), new Point(-1, 1), new Point(-1, 0), new Point(-1, -1), new Point(0, -1), new Point(1, -1)];
		// 估价函数
		protected var _heuristic : Function;
		// 地图模型接口
		protected var _map : IGMap;
		// 起点
		protected var _start : GNode;
		// 终点
		protected var _goal : GNode;
		// 格子
		protected var _grid : Dictionary;
		// 开放表-二叉堆
		protected var _openList : GBinaryHeap;

		protected function reset() : void {
			_openList.clear();
			for each (var node:GNode in _grid) {
				GNode.pool.returnObj(node);
				delete _grid[node.x << 16 | node.y];
			}
		}

		protected function compareNode(source : GNode, target : GNode) : int {
			return source.f - target.f;
		}

		protected function checkAdjacent(source : GNode) : void {
			var target : GNode;
			var cost : int;
			for (var i : int = 0;i < 8;i++) {
				target = getNode(source.x + _dirs[i].x, source.y + _dirs[i].y);
				if (target == null || target.closed || !_map.walkable(source, target)) {
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
			return (Math.abs(_goal.x - source.x) + Math.abs(_goal.y - source.y)) * 10;
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
			if (_map.isOut(x, y)) {
				return null;
			}
			var key : int = (x << 16 | y);
			if (_grid[key] == null) {
				var node : GNode = GNode(GNode.pool.borrowObj());
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

		public function find(startX : int, startY : int, goalX : int, goalY : int) : Vector.<GNode> {
			reset();
			// 将起点放入开放表中
			_start.setTo(startX, startY);
			_openList.push(_start);
			_goal.setTo(goalX, goalY);
			var current : GNode;
			while (_openList.length > 0) {
				// 取出开放表中第一个节点
				current = _openList.shift();
				current.opened = false;
				// 终点在开放表中,路径已找到
				if (current.equal(_goal)) {
					return getPath(current);
				}
				current.closed = true;
				// 检查相邻节点
				checkAdjacent(current);
			}
			return null;
		}
	}
}