package gear.data {
	/**
	 * 二叉堆
	 * 
	 * @author bright
	 * @version 20101025
	 * 
	 * @example
	 * <list version="3.0">
	 * var bh:BinaryHeap=new BinaryHeap();
	 * bh.push(3);
	 * bh.push(1);
	 * bh.push(5);
	 * trace(bh.shift()) // 输出1
	 * </list>
	 */
	public class BinaryHeap {
		private var _heap : Array;
		private var _compare : Function;

		private function compare(source : Object, target : Object) : int {
			var s : Number = Number(source);
			var t : Number = Number(target);
			if (s < t) {
				return -1;
			} else if (s > t) {
				return 1;
			} else {
				return 0;
			}
		}

		public function BinaryHeap() {
			_heap = [null];
			_compare = compare;
		}

		public function get size() : int {
			return _heap.length - 1;
		}

		public function push(value : Object) : void {
			var index : int = _heap.push(value) - 1;
			while (index > 1) {
				var parent : int = index >> 1;
				if (_compare(_heap[index], _heap[parent]) == -1) {
					var temp : Object = _heap[index];
					_heap[index] = _heap[parent];
					_heap[parent] = temp;
					index = parent;
				} else {
					break;
				}
			}
		}

		public function shift() : Object {
			if (_heap.length < 1) {
				return null;
			}
			if (_heap.length < 2) {
				return _heap.pop();
			}
			var first : Object = _heap[1];
			_heap[1] = _heap.pop();
			var index : int = 1;
			while (true) {
				var oldIndex : int = index;
				var child : int = index << 1;
				if (child < _heap.length) {
					if (compare(_heap[child], _heap[index]) == -1) {
						index = child;
					}
					child++;
					if (child < _heap.length && compare(_heap[child], _heap[index]) == -1) {
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
			return first;
		}
	}
}
