package gear.utils {
	/**
	 * Game Array Util
	 * 
	 * @author BrightLi
	 * @version 20110905
	 */
	public class GArrayUtil {
		public static function shuffle(value : Array) : void {
			var source : Array = value.concat();
			var index : int;
			value.splice(0);
			while (source.length > 0) {
				index = MathUtil.random(0, source.length - 1);
				value.push(source[index]);
				source.splice(index, 1);
			}
		}

		public static function trim(value : Array) : Array {
			var list : Array = new Array();
			for each (var item:Object in value) {
				if (item != null) list.push(item);
			}
			return list;
		}

		public static function repeat(value : *, total : int) : Array {
			var list : Array = new Array();
			for (var i : int = 0;i < total;i++) {
				list.push(value);
			}
			return list;
		}

		public static function binarySearch(keys : Array, target : int) : int {
			var high : int = keys.length;
			var low : int = -1;
			while (high - low > 1) {
				var probe : int = (low + high) * 0.5;
				if (keys[probe] > target)
					high = probe;
				else
					low = probe;
			}
			if (low == -1 || keys[low] !== target)
				return -1;
			else
				return low;
		}
	}
}
