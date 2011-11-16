package gear.render {
	/**
	 * DepthSort 深度排序
	 * 
	 * @author bright
	 * @version 20111027
	 */
	public class DepthSort {
		protected var _list : Vector.<Render2C>;

		private function compare(source : Render2C, target : Render2C) : int {
			var dy : int = source.y - target.y;
			if (dy != 0) {
				return dy;
			}
			return source.x - target.x;
		}

		private function getIndex(value : Render2C) : int {
			var result : int;
			var left : int = 0;
			var right : int = _list.length - 1;
			while (left <= right) {
				var mid : int = (left + right) >> 1;
				result = compare(value, _list[mid]);
				if (result > 0) {
					left = mid + 1;
				} else {
					right = mid - 1;
				}
			}
			return left;
		}
		
		public function DepthSort(value : Vector.<Render2C>) : void {
			_list = value;
		}

		public function add(value : Render2C) : void {
			_list.splice(getIndex(value), 0, value);
		}

		public function remove(value : Render2C) : void {
			_list.splice(_list.indexOf(value), 1);
		}

		public function reset(value : Render2C) : void {
			_list.splice(_list.indexOf(value), 1);
			add(value);
		}
	}
}
