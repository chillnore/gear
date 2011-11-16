package gear.game {
	/**
	 * A* 寻路算法
	 * 
	 * @author bright
	 * @version  20101025
	 */
	public class AStar {
		/**
		 * 横或竖向移动一格的路径评分
		 */
		private const COST_STRAIGHT : int = 10;
		/**
		 * 斜向移动一格的路径评分
		 */
		private const COST_DIAGONAL : int = 14;
		/**
		 * 节点ID 索引
		 */
		private const NOTE_ID : int = 0;
		/**
		 * 在开启列表中
		 */
		private const NOTE_OPEN : int = 1;
		/**
		 * 在关闭列表中
		 */
		private const NOTE_CLOSED : int = 2;
		/**
		 *地图模型接口
		 */
		private var _mapModel : IMapModel;
		/**
		 * 最大尝试步数
		 */
		private var _maxTry : int;
		/**
		 * 开放表
		 */
		private var _openList : Array;
		/**
		 * 开放表计数
		 */
		private var _openCount : int;
		/**
		 * 开放表索引
		 */
		private var _openId : int;
		/**
		 * X坐标列表
		 */
		private var _xList : Array;
		/**
		 * Y坐标列表
		 */
		private var _yList : Array;
		/**
		 * 节点路径评分表
		 */
		private var _pathScoreList : Array;
		/**
		 * 移动成本表
		 */
		private var _movementCostList : Array;
		/**
		 * 父节点表
		 */
		private var _parentList : Array;
		/**
		 * 节点表
		 */
		private var _nodeMap : Array;

		private function openNode(x : int, y : int, score : int, cost : int, parentId : int) : void {
			_openCount++;
			_openId++;
			if (_nodeMap[y] == null) {
				_nodeMap[y] = [];
			}
			_nodeMap[y][x] = [];
			_nodeMap[y][x][NOTE_OPEN] = true;
			_nodeMap[y][x][NOTE_ID] = _openId;
			_xList.push(x);
			_yList.push(y);
			_pathScoreList.push(score);
			_movementCostList.push(cost);
			_parentList.push(parentId);
			_openList.push(_openId);
			aheadNode(_openCount);
		}

		private function closeNode(p_id : int) : void {
			_openCount--;
			var nodeX : int = _xList[p_id];
			var nodeY : int = _yList[p_id];
			_nodeMap[nodeY][nodeX][NOTE_OPEN] = false;
			_nodeMap[nodeY][nodeX][NOTE_CLOSED] = true;
			if (_openCount <= 0) {
				_openCount = 0;
				_openList = [];
				return;
			}
			_openList[0] = _openList.pop();
			backNode();
		}

		private function aheadNode(index : int) : void {
			var parent : int;
			var change : int;
			while (index > 1) {
				parent = index >> 1;
				if (getScore(index) < getScore(parent)) {
					change = _openList[index - 1];
					_openList[index - 1] = _openList[parent - 1];
					_openList[parent - 1] = change;
					index = parent;
				} else {
					break;
				}
			}
		}

		private function backNode() : void {
			var checkIndex : int = 1;
			var tmp : int;
			var change : int;
			while (true) {
				tmp = checkIndex;
				if (2 * tmp <= _openCount) {
					if (getScore(checkIndex) > getScore(2 * tmp)) {
						checkIndex = 2 * tmp;
					}
					if (2 * tmp + 1 <= _openCount) {
						if (getScore(checkIndex) > getScore(2 * tmp + 1)) {
							checkIndex = 2 * tmp + 1;
						}
					}
				}
				if (tmp == checkIndex) {
					break;
				} else {
					change = _openList[tmp - 1];
					_openList[tmp - 1] = _openList[checkIndex - 1];
					_openList[checkIndex - 1] = change;
				}
			}
		}

		private function isOpen(x : int, y : int) : Boolean {
			if (_nodeMap[y] == null) return false;
			if (_nodeMap[y][x] == null) return false;
			return _nodeMap[y][x][NOTE_OPEN];
		}

		private function isClosed(x : int, y : int) : Boolean {
			if (_nodeMap[y] == null) {
				return false;
			}
			if (_nodeMap[y][x] == null) {
				return false;
			}
			return _nodeMap[y][x][NOTE_CLOSED];
		}

		private function getArounds(x : int, y : int) : Array {
			var arounds : Array = [];
			var checkX : int;
			var checkY : int;
			var canDiagonal : Boolean;
			checkX = x + 1;
			checkY = y;
			var canRight : Boolean = _mapModel.canPass(x, y, checkX, checkY);
			if (canRight && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x;
			checkY = y + 1;
			var canDown : Boolean = _mapModel.canPass(x, y, checkX, checkY);
			if (canDown && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x - 1;
			checkY = y;
			var canLeft : Boolean = _mapModel.canPass(x, y, checkX, checkY);
			if (canLeft && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x;
			checkY = y - 1;
			var canUp : Boolean = _mapModel.canPass(x, y, checkX, checkY);
			if (canUp && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x + 1;
			checkY = y + 1;
			canDiagonal = _mapModel.canPass(x, y, checkX, checkY);
			if (canDiagonal && canRight && canDown && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x - 1;
			checkY = y + 1;
			canDiagonal = _mapModel.canPass(x, y, checkX, checkY);
			if (canDiagonal && canLeft && canDown && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x - 1;
			checkY = y - 1;
			canDiagonal = _mapModel.canPass(x, y, checkX, checkY);
			if (canDiagonal && canLeft && canUp && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			checkX = x + 1;
			checkY = y - 1;
			canDiagonal = _mapModel.canPass(x, y, checkX, checkY);
			if (canDiagonal && canRight && canUp && !isClosed(checkX, checkY)) {
				arounds.push([checkX, checkY]);
			}
			return arounds;
		}

		private function getPath(startX : int, startY : int, id : int) : Array {
			var path : Array = [];
			var nodeX : int = _xList[id];
			var nodeY : int = _yList[id];
			while (nodeX != startX || nodeY != startY) {
				path.unshift([nodeX, nodeY]);
				id = _parentList[id];
				nodeX = _xList[id];
				nodeY = _yList[id];
			}
			path.unshift([startX, startY]);
			return path;
		}

		private function getIndex(index : int) : int {
			var i : int = 1;
			for each (var id : int in _openList) {
				if (id == index) {
					return i;
				}
				i += 1;
			}
			return -1;
		}

		private function getScore(index : int) : int {
			return _pathScoreList[_openList[index - 1]];
		}

		private function resetLists() : void {
			_openList = [];
			_xList = [];
			_yList = [];
			_pathScoreList = [];
			_movementCostList = [];
			_parentList = [];
			_nodeMap = [];
		}

		public function AStar(mapModel : IMapModel, maxTry : int = 500) {
			_mapModel = mapModel;
			_maxTry = maxTry;
		}

		public function get maxTry() : int {
			return _maxTry;
		}

		public function set maxTry(p_value : int) : void {
			_maxTry = p_value;
		}

		/**
		 * 开始寻路
		 * @param startX
		 * @param staryY
		 * @param endX
		 * @param endY
		 * @return 路径数组
		 */
		public function find(startX : int, startY : int, endX : int, endY : int) : Array {
			if (startX == endX && startY == endY) {
				return null;
			}
			resetLists();
			_openCount = 0;
			_openId = -1;
			openNode(startX, startY, 0, 0, 0);
			var currTry : int = 0;
			var currId : int;
			var currNodeX : int;
			var currNodeY : int;
			var aroundNodes : Array;
			var checkingId : int;
			var cost : int;
			var score : int;
			while (_openCount > 0) {
				if (++currTry > _maxTry) {
					return null;
				}
				currId = _openList[0];
				closeNode(currId);
				currNodeX = _xList[currId];
				currNodeY = _yList[currId];
				if (currNodeX == endX && currNodeY == endY) {
					return getPath(startX, startY, currId);
				}
				aroundNodes = getArounds(currNodeX, currNodeY);
				for each (var node : Array in aroundNodes) {
					cost = _movementCostList[currId] + ((node[0] == currNodeX || node[1] == currNodeY) ? COST_STRAIGHT : COST_DIAGONAL);
					score = cost + (Math.abs(endX - node[0]) + Math.abs(endY - node[1])) * COST_STRAIGHT;
					if (isOpen(node[0], node[1])) {
						checkingId = _nodeMap[node[1]][node[0]][NOTE_ID];
					}
					if (cost < _movementCostList[checkingId]) {
						_movementCostList[checkingId] = cost;
						_pathScoreList[checkingId] = score;
						_parentList[checkingId] = currId;
						aheadNode(getIndex(checkingId));
					} else {
						openNode(node[0], node[1], score, cost, currId);
					}
				}
			}
			return null;
		}
	}
}