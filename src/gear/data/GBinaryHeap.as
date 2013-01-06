package gear.data {
	/**
	 * 二叉堆
	 * 
	 * @author bright
	 * @version 20130104
	 * 
	 * @example
	 * <list version="3.0">
	 * var bh:GBinaryHeap=new GBinaryHeap();
	 * bh.comparse=function(source:int,target:int){
	 *     return source-target;
	 * }
	 * bh.push(3);
	 * bh.push(1);
	 * trace(bh.shift()) // 输出1
	 * </list>
	 */
	public class GBinaryHeap {
		private var _heap : Array;
		private var _compare : Function;

		public function GBinaryHeap(compare : Function) {
			_heap = new Array();
			_compare = compare;
		}

		public function get length() : int {
			return _heap.length;
		}

		public function push(value : *) : void {
			var index : int = _heap.push(value) - 1;
			var temp : *;
			while (index > 0) {
				var parent : int = ((index + 1) >> 1) - 1;
				if (_compare(_heap[index], _heap[parent]) < 0) {
					temp = _heap[index];
					_heap[index] = _heap[parent];
					_heap[parent] = temp;
					index = parent;
				} else {
					break;
				}
			}
		}

		public function shift() : * {
			if (_heap.length < 1) {
				return null;
			}
			if (_heap.length < 2) {
				return _heap.pop();
			}
			var result : * = _heap[0];
			_heap[0] = _heap.pop();
			var index : int = 0;
			var oldIndex : int;
			var child : int;
			while (true) {
				oldIndex = index;
				child = ((index + 1) << 1) - 1;
				if (child < _heap.length) {
					if (_compare(_heap[child], _heap[index]) < 0) {
						index = child;
					}
					child++;
					if (child < _heap.length && _compare(_heap[child], _heap[index]) < 0) {
						index = child;
					}
				}
				if (index != oldIndex) {
					var temp : Object = _heap[index];
					_heap[index] = _heap[oldIndex];
					_heap[oldIndex] = temp;
				} else {
					break;
				}
			}
			return result;
		}

		public function reset(value : *) : void {
			var index : int = _heap.indexOf(value);
			if (index == -1) {
				return;
			}
			var parent : *;
			var temp : *;
			while (index > 0) {
				parent = ((index + 1) >> 1) - 1;
				if (_compare(_heap[index], _heap[parent]) < 0) {
					temp = _heap[index];
					_heap[index] = _heap[parent];
					_heap[parent] = temp;
					index = parent;
				} else {
					break;
				}
			}
		}

		public function clear() : void {
			_heap.length = 0;
		}
	}
}
